// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchStockMedianQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchStockMedian($symbol: String!, $day: String!, $week: String!, $month: String!) {
      tickers(where: {symbol: {_eq: $symbol}}) {
        __typename
        ticker_industries {
          __typename
          gainy_industry {
            __typename
            industry_stats_dailies(where: {date: {_gte: $day}}) {
              __typename
              median_growth_rate_1d
              median_price
              date
            }
            ticker_industry_median_1w(where: {date: {_gte: $week}}) {
              __typename
              median_growth_rate
              median_price
              date
            }
            ticker_industry_median_1m(where: {date: {_gte: $month}}) {
              __typename
              median_growth_rate
              median_price
              date
            }
          }
        }
      }
    }
    """

  public let operationName: String = "FetchStockMedian"

  public var symbol: String
  public var day: String
  public var week: String
  public var month: String

  public init(symbol: String, day: String, week: String, month: String) {
    self.symbol = symbol
    self.day = day
    self.week = week
    self.month = month
  }

  public var variables: GraphQLMap? {
    return ["symbol": symbol, "day": day, "week": week, "month": month]
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
              GraphQLField("industry_stats_dailies", arguments: ["where": ["date": ["_gte": GraphQLVariable("day")]]], type: .nonNull(.list(.nonNull(.object(IndustryStatsDaily.selections))))),
              GraphQLField("ticker_industry_median_1w", arguments: ["where": ["date": ["_gte": GraphQLVariable("week")]]], type: .nonNull(.list(.nonNull(.object(TickerIndustryMedian_1w.selections))))),
              GraphQLField("ticker_industry_median_1m", arguments: ["where": ["date": ["_gte": GraphQLVariable("month")]]], type: .nonNull(.list(.nonNull(.object(TickerIndustryMedian_1m.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(industryStatsDailies: [IndustryStatsDaily], tickerIndustryMedian_1w: [TickerIndustryMedian_1w], tickerIndustryMedian_1m: [TickerIndustryMedian_1m]) {
            self.init(unsafeResultMap: ["__typename": "gainy_industries", "industry_stats_dailies": industryStatsDailies.map { (value: IndustryStatsDaily) -> ResultMap in value.resultMap }, "ticker_industry_median_1w": tickerIndustryMedian_1w.map { (value: TickerIndustryMedian_1w) -> ResultMap in value.resultMap }, "ticker_industry_median_1m": tickerIndustryMedian_1m.map { (value: TickerIndustryMedian_1m) -> ResultMap in value.resultMap }])
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

          /// An array relationship
          public var tickerIndustryMedian_1w: [TickerIndustryMedian_1w] {
            get {
              return (resultMap["ticker_industry_median_1w"] as! [ResultMap]).map { (value: ResultMap) -> TickerIndustryMedian_1w in TickerIndustryMedian_1w(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: TickerIndustryMedian_1w) -> ResultMap in value.resultMap }, forKey: "ticker_industry_median_1w")
            }
          }

          /// An array relationship
          public var tickerIndustryMedian_1m: [TickerIndustryMedian_1m] {
            get {
              return (resultMap["ticker_industry_median_1m"] as! [ResultMap]).map { (value: ResultMap) -> TickerIndustryMedian_1m in TickerIndustryMedian_1m(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: TickerIndustryMedian_1m) -> ResultMap in value.resultMap }, forKey: "ticker_industry_median_1m")
            }
          }

          public struct IndustryStatsDaily: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["industry_stats_daily"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("median_growth_rate_1d", type: .scalar(float8.self)),
                GraphQLField("median_price", type: .scalar(float8.self)),
                GraphQLField("date", type: .scalar(date.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(medianGrowthRate_1d: float8? = nil, medianPrice: float8? = nil, date: date? = nil) {
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

            public var date: date? {
              get {
                return resultMap["date"] as? date
              }
              set {
                resultMap.updateValue(newValue, forKey: "date")
              }
            }
          }

          public struct TickerIndustryMedian_1w: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["industry_median_1w"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("median_growth_rate", type: .scalar(float8.self)),
                GraphQLField("median_price", type: .scalar(float8.self)),
                GraphQLField("date", type: .scalar(date.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(medianGrowthRate: float8? = nil, medianPrice: float8? = nil, date: date? = nil) {
              self.init(unsafeResultMap: ["__typename": "industry_median_1w", "median_growth_rate": medianGrowthRate, "median_price": medianPrice, "date": date])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var medianGrowthRate: float8? {
              get {
                return resultMap["median_growth_rate"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "median_growth_rate")
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

            public var date: date? {
              get {
                return resultMap["date"] as? date
              }
              set {
                resultMap.updateValue(newValue, forKey: "date")
              }
            }
          }

          public struct TickerIndustryMedian_1m: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["industry_median_1m"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("median_growth_rate", type: .scalar(float8.self)),
                GraphQLField("median_price", type: .scalar(float8.self)),
                GraphQLField("date", type: .scalar(date.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(medianGrowthRate: float8? = nil, medianPrice: float8? = nil, date: date? = nil) {
              self.init(unsafeResultMap: ["__typename": "industry_median_1m", "median_growth_rate": medianGrowthRate, "median_price": medianPrice, "date": date])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var medianGrowthRate: float8? {
              get {
                return resultMap["median_growth_rate"] as? float8
              }
              set {
                resultMap.updateValue(newValue, forKey: "median_growth_rate")
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

            public var date: date? {
              get {
                return resultMap["date"] as? date
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
