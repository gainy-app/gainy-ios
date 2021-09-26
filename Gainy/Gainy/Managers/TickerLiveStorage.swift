//
//  TickerLiveStorage.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.09.2021.
//

import UIKit
import Cache

typealias LivePrice = FetchLiveTickersDataQuery.Data.FetchLivePrice

struct CachedLivePrice: Codable {
    let symbol: String
    let dateTime: String
    let currentPrice: Float
    let priceChangeToday: Float
    
    init(remotePrice: LivePrice) {
        symbol = remotePrice.symbol ?? ""
        dateTime = remotePrice.datetime ?? ""
        currentPrice = Float(remotePrice.close ?? 0.0) + Float(remotePrice.dailyChange ?? 0.0)
        priceChangeToday = Float(remotePrice.dailyChangeP ?? 0.0)
    }
    
}

final class TickerLiveStorage {
    
    //inner class
    
    
    static let shared: TickerLiveStorage = {
        let shared = TickerLiveStorage()
        
        return shared
    }()
    
    private let serialQueue = DispatchQueue.init(label: "TickerLiveStorage")
    private var storage: Storage<String, CachedLivePrice>?
    
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

        storage = try? Storage<String, CachedLivePrice>(
          diskConfig: diskConfig,
          memoryConfig: memoryConfig,
          transformer: TransformerFactory.forCodable(ofType: CachedLivePrice.self) // Storage<String, User>
        )
        
        _ = storage?.addStorageObserver(self) { observer, storage, change in
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
            print("Removed expired")
          }
        }
    }
    
    
    @Atomic
    private var tickerKeys: [String] = []
 
    //MARK: - Public
    
    func missingSymbolsFrom(_ fullReq: [String], inProgress: Set<String>) -> [String] {
        let storedSet = Set(tickerKeys)
        let searchSet = Set(fullReq)
        let loadSet = Set(inProgress)
        return Array(searchSet.subtracting(storedSet).subtracting(loadSet))
    }
    
    func haveSymbol(_ symbol: String) -> Bool {
        ((try? storage?.existsObject(forKey: symbol) ?? false) != nil)
    }
    
    func getSymbolData(_ symbol: String) -> CachedLivePrice? {
        serialQueue.sync {            
            return try? storage?.object(forKey: symbol)
        }
    }
    
    func setSymbolData(_ symbol: String, data: LivePrice) {
        serialQueue.sync {
            guard !symbol.isEmpty else {return}
            try? storage?.setObject(CachedLivePrice(remotePrice: data), forKey: symbol)
        }
    }
}
