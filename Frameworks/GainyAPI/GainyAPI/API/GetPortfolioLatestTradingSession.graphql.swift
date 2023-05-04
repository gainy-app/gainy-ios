// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPortfolioLatestTradingSessionQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPortfolioLatestTradingSession($profileId: Int!) {
      portfolio_latest_trading_session(where: {profile_id: {_eq: $profileId}}) {
        __typename
        open_at
      }
    }
    """

  public let operationName: String = "GetPortfolioLatestTradingSession"

  public var profileId: Int

  public init(profileId: Int) {
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("portfolio_latest_trading_session", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")]]], type: .nonNull(.list(.nonNull(.object(PortfolioLatestTradingSession.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(portfolioLatestTradingSession: [PortfolioLatestTradingSession]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "portfolio_latest_trading_session": portfolioLatestTradingSession.map { (value: PortfolioLatestTradingSession) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230503100430.portfolio_latest_trading_session"
    public var portfolioLatestTradingSession: [PortfolioLatestTradingSession] {
      get {
        return (resultMap["portfolio_latest_trading_session"] as! [ResultMap]).map { (value: ResultMap) -> PortfolioLatestTradingSession in PortfolioLatestTradingSession(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: PortfolioLatestTradingSession) -> ResultMap in value.resultMap }, forKey: "portfolio_latest_trading_session")
      }
    }

    public struct PortfolioLatestTradingSession: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["portfolio_latest_trading_session"]

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
        self.init(unsafeResultMap: ["__typename": "portfolio_latest_trading_session", "open_at": openAt])
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
