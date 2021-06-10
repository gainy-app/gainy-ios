// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CollectionDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query CollectionDetails {
      collections {
        __typename
        id
        image
        name
        description
        stocks_count
        collection_tickers_symbols {
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
        GraphQLField("collections", type: .nonNull(.list(.nonNull(.object(Collection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collections: [Collection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collections": collections.map { (value: Collection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "collections"
    public var collections: [Collection] {
      get {
        return (resultMap["collections"] as! [ResultMap]).map { (value: ResultMap) -> Collection in Collection(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Collection) -> ResultMap in value.resultMap }, forKey: "collections")
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("image", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("stocks_count", type: .nonNull(.scalar(String.self))),
          GraphQLField("collection_tickers_symbols", type: .nonNull(.list(.nonNull(.object(CollectionTickersSymbol.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, image: String, name: String, description: String, stocksCount: String, collectionTickersSymbols: [CollectionTickersSymbol]) {
        self.init(unsafeResultMap: ["__typename": "collections", "id": id, "image": image, "name": name, "description": description, "stocks_count": stocksCount, "collection_tickers_symbols": collectionTickersSymbols.map { (value: CollectionTickersSymbol) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var image: String {
        get {
          return resultMap["image"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
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

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var stocksCount: String {
        get {
          return resultMap["stocks_count"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "stocks_count")
        }
      }

      /// An array relationship
      public var collectionTickersSymbols: [CollectionTickersSymbol] {
        get {
          return (resultMap["collection_tickers_symbols"] as! [ResultMap]).map { (value: ResultMap) -> CollectionTickersSymbol in CollectionTickersSymbol(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: CollectionTickersSymbol) -> ResultMap in value.resultMap }, forKey: "collection_tickers_symbols")
        }
      }

      public struct CollectionTickersSymbol: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["collection_tickers_symbols"]

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
          self.init(unsafeResultMap: ["__typename": "collection_tickers_symbols", "ticker": ticker.resultMap])
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
              GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("description", type: .nonNull(.scalar(String.self))),
              GraphQLField("ticker_financials", type: .nonNull(.list(.nonNull(.object(TickerFinancial.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(symbol: String, name: String, description: String, tickerFinancials: [TickerFinancial]) {
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

          public var symbol: String {
            get {
              return resultMap["symbol"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "symbol")
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

          public var description: String {
            get {
              return resultMap["description"]! as! String
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

public final class DiscoverCollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query DiscoverCollections {
      collections {
        __typename
        id
        image
        name
        description
        stocks_count
        favorite_collections {
          __typename
          is_default
        }
      }
    }
    """

  public let operationName: String = "DiscoverCollections"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collections", type: .nonNull(.list(.nonNull(.object(Collection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collections: [Collection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collections": collections.map { (value: Collection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "collections"
    public var collections: [Collection] {
      get {
        return (resultMap["collections"] as! [ResultMap]).map { (value: ResultMap) -> Collection in Collection(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Collection) -> ResultMap in value.resultMap }, forKey: "collections")
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("image", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("stocks_count", type: .nonNull(.scalar(String.self))),
          GraphQLField("favorite_collections", type: .nonNull(.list(.nonNull(.object(FavoriteCollection.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, image: String, name: String, description: String, stocksCount: String, favoriteCollections: [FavoriteCollection]) {
        self.init(unsafeResultMap: ["__typename": "collections", "id": id, "image": image, "name": name, "description": description, "stocks_count": stocksCount, "favorite_collections": favoriteCollections.map { (value: FavoriteCollection) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var image: String {
        get {
          return resultMap["image"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
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

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var stocksCount: String {
        get {
          return resultMap["stocks_count"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "stocks_count")
        }
      }

      /// An array relationship
      public var favoriteCollections: [FavoriteCollection] {
        get {
          return (resultMap["favorite_collections"] as! [ResultMap]).map { (value: ResultMap) -> FavoriteCollection in FavoriteCollection(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: FavoriteCollection) -> ResultMap in value.resultMap }, forKey: "favorite_collections")
        }
      }

      public struct FavoriteCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["favorite_collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("is_default", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(isDefault: Bool) {
          self.init(unsafeResultMap: ["__typename": "favorite_collections", "is_default": isDefault])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var isDefault: Bool {
          get {
            return resultMap["is_default"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "is_default")
          }
        }
      }
    }
  }
}
