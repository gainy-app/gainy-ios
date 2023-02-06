// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingDownloadStatementQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingDownloadStatement($profile_id: Int!, $statement_id: Int!) {
      trading_download_statement(profile_id: $profile_id, statement_id: $statement_id) {
        __typename
        url
      }
    }
    """

  public let operationName: String = "TradingDownloadStatement"

  public var profile_id: Int
  public var statement_id: Int

  public init(profile_id: Int, statement_id: Int) {
    self.profile_id = profile_id
    self.statement_id = statement_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "statement_id": statement_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_download_statement", arguments: ["profile_id": GraphQLVariable("profile_id"), "statement_id": GraphQLVariable("statement_id")], type: .object(TradingDownloadStatement.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingDownloadStatement: TradingDownloadStatement? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_download_statement": tradingDownloadStatement.flatMap { (value: TradingDownloadStatement) -> ResultMap in value.resultMap }])
    }

    public var tradingDownloadStatement: TradingDownloadStatement? {
      get {
        return (resultMap["trading_download_statement"] as? ResultMap).flatMap { TradingDownloadStatement(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "trading_download_statement")
      }
    }

    public struct TradingDownloadStatement: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UrlOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("url", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(url: String) {
        self.init(unsafeResultMap: ["__typename": "UrlOutput", "url": url])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var url: String {
        get {
          return resultMap["url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }
    }
  }
}
