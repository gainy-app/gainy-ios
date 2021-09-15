// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SearchTickersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchTickers($text: String!) {
      tickers(
        where: {_or: [{name: {_ilike: $text}}, {description: {_ilike: $text}}, {symbol: {_ilike: $text}}]}
        limit: 50
      ) {
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
          net_profit_margin
          sma_30days
          market_cap_cagr_1years
          enterprise_value_to_sales
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
      }
    }
    """

  public let operationName: String = "SearchTickers"

  public var text: String

  public init(text: String) {
    self.text = text
  }

  public var variables: GraphQLMap? {
    return ["text": text]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("tickers", arguments: ["where": ["_or": [["name": ["_ilike": GraphQLVariable("text")]], ["description": ["_ilike": GraphQLVariable("text")]], ["symbol": ["_ilike": GraphQLVariable("text")]]]], "limit": 50], type: .nonNull(.list(.nonNull(.object(Ticker.selections))))),
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
          GraphQLField("symbol", type: .scalar(String.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("ticker_financials", type: .nonNull(.list(.nonNull(.object(TickerFinancial.selections))))),
          GraphQLField("ticker_interests", type: .nonNull(.list(.nonNull(.object(TickerInterest.selections))))),
          GraphQLField("ticker_industries", type: .nonNull(.list(.nonNull(.object(TickerIndustry.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(symbol: String? = nil, name: String? = nil, description: String? = nil, tickerFinancials: [TickerFinancial], tickerInterests: [TickerInterest], tickerIndustries: [TickerIndustry]) {
        self.init(unsafeResultMap: ["__typename": "tickers", "symbol": symbol, "name": name, "description": description, "ticker_financials": tickerFinancials.map { (value: TickerFinancial) -> ResultMap in value.resultMap }, "ticker_interests": tickerInterests.map { (value: TickerInterest) -> ResultMap in value.resultMap }, "ticker_industries": tickerIndustries.map { (value: TickerIndustry) -> ResultMap in value.resultMap }])
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
            GraphQLField("net_profit_margin", type: .scalar(Double.self)),
            GraphQLField("sma_30days", type: .scalar(Double.self)),
            GraphQLField("market_cap_cagr_1years", type: .scalar(Double.self)),
            GraphQLField("enterprise_value_to_sales", type: .scalar(Double.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(peRatio: Double? = nil, marketCapitalization: Double? = nil, highlight: String? = nil, dividendGrowth: float8? = nil, symbol: String? = nil, createdAt: timestamptz? = nil, netProfitMargin: Double? = nil, sma_30days: Double? = nil, marketCapCagr_1years: Double? = nil, enterpriseValueToSales: Double? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_financials", "pe_ratio": peRatio, "market_capitalization": marketCapitalization, "highlight": highlight, "dividend_growth": dividendGrowth, "symbol": symbol, "created_at": createdAt, "net_profit_margin": netProfitMargin, "sma_30days": sma_30days, "market_cap_cagr_1years": marketCapCagr_1years, "enterprise_value_to_sales": enterpriseValueToSales])
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

        public var netProfitMargin: Double? {
          get {
            return resultMap["net_profit_margin"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "net_profit_margin")
          }
        }

        public var sma_30days: Double? {
          get {
            return resultMap["sma_30days"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "sma_30days")
          }
        }

        public var marketCapCagr_1years: Double? {
          get {
            return resultMap["market_cap_cagr_1years"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "market_cap_cagr_1years")
          }
        }

        public var enterpriseValueToSales: Double? {
          get {
            return resultMap["enterprise_value_to_sales"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "enterprise_value_to_sales")
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
    }
  }
}
