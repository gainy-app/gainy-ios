// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetStatementsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetStatements($profile_id: Int!) {
      app_trading_statements(where: {profile_id: {_eq: $profile_id}}) {
        __typename
        display_name
        type
        id
      }
    }
    """

  public let operationName: String = "TradingGetStatements"

  public var profile_id: Int

  public init(profile_id: Int) {
    self.profile_id = profile_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_trading_statements", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")]]], type: .nonNull(.list(.nonNull(.object(AppTradingStatement.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appTradingStatements: [AppTradingStatement]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_trading_statements": appTradingStatements.map { (value: AppTradingStatement) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.trading_statements"
    public var appTradingStatements: [AppTradingStatement] {
      get {
        return (resultMap["app_trading_statements"] as! [ResultMap]).map { (value: ResultMap) -> AppTradingStatement in AppTradingStatement(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppTradingStatement) -> ResultMap in value.resultMap }, forKey: "app_trading_statements")
      }
    }

    public struct AppTradingStatement: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_trading_statements"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("display_name", type: .nonNull(.scalar(String.self))),
          GraphQLField("type", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(displayName: String, type: String, id: Int) {
        self.init(unsafeResultMap: ["__typename": "app_trading_statements", "display_name": displayName, "type": type, "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var displayName: String {
        get {
          return resultMap["display_name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "display_name")
        }
      }

      public var type: String {
        get {
          return resultMap["type"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
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
