// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetTickerExtraDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTickerExtraDetails($symbol: String!) {
      tickers(where: {symbol: {_eq: $symbol}}) {
        __typename
        description
        ticker_financials {
          __typename
          symbol
          created_at
        }
        ticker_categories {
          __typename
          categories {
            __typename
            name
            icon_url
          }
        }
        ticker_interests {
          __typename
          symbol
          interest_id
          interest {
            __typename
            icon_url
            id
            name
          }
        }
        ticker_industries {
          __typename
          gainy_industry {
            __typename
            id
            name
          }
        }
        ticker_events {
          __typename
          created_at
          description
          symbol
          type
          timestamp
        }
        ticker_analyst_ratings {
          __typename
          target_price
          strong_buy
          buy
          hold
          sell
          strong_sell
          rating
        }
      }
    }
    """

  public let operationName: String = "GetTickerExtraDetails"

  public var symbol: String

  public init(symbol: String) {
    self.symbol = symbol
  }

  public var variables: GraphQLMap? {
    return ["symbol": symbol]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("tickers", arguments: ["where": ["symbol": ["_eq": GraphQLVariable("symbol")]]], type: .nonNull(.list(.nonNull(.object(Ticker.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickers: [Ticker]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "tickers": tickers.map { (value: Ticker) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "tickers"
    public var tickers: [Ticker] {
      get {
        return (resultMap["tickers"] as! [ResultMap]).map { (value: ResultMap) -> Ticker in Ticker(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Ticker) -> ResultMap in value.resultMap }, forKey: "tickers")
      }
    }

    public struct Ticker: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["tickers"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("ticker_financials", type: .nonNull(.list(.nonNull(.object(TickerFinancial.selections))))),
          GraphQLField("ticker_categories", type: .nonNull(.list(.nonNull(.object(TickerCategory.selections))))),
          GraphQLField("ticker_interests", type: .nonNull(.list(.nonNull(.object(TickerInterest.selections))))),
          GraphQLField("ticker_industries", type: .nonNull(.list(.nonNull(.object(TickerIndustry.selections))))),
          GraphQLField("ticker_events", type: .nonNull(.list(.nonNull(.object(TickerEvent.selections))))),
          GraphQLField("ticker_analyst_ratings", type: .object(TickerAnalystRating.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(description: String? = nil, tickerFinancials: [TickerFinancial], tickerCategories: [TickerCategory], tickerInterests: [TickerInterest], tickerIndustries: [TickerIndustry], tickerEvents: [TickerEvent], tickerAnalystRatings: TickerAnalystRating? = nil) {
        self.init(unsafeResultMap: ["__typename": "tickers", "description": description, "ticker_financials": tickerFinancials.map { (value: TickerFinancial) -> ResultMap in value.resultMap }, "ticker_categories": tickerCategories.map { (value: TickerCategory) -> ResultMap in value.resultMap }, "ticker_interests": tickerInterests.map { (value: TickerInterest) -> ResultMap in value.resultMap }, "ticker_industries": tickerIndustries.map { (value: TickerIndustry) -> ResultMap in value.resultMap }, "ticker_events": tickerEvents.map { (value: TickerEvent) -> ResultMap in value.resultMap }, "ticker_analyst_ratings": tickerAnalystRatings.flatMap { (value: TickerAnalystRating) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      /// An array relationship
      public var tickerCategories: [TickerCategory] {
        get {
          return (resultMap["ticker_categories"] as! [ResultMap]).map { (value: ResultMap) -> TickerCategory in TickerCategory(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: TickerCategory) -> ResultMap in value.resultMap }, forKey: "ticker_categories")
        }
      }

      /// An array relationship
      public var tickerInterests: [TickerInterest] {
        get {
          return (resultMap["ticker_interests"] as! [ResultMap]).map { (value: ResultMap) -> TickerInterest in TickerInterest(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: TickerInterest) -> ResultMap in value.resultMap }, forKey: "ticker_interests")
        }
      }

      /// An array relationship
      public var tickerIndustries: [TickerIndustry] {
        get {
          return (resultMap["ticker_industries"] as! [ResultMap]).map { (value: ResultMap) -> TickerIndustry in TickerIndustry(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: TickerIndustry) -> ResultMap in value.resultMap }, forKey: "ticker_industries")
        }
      }

      /// An array relationship
      public var tickerEvents: [TickerEvent] {
        get {
          return (resultMap["ticker_events"] as! [ResultMap]).map { (value: ResultMap) -> TickerEvent in TickerEvent(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: TickerEvent) -> ResultMap in value.resultMap }, forKey: "ticker_events")
        }
      }

      /// An object relationship
      public var tickerAnalystRatings: TickerAnalystRating? {
        get {
          return (resultMap["ticker_analyst_ratings"] as? ResultMap).flatMap { TickerAnalystRating(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "ticker_analyst_ratings")
        }
      }

      public struct TickerFinancial: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_financials"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("symbol", type: .scalar(String.self)),
            GraphQLField("created_at", type: .scalar(timestamptz.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(symbol: String? = nil, createdAt: timestamptz? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_financials", "symbol": symbol, "created_at": createdAt])
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

        public var createdAt: timestamptz? {
          get {
            return resultMap["created_at"] as? timestamptz
          }
          set {
            resultMap.updateValue(newValue, forKey: "created_at")
          }
        }
      }

      public struct TickerCategory: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_categories"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("categories", type: .object(Category.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(categories: Category? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_categories", "categories": categories.flatMap { (value: Category) -> ResultMap in value.resultMap }])
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
        public var categories: Category? {
          get {
            return (resultMap["categories"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "categories")
          }
        }

        public struct Category: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["categories"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("icon_url", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String? = nil, iconUrl: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "categories", "name": name, "icon_url": iconUrl])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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

          public var iconUrl: String? {
            get {
              return resultMap["icon_url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "icon_url")
            }
          }
        }
      }

      public struct TickerInterest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_interests"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("symbol", type: .scalar(String.self)),
            GraphQLField("interest_id", type: .scalar(Int.self)),
            GraphQLField("interest", type: .object(Interest.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(symbol: String? = nil, interestId: Int? = nil, interest: Interest? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_interests", "symbol": symbol, "interest_id": interestId, "interest": interest.flatMap { (value: Interest) -> ResultMap in value.resultMap }])
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

        public var interestId: Int? {
          get {
            return resultMap["interest_id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "interest_id")
          }
        }

        /// An object relationship
        public var interest: Interest? {
          get {
            return (resultMap["interest"] as? ResultMap).flatMap { Interest(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "interest")
          }
        }

        public struct Interest: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["interests"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("icon_url", type: .scalar(String.self)),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(iconUrl: String? = nil, id: Int? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "interests", "icon_url": iconUrl, "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var iconUrl: String? {
            get {
              return resultMap["icon_url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "icon_url")
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

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct TickerIndustry: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_industries"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("gainy_industry", type: .object(GainyIndustry.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(gainyIndustry: GainyIndustry? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_industries", "gainy_industry": gainyIndustry.flatMap { (value: GainyIndustry) -> ResultMap in value.resultMap }])
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
        public var gainyIndustry: GainyIndustry? {
          get {
            return (resultMap["gainy_industry"] as? ResultMap).flatMap { GainyIndustry(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "gainy_industry")
          }
        }

        public struct GainyIndustry: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["gainy_industries"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "gainy_industries", "id": id, "name": name])
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

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct TickerEvent: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_events"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("created_at", type: .scalar(timestamptz.self)),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("symbol", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("timestamp", type: .scalar(timestamptz.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(createdAt: timestamptz? = nil, description: String? = nil, symbol: String? = nil, type: String? = nil, timestamp: timestamptz? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_events", "created_at": createdAt, "description": description, "symbol": symbol, "type": type, "timestamp": timestamp])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var description: String? {
          get {
            return resultMap["description"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
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

        public var type: String? {
          get {
            return resultMap["type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var timestamp: timestamptz? {
          get {
            return resultMap["timestamp"] as? timestamptz
          }
          set {
            resultMap.updateValue(newValue, forKey: "timestamp")
          }
        }
      }

      public struct TickerAnalystRating: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["analyst_ratings"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("target_price", type: .scalar(float8.self)),
            GraphQLField("strong_buy", type: .scalar(Int.self)),
            GraphQLField("buy", type: .scalar(Int.self)),
            GraphQLField("hold", type: .scalar(Int.self)),
            GraphQLField("sell", type: .scalar(Int.self)),
            GraphQLField("strong_sell", type: .scalar(Int.self)),
            GraphQLField("rating", type: .scalar(float8.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(targetPrice: float8? = nil, strongBuy: Int? = nil, buy: Int? = nil, hold: Int? = nil, sell: Int? = nil, strongSell: Int? = nil, rating: float8? = nil) {
          self.init(unsafeResultMap: ["__typename": "analyst_ratings", "target_price": targetPrice, "strong_buy": strongBuy, "buy": buy, "hold": hold, "sell": sell, "strong_sell": strongSell, "rating": rating])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var targetPrice: float8? {
          get {
            return resultMap["target_price"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "target_price")
          }
        }

        public var strongBuy: Int? {
          get {
            return resultMap["strong_buy"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "strong_buy")
          }
        }

        public var buy: Int? {
          get {
            return resultMap["buy"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "buy")
          }
        }

        public var hold: Int? {
          get {
            return resultMap["hold"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "hold")
          }
        }

        public var sell: Int? {
          get {
            return resultMap["sell"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "sell")
          }
        }

        public var strongSell: Int? {
          get {
            return resultMap["strong_sell"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "strong_sell")
          }
        }

        public var rating: float8? {
          get {
            return resultMap["rating"] as? float8
          }
          set {
            resultMap.updateValue(newValue, forKey: "rating")
          }
        }
      }
    }
  }
}
