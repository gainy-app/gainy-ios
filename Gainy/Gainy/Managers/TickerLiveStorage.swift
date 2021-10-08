//
//  TickerLiveStorage.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.09.2021.
//

import UIKit
import Cache

typealias LivePrice = FetchLiveTickersDataQuery.Data.FetchLivePrice

final class TickerLiveStorage {
        
    
    static let shared: TickerLiveStorage = {
        let shared = TickerLiveStorage()
        
        return shared
    }()
    
    private let dataQueue = DispatchQueue.init(label: "TickerLiveStorage")
    private var dataStorage: Storage<String, CachedLivePrice>?
    
    private let matchesQueue = DispatchQueue.init(label: "TickerLiveMatchStorage")
    private var matchesStorage: Storage<String, CachedMatchScore>?
    
    //MARK: - Inner
    
    init() {
        let diskConfig = DiskConfig(name: "SmallCache")
        let memoryConfig = MemoryConfig(
          // Expiry date that will be applied by default for every added object
          // if it's not overridden in the `setObject(forKey:expiry:)` method
          expiry: .date(Date().addingTimeInterval(15*60)),
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
          diskConfig: diskConfig,
          memoryConfig: memoryLongConfig,
          transformer: TransformerFactory.forCodable(ofType: CachedMatchScore.self) // Storage<String, User>
        )
        
        _ = dataStorage?.addStorageObserver(self) { observer, storage, change in
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
            dprint("Removed expired")
          }
        }
    }
    
    
    @Atomic
    private var tickerKeys: [String] = []
 
    //MARK: - Tickers Data
    
    func missingSymbolsFrom(_ fullReq: [String], inProgress: Set<String>) -> [String] {
        let storedSet = Set(tickerKeys)
        let searchSet = Set(fullReq)
        let loadSet = Set(inProgress)
        return Array(searchSet.subtracting(storedSet).subtracting(loadSet))
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
    }
}
