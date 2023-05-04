// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetProfileExactHistoryItemQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetProfileExactHistoryItem($profile_id: Int!, $uniq_id: String!) {
      trading_history(
        where: {profile_id: {_eq: $profile_id}, uniq_id: {_eq: $uniq_id}}
      ) {
        __typename
        ...TradingHistoryFrag
      }
    }
    """

  public let operationName: String = "GetProfileExactHistoryItem"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + TradingHistoryFrag.fragmentDefinition)
    return document
  }

  public var profile_id: Int
  public var uniq_id: String

  public init(profile_id: Int, uniq_id: String) {
    self.profile_id = profile_id
    self.uniq_id = uniq_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "uniq_id": uniq_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("trading_history", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")], "uniq_id": ["_eq": GraphQLVariable("uniq_id")]]], type: .nonNull(.list(.nonNull(.object(TradingHistory.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tradingHistory: [TradingHistory]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "trading_history": tradingHistory.map { (value: TradingHistory) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230503100430.trading_history"
    public var tradingHistory: [TradingHistory] {
      get {
        return (resultMap["trading_history"] as! [ResultMap]).map { (value: ResultMap) -> TradingHistory in TradingHistory(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: TradingHistory) -> ResultMap in value.resultMap }, forKey: "trading_history")
      }
    }

    public struct TradingHistory: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["trading_history"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(TradingHistoryFrag.self),
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

        public var tradingHistoryFrag: TradingHistoryFrag {
          get {
            return TradingHistoryFrag(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
