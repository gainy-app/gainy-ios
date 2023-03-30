// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetTickerLatestTradingSessionQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTickerLatestTradingSession($symbol: String!) {
      ticker_latest_trading_session(where: {symbol: {_eq: $symbol}}) {
        __typename
        open_at
      }
    }
    """

  public let operationName: String = "GetTickerLatestTradingSession"

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
        GraphQLField("ticker_latest_trading_session", arguments: ["where": ["symbol": ["_eq": GraphQLVariable("symbol")]]], type: .nonNull(.list(.nonNull(.object(TickerLatestTradingSession.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickerLatestTradingSession: [TickerLatestTradingSession]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "ticker_latest_trading_session": tickerLatestTradingSession.map { (value: TickerLatestTradingSession) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230329150441.ticker_latest_trading_session"
    public var tickerLatestTradingSession: [TickerLatestTradingSession] {
      get {
        return (resultMap["ticker_latest_trading_session"] as! [ResultMap]).map { (value: ResultMap) -> TickerLatestTradingSession in TickerLatestTradingSession(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TickerLatestTradingSession) -> ResultMap in value.resultMap }, forKey: "ticker_latest_trading_session")
      }
    }

    public struct TickerLatestTradingSession: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ticker_latest_trading_session"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("open_at", type: .scalar(timestamp.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(openAt: timestamp? = nil) {
        self.init(unsafeResultMap: ["__typename": "ticker_latest_trading_session", "open_at": openAt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var openAt: timestamp? {
        get {
          return resultMap["open_at"] as? timestamp
        }
        set {
          resultMap.updateValue(newValue, forKey: "open_at")
        }
      }
    }
  }
}
