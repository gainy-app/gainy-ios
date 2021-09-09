// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SearchTickersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchTickers($text: String!) {
      tickers(where: {_or: [{name: {_ilike: $text}}, {description: {_ilike: $text}}]}) {
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
        GraphQLField("tickers", arguments: ["where": ["_or": [["name": ["_ilike": GraphQLVariable("text")]], ["description": ["_ilike": GraphQLVariable("text")]]]]], type: .nonNull(.list(.nonNull(.object(Ticker.selections))))),
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
            GraphQLField("net_profit_margin", type: .scalar(Double.self)),
            GraphQLField("sma_30days", type: .scalar(numeric.self)),
            GraphQLField("market_cap_cagr_1years", type: .scalar(numeric.self)),
            GraphQLField("enterprise_value_to_sales", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(peRatio: Double? = nil, marketCapitalization: Double? = nil, highlight: String? = nil, dividendGrowth: float8? = nil, symbol: String? = nil, createdAt: timestamptz? = nil, netProfitMargin: Double? = nil, sma_30days: numeric? = nil, marketCapCagr_1years: numeric? = nil, enterpriseValueToSales: String? = nil) {
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

        public var sma_30days: numeric? {
          get {
            return resultMap["sma_30days"] as? numeric
          }
          set {
            resultMap.updateValue(newValue, forKey: "sma_30days")
          }
        }

        public var marketCapCagr_1years: numeric? {
          get {
            return resultMap["market_cap_cagr_1years"] as? numeric
          }
          set {
            resultMap.updateValue(newValue, forKey: "market_cap_cagr_1years")
          }
        }

        public var enterpriseValueToSales: String? {
          get {
            return resultMap["enterprise_value_to_sales"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "enterprise_value_to_sales")
          }
        }
      }
    }
  }
}
