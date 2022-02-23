// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchAltStocksQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchAltStocks($symbol: String!) {
      ticker_industries(where: {symbol: {_eq: $symbol}}) {
        __typename
        gainy_industry {
          __typename
          name
          ticker_industries {
            __typename
            ticker {
              __typename
              ...RemoteTickerDetails
            }
          }
        }
      }
    }
    """

  public let operationName: String = "FetchAltStocks"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteTickerDetails.fragmentDefinition)
    return document
  }

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
        GraphQLField("ticker_industries", arguments: ["where": ["symbol": ["_eq": GraphQLVariable("symbol")]]], type: .nonNull(.list(.nonNull(.object(TickerIndustry.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickerIndustries: [TickerIndustry]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "ticker_industries": tickerIndustries.map { (value: TickerIndustry) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220222145854.ticker_industries"
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
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("ticker_industries", type: .nonNull(.list(.nonNull(.object(TickerIndustry.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, tickerIndustries: [TickerIndustry]) {
          self.init(unsafeResultMap: ["__typename": "gainy_industries", "name": name, "ticker_industries": tickerIndustries.map { (value: TickerIndustry) -> ResultMap in value.resultMap }])
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

        /// fetch data from the table: "public_220222145854.ticker_industries"
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
              GraphQLField("ticker", type: .object(Ticker.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(ticker: Ticker? = nil) {
            self.init(unsafeResultMap: ["__typename": "ticker_industries", "ticker": ticker.flatMap { (value: Ticker) -> ResultMap in value.resultMap }])
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
                GraphQLFragmentSpread(RemoteTickerDetails.self),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var remoteTickerDetails: RemoteTickerDetails {
                get {
                  return RemoteTickerDetails(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}
