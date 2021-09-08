// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DiscoverCollectionDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query DiscoverCollectionDetails {
      collections {
        __typename
        id
        image_url
        name
        description
        ticker_collections_aggregate {
          __typename
          aggregate {
            __typename
            count
          }
        }
        ticker_collections {
          __typename
          ticker {
            __typename
            symbol
            name
            description
            ticker_financials {
              __typename
              pe_ratio
              market_capitalization
              highlight
              dividend_growth
              symbol
              created_at
            }
          }
        }
      }
    }
    """

  public let operationName: String = "DiscoverCollectionDetails"

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
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("image_url", type: .scalar(String.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("ticker_collections_aggregate", type: .nonNull(.object(TickerCollectionsAggregate.selections))),
          GraphQLField("ticker_collections", type: .nonNull(.list(.nonNull(.object(TickerCollection.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int? = nil, imageUrl: String? = nil, name: String? = nil, description: String? = nil, tickerCollectionsAggregate: TickerCollectionsAggregate, tickerCollections: [TickerCollection]) {
        self.init(unsafeResultMap: ["__typename": "collections", "id": id, "image_url": imageUrl, "name": name, "description": description, "ticker_collections_aggregate": tickerCollectionsAggregate.resultMap, "ticker_collections": tickerCollections.map { (value: TickerCollection) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var imageUrl: String? {
        get {
          return resultMap["image_url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image_url")
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

      /// An aggregate relationship
      public var tickerCollectionsAggregate: TickerCollectionsAggregate {
        get {
          return TickerCollectionsAggregate(unsafeResultMap: resultMap["ticker_collections_aggregate"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "ticker_collections_aggregate")
        }
      }

      /// An array relationship
      public var tickerCollections: [TickerCollection] {
        get {
          return (resultMap["ticker_collections"] as! [ResultMap]).map { (value: ResultMap) -> TickerCollection in TickerCollection(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: TickerCollection) -> ResultMap in value.resultMap }, forKey: "ticker_collections")
        }
      }

      public struct TickerCollectionsAggregate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_collections_aggregate"]

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
          self.init(unsafeResultMap: ["__typename": "ticker_collections_aggregate", "aggregate": aggregate.flatMap { (value: Aggregate) -> ResultMap in value.resultMap }])
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
          public static let possibleTypes: [String] = ["ticker_collections_aggregate_fields"]

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
            self.init(unsafeResultMap: ["__typename": "ticker_collections_aggregate_fields", "count": count])
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

      public struct TickerCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("ticker", type: .object(Ticker.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(ticker: Ticker? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_collections", "ticker": ticker.flatMap { (value: Ticker) -> ResultMap in value.resultMap }])
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
        public var ticker: Ticker? {
          get {
            return (resultMap["ticker"] as? ResultMap).flatMap { Ticker(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "ticker")
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
                GraphQLField("pe_ratio", type: .scalar(Double.self)),
                GraphQLField("market_capitalization", type: .scalar(Double.self)),
                GraphQLField("highlight", type: .scalar(String.self)),
                GraphQLField("dividend_growth", type: .scalar(float8.self)),
                GraphQLField("symbol", type: .scalar(String.self)),
                GraphQLField("created_at", type: .scalar(timestamptz.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(peRatio: Double? = nil, marketCapitalization: Double? = nil, highlight: String? = nil, dividendGrowth: float8? = nil, symbol: String? = nil, createdAt: timestamptz? = nil) {
              self.init(unsafeResultMap: ["__typename": "ticker_financials", "pe_ratio": peRatio, "market_capitalization": marketCapitalization, "highlight": highlight, "dividend_growth": dividendGrowth, "symbol": symbol, "created_at": createdAt])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var peRatio: Double? {
              get {
                return resultMap["pe_ratio"] as? Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "pe_ratio")
              }
            }

            public var marketCapitalization: Double? {
              get {
                return resultMap["market_capitalization"] as? Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "market_capitalization")
              }
            }

            public var highlight: String? {
              get {
                return resultMap["highlight"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "highlight")
              }
            }

            public var dividendGrowth: float8? {
              get {
                return resultMap["dividend_growth"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "dividend_growth")
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

            public var createdAt: timestamptz? {
              get {
                return resultMap["created_at"] as? timestamptz
              }
              set {
                resultMap.updateValue(newValue, forKey: "created_at")
              }
            }
          }
        }
      }
    }
  }
}
