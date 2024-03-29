// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CollectionDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query CollectionDetails {
      app_collections {
        __typename
        id
        image_url
        name
        description
        collection_symbols_aggregate {
          __typename
          aggregate {
            __typename
            count
          }
        }
        collection_symbols {
          __typename
          ticker {
            __typename
            symbol
            name
            description
            ticker_financials {
              __typename
              price_change_today
              current_price
              dividend_growth
              price_to_earnings
              market_cap
              highlight
            }
          }
        }
      }
    }
    """

  public let operationName: String = "CollectionDetails"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_collections", type: .nonNull(.list(.nonNull(.object(AppCollection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appCollections: [AppCollection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_collections": appCollections.map { (value: AppCollection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.collections"
    public var appCollections: [AppCollection] {
      get {
        return (resultMap["app_collections"] as! [ResultMap]).map { (value: ResultMap) -> AppCollection in AppCollection(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppCollection) -> ResultMap in value.resultMap }, forKey: "app_collections")
      }
    }

    public struct AppCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("image_url", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("collection_symbols_aggregate", type: .nonNull(.object(CollectionSymbolsAggregate.selections))),
          GraphQLField("collection_symbols", type: .nonNull(.list(.nonNull(.object(CollectionSymbol.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, imageUrl: String, name: String, description: String? = nil, collectionSymbolsAggregate: CollectionSymbolsAggregate, collectionSymbols: [CollectionSymbol]) {
        self.init(unsafeResultMap: ["__typename": "app_collections", "id": id, "image_url": imageUrl, "name": name, "description": description, "collection_symbols_aggregate": collectionSymbolsAggregate.resultMap, "collection_symbols": collectionSymbols.map { (value: CollectionSymbol) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var imageUrl: String {
        get {
          return resultMap["image_url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image_url")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// An aggregate relationship
      public var collectionSymbolsAggregate: CollectionSymbolsAggregate {
        get {
          return CollectionSymbolsAggregate(unsafeResultMap: resultMap["collection_symbols_aggregate"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "collection_symbols_aggregate")
        }
      }

      /// An array relationship
      public var collectionSymbols: [CollectionSymbol] {
        get {
          return (resultMap["collection_symbols"] as! [ResultMap]).map { (value: ResultMap) -> CollectionSymbol in CollectionSymbol(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: CollectionSymbol) -> ResultMap in value.resultMap }, forKey: "collection_symbols")
        }
      }

      public struct CollectionSymbolsAggregate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_collection_symbols_aggregate"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("aggregate", type: .object(Aggregate.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(aggregate: Aggregate? = nil) {
          self.init(unsafeResultMap: ["__typename": "app_collection_symbols_aggregate", "aggregate": aggregate.flatMap { (value: Aggregate) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var aggregate: Aggregate? {
          get {
            return (resultMap["aggregate"] as? ResultMap).flatMap { Aggregate(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "aggregate")
          }
        }

        public struct Aggregate: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["app_collection_symbols_aggregate_fields"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("count", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(count: Int) {
            self.init(unsafeResultMap: ["__typename": "app_collection_symbols_aggregate_fields", "count": count])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var count: Int {
            get {
              return resultMap["count"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "count")
            }
          }
        }
      }

      public struct CollectionSymbol: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_collection_symbols"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("ticker", type: .nonNull(.object(Ticker.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(ticker: Ticker) {
          self.init(unsafeResultMap: ["__typename": "app_collection_symbols", "ticker": ticker.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// An object relationship
        public var ticker: Ticker {
          get {
            return Ticker(unsafeResultMap: resultMap["ticker"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "ticker")
          }
        }

        public struct Ticker: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["tickers"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("symbol", type: .scalar(String.self)),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("description", type: .scalar(String.self)),
              GraphQLField("ticker_financials", type: .nonNull(.list(.nonNull(.object(TickerFinancial.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(symbol: String? = nil, name: String? = nil, description: String? = nil, tickerFinancials: [TickerFinancial]) {
            self.init(unsafeResultMap: ["__typename": "tickers", "symbol": symbol, "name": name, "description": description, "ticker_financials": tickerFinancials.map { (value: TickerFinancial) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var symbol: String? {
            get {
              return resultMap["symbol"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          /// An array relationship
          public var tickerFinancials: [TickerFinancial] {
            get {
              return (resultMap["ticker_financials"] as! [ResultMap]).map { (value: ResultMap) -> TickerFinancial in TickerFinancial(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: TickerFinancial) -> ResultMap in value.resultMap }, forKey: "ticker_financials")
            }
          }

          public struct TickerFinancial: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["ticker_financials"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("price_change_today", type: .nonNull(.scalar(Double.self))),
                GraphQLField("current_price", type: .nonNull(.scalar(Double.self))),
                GraphQLField("dividend_growth", type: .nonNull(.scalar(String.self))),
                GraphQLField("price_to_earnings", type: .nonNull(.scalar(Double.self))),
                GraphQLField("market_cap", type: .nonNull(.scalar(String.self))),
                GraphQLField("highlight", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(priceChangeToday: Double, currentPrice: Double, dividendGrowth: String, priceToEarnings: Double, marketCap: String, highlight: String) {
              self.init(unsafeResultMap: ["__typename": "ticker_financials", "price_change_today": priceChangeToday, "current_price": currentPrice, "dividend_growth": dividendGrowth, "price_to_earnings": priceToEarnings, "market_cap": marketCap, "highlight": highlight])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var priceChangeToday: Double {
              get {
                return resultMap["price_change_today"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "price_change_today")
              }
            }

            public var currentPrice: Double {
              get {
                return resultMap["current_price"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "current_price")
              }
            }

            public var dividendGrowth: String {
              get {
                return resultMap["dividend_growth"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "dividend_growth")
              }
            }

            public var priceToEarnings: Double {
              get {
                return resultMap["price_to_earnings"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "price_to_earnings")
              }
            }

            public var marketCap: String {
              get {
                return resultMap["market_cap"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "market_cap")
              }
            }

            public var highlight: String {
              get {
                return resultMap["highlight"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "highlight")
              }
            }
          }
        }
      }
    }
  }
}
