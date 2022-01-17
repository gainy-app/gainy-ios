//
//  TickerLiveStorage.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.09.2021.
//

import UIKit
import Cache
import Combine

typealias RealtimePrice = RemoteTickerDetails.RealtimeMetric
typealias LivePrice = FetchLiveTickersDataQuery.Data.Ticker.RealtimeMetric

final class TickerLiveStorage {
        
    
    static let shared: TickerLiveStorage = {
        let shared = TickerLiveStorage()
        
        return shared
    }()
    
    private let dataQueue = DispatchQueue.init(label: "TickerLiveStorage")
    private var dataStorage: Storage<String, CachedLivePrice>?
    
    private let matchesQueue = DispatchQueue.init(label: "TickerLiveMatchStorage")
    private var matchesStorage: Storage<String, CachedMatchScore>?
    private var token: ObservationToken?
    
    var collectionsMatchScores: CollectionsScores = [:]
    
    //MARK: - Inner
    
    init() {
        let diskConfig = DiskConfig(name: "SmallCache")
        let diskConfigLong = DiskConfig(
          // The name of disk storage, this will be used as folder name within directory
          name: "Floppy",
          // Expiry date that will be applied by default for every added object
          // if it's not overridden in the `setObject(forKey:expiry:)` method
          expiry: .seconds(60 * 15),
          // Maximum size of the disk cache storage (in bytes)
          maxSize: 1000,
          // Where to store the disk cache. If nil, it is placed in `cachesDirectory` directory.
          directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
            appropriateFor: nil, create: true).appendingPathComponent("MatchScoreCache"),
          // Data protection is used to store files in an encrypted format on disk and to decrypt them on demand
          protectionType: .complete
        )
        let memoryConfig = MemoryConfig(
          // Expiry date that will be applied by default for every added object
          // if it's not overridden in the `setObject(forKey:expiry:)` method
          expiry: .seconds(60 * 15),
          /// The maximum number of objects in memory the cache should hold
          countLimit: 5000,
          /// The maximum total cost that the cache can hold before it starts evicting objects
          totalCostLimit: 0
        )
        
        let memoryLongConfig = MemoryConfig(
          // Expiry date that will be applied by default for every added object
          // if it's not overridden in the `setObject(forKey:expiry:)` method
          expiry: .never,
          /// The maximum number of objects in memory the cache should hold
          countLimit: 5000,
          /// The maximum total cost that the cache can hold before it starts evicting objects
          totalCostLimit: 0
        )

        dataStorage = try? Storage<String, CachedLivePrice>(
          diskConfig: diskConfig,
          memoryConfig: memoryConfig,
          transformer: TransformerFactory.forCodable(ofType: CachedLivePrice.self) // Storage<String, User>
        )
        
        matchesStorage = try? Storage<String, CachedMatchScore>(
          diskConfig: diskConfigLong,
          memoryConfig: memoryLongConfig,
          transformer: TransformerFactory.forCodable(ofType: CachedMatchScore.self) // Storage<String, User>
        )
        
        token = dataStorage?.addStorageObserver(self) { observer, storage, change in
          switch change {
          case .add(let key):
              self.tickerKeys.append(key)
          case .remove(let key):
              if let keyIdnex = self.tickerKeys.firstIndex(of: key) {
                  self.tickerKeys.remove(at: keyIdnex)
              }
          case .removeAll:
              self.tickerKeys.removeAll()
          case .removeExpired:
            break
          }
        }
    }
    
    
    @Atomic
    private var tickerKeys: [String] = []
 
    //MARK: - Informing
    
    private let matchScoreCleared: PassthroughSubject<Void, Never> = PassthroughSubject()
    
    var matchScoreClearedPublisher: AnyPublisher<Void, Never> {
        matchScoreCleared.share().eraseToAnyPublisher()
    }
    
    //MARK: - Tickers Data
    
    func clearAllExpiredLiveData() {
        try? dataStorage?.removeExpiredObjects()
    }
    
    func clearAllLiveData() {
        try? dataStorage?.removeAll()
    }
    
    func missingSymbolsFrom(_ fullReq: [String], inProgress: Set<String>) -> [String] {
        //let storedSet = Set(tickerKeys)
        let searchSet = Set(fullReq)
        return Array(searchSet)
    }
    
    func haveSymbol(_ symbol: String) -> Bool {
        let isExist = try? dataStorage?.existsObject(forKey: symbol)
        return (isExist ?? false)
    }
    
    func getSymbolData(_ symbol: String) -> CachedLivePrice? {
        dataQueue.sync {
            return try? dataStorage?.object(forKey: symbol)
        }
    }
    
    func setSymbolData(_ symbol: String, data: LivePrice) {
        dataQueue.sync {
            guard !symbol.isEmpty else {return}
            try? dataStorage?.setObject(CachedLivePrice(remotePrice: data), forKey: symbol)
        }
    }
    
    func setSymbolData(_ symbol: String, data: RealtimePrice) {
        dataQueue.sync {
            guard !symbol.isEmpty else {return}
            try? dataStorage?.setObject(CachedLivePrice(remotePrice: data), forKey: symbol)
        }
    }    
    
    //MARK: - Match Score Data
    
    func haveMatchScore(_ symbol: String) -> Bool {
        let isExist = try? matchesStorage?.existsObject(forKey: symbol)
        return (isExist ?? false)
    }
    
    func getMatchData(_ symbol: String) -> CachedMatchScore? {
        matchesQueue.sync {
            return try? matchesStorage?.object(forKey: symbol)
        }
    }
    
    func setMatchData(_ symbol: String, data: LiveMatch) {
        matchesQueue.sync {
            guard !symbol.isEmpty else {return}
            try? matchesStorage?.setObject(CachedMatchScore(remoteMatch: data), forKey: symbol)
        }
    }
    
    func clearMatchData() {
        try? matchesStorage?.removeAll()
        matchScoreCleared.send()
    }
}
