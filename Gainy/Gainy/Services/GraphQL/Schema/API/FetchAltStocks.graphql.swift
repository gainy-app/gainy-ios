// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchAltStocksQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchAltStocks($symbol: String!) {
      ticker_interests(where: {symbol: {_eq: $symbol}}) {
        __typename
        symbol
        interest_id
        interest {
          __typename
          ticker_interests {
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
        GraphQLField("ticker_interests", arguments: ["where": ["symbol": ["_eq": GraphQLVariable("symbol")]]], type: .nonNull(.list(.nonNull(.object(TickerInterest.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickerInterests: [TickerInterest]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "ticker_interests": tickerInterests.map { (value: TickerInterest) -> ResultMap in value.resultMap }])
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
            GraphQLField("ticker_interests", type: .nonNull(.list(.nonNull(.object(TickerInterest.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(tickerInterests: [TickerInterest]) {
          self.init(unsafeResultMap: ["__typename": "interests", "ticker_interests": tickerInterests.map { (value: TickerInterest) -> ResultMap in value.resultMap }])
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
        public var tickerInterests: [TickerInterest] {
          get {
            return (resultMap["ticker_interests"] as! [ResultMap]).map { (value: ResultMap) -> TickerInterest in TickerInterest(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: TickerInterest) -> ResultMap in value.resultMap }, forKey: "ticker_interests")
          }
        }

        public struct TickerInterest: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ticker_interests"]

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
            self.init(unsafeResultMap: ["__typename": "ticker_interests", "ticker": ticker.flatMap { (value: Ticker) -> ResultMap in value.resultMap }])
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
