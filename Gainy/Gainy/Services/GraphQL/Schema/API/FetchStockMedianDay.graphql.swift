// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchStockMedianDayQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchStockMedianDay($symbol: String!, $date: timestamp!) {
      tickers(where: {symbol: {_eq: $symbol}}) {
        __typename
        ticker_industries {
          __typename
          gainy_industry {
            __typename
            industry_stats_dailies(where: {date: {_gte: $date}}) {
              __typename
              median_growth_rate_1d
              median_price
              date
            }
          }
        }
      }
    }
    """

  public let operationName: String = "FetchStockMedianDay"

  public var symbol: String
  public var date: timestamp

  public init(symbol: String, date: timestamp) {
    self.symbol = symbol
    self.date = date
  }

  public var variables: GraphQLMap? {
    return ["symbol": symbol, "date": date]
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
          GraphQLField("ticker_industries", type: .nonNull(.list(.nonNull(.object(TickerIndustry.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(tickerIndustries: [TickerIndustry]) {
        self.init(unsafeResultMap: ["__typename": "tickers", "ticker_industries": tickerIndustries.map { (value: TickerIndustry) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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
              GraphQLField("industry_stats_dailies", arguments: ["where": ["date": ["_gte": GraphQLVariable("date")]]], type: .nonNull(.list(.nonNull(.object(IndustryStatsDaily.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(industryStatsDailies: [IndustryStatsDaily]) {
            self.init(unsafeResultMap: ["__typename": "gainy_industries", "industry_stats_dailies": industryStatsDailies.map { (value: IndustryStatsDaily) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// An array relationship
          public var industryStatsDailies: [IndustryStatsDaily] {
            get {
              return (resultMap["industry_stats_dailies"] as! [ResultMap]).map { (value: ResultMap) -> IndustryStatsDaily in IndustryStatsDaily(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: IndustryStatsDaily) -> ResultMap in value.resultMap }, forKey: "industry_stats_dailies")
            }
          }

          public struct IndustryStatsDaily: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["industry_stats_daily"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("median_growth_rate_1d", type: .scalar(float8.self)),
                GraphQLField("median_price", type: .scalar(float8.self)),
                GraphQLField("date", type: .scalar(timestamp.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(medianGrowthRate_1d: float8? = nil, medianPrice: float8? = nil, date: timestamp? = nil) {
              self.init(unsafeResultMap: ["__typename": "industry_stats_daily", "median_growth_rate_1d": medianGrowthRate_1d, "median_price": medianPrice, "date": date])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var medianGrowthRate_1d: float8? {
              get {
                return resultMap["median_growth_rate_1d"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "median_growth_rate_1d")
              }
            }

            public var medianPrice: float8? {
              get {
                return resultMap["median_price"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "median_price")
              }
            }

            public var date: timestamp? {
              get {
                return resultMap["date"] as? timestamp
              }
              set {
                resultMap.updateValue(newValue, forKey: "date")
              }
            }
          }
        }
      }
    }
  }
}
