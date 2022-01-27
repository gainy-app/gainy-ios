// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UpdatePlaidPortfolioQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query UpdatePlaidPortfolio($profileId: Int!) {
      get_portfolio_holdings(profile_id: $profileId) {
        __typename
        id
      }
      get_portfolio_transactions(profile_id: $profileId) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "UpdatePlaidPortfolio"

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
        GraphQLField("get_portfolio_holdings", arguments: ["profile_id": GraphQLVariable("profileId")], type: .list(.object(GetPortfolioHolding.selections))),
        GraphQLField("get_portfolio_transactions", arguments: ["profile_id": GraphQLVariable("profileId")], type: .list(.object(GetPortfolioTransaction.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPortfolioHoldings: [GetPortfolioHolding?]? = nil, getPortfolioTransactions: [GetPortfolioTransaction?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_portfolio_holdings": getPortfolioHoldings.flatMap { (value: [GetPortfolioHolding?]) -> [ResultMap?] in value.map { (value: GetPortfolioHolding?) -> ResultMap? in value.flatMap { (value: GetPortfolioHolding) -> ResultMap in value.resultMap } } }, "get_portfolio_transactions": getPortfolioTransactions.flatMap { (value: [GetPortfolioTransaction?]) -> [ResultMap?] in value.map { (value: GetPortfolioTransaction?) -> ResultMap? in value.flatMap { (value: GetPortfolioTransaction) -> ResultMap in value.resultMap } } }])
    }

    public var getPortfolioHoldings: [GetPortfolioHolding?]? {
      get {
        return (resultMap["get_portfolio_holdings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetPortfolioHolding?] in value.map { (value: ResultMap?) -> GetPortfolioHolding? in value.flatMap { (value: ResultMap) -> GetPortfolioHolding in GetPortfolioHolding(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetPortfolioHolding?]) -> [ResultMap?] in value.map { (value: GetPortfolioHolding?) -> ResultMap? in value.flatMap { (value: GetPortfolioHolding) -> ResultMap in value.resultMap } } }, forKey: "get_portfolio_holdings")
      }
    }

    public var getPortfolioTransactions: [GetPortfolioTransaction?]? {
      get {
        return (resultMap["get_portfolio_transactions"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetPortfolioTransaction?] in value.map { (value: ResultMap?) -> GetPortfolioTransaction? in value.flatMap { (value: ResultMap) -> GetPortfolioTransaction in GetPortfolioTransaction(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetPortfolioTransaction?]) -> [ResultMap?] in value.map { (value: GetPortfolioTransaction?) -> ResultMap? in value.flatMap { (value: GetPortfolioTransaction) -> ResultMap in value.resultMap } } }, forKey: "get_portfolio_transactions")
      }
    }

    public struct GetPortfolioHolding: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PortfolioHolding"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "PortfolioHolding", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }

    public struct GetPortfolioTransaction: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PortfolioTransaction"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "PortfolioTransaction", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}
