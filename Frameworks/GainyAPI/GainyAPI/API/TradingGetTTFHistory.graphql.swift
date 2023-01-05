// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class TradingGetTtfHistoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query TradingGetTTFHistory($profile_id: Int!, $collection_id: Int!) {
      app_trading_collection_versions(
        where: {profile_id: {_eq: $profile_id}, collection_id: {_eq: $collection_id}}
        limit: 3
        order_by: {created_at: desc}
      ) {
        __typename
        id
        created_at
        target_amount_delta
        status
        history {
          __typename
          ...TradingHistoryFrag
        }
      }
    }
    """

  public let operationName: String = "TradingGetTTFHistory"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + TradingHistoryFrag.fragmentDefinition)
    return document
  }

  public var profile_id: Int
  public var collection_id: Int

  public init(profile_id: Int, collection_id: Int) {
    self.profile_id = profile_id
    self.collection_id = collection_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "collection_id": collection_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_trading_collection_versions", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")], "collection_id": ["_eq": GraphQLVariable("collection_id")]], "limit": 3, "order_by": ["created_at": "desc"]], type: .nonNull(.list(.nonNull(.object(AppTradingCollectionVersion.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appTradingCollectionVersions: [AppTradingCollectionVersion]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_trading_collection_versions": appTradingCollectionVersions.map { (value: AppTradingCollectionVersion) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.trading_collection_versions"
    public var appTradingCollectionVersions: [AppTradingCollectionVersion] {
      get {
        return (resultMap["app_trading_collection_versions"] as! [ResultMap]).map { (value: ResultMap) -> AppTradingCollectionVersion in AppTradingCollectionVersion(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppTradingCollectionVersion) -> ResultMap in value.resultMap }, forKey: "app_trading_collection_versions")
      }
    }

    public struct AppTradingCollectionVersion: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_trading_collection_versions"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
          GraphQLField("target_amount_delta", type: .scalar(numeric.self)),
          GraphQLField("status", type: .scalar(String.self)),
          GraphQLField("history", type: .nonNull(.list(.nonNull(.object(History.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, createdAt: timestamptz, targetAmountDelta: numeric? = nil, status: String? = nil, history: [History]) {
        self.init(unsafeResultMap: ["__typename": "app_trading_collection_versions", "id": id, "created_at": createdAt, "target_amount_delta": targetAmountDelta, "status": status, "history": history.map { (value: History) -> ResultMap in value.resultMap }])
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

      public var createdAt: timestamptz {
        get {
          return resultMap["created_at"]! as! timestamptz
        }
        set {
          resultMap.updateValue(newValue, forKey: "created_at")
        }
      }

      public var targetAmountDelta: numeric? {
        get {
          return resultMap["target_amount_delta"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "target_amount_delta")
        }
      }

      public var status: String? {
        get {
          return resultMap["status"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      /// An array relationship
      public var history: [History] {
        get {
          return (resultMap["history"] as! [ResultMap]).map { (value: ResultMap) -> History in History(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: History) -> ResultMap in value.resultMap }, forKey: "history")
        }
      }

      public struct History: GraphQLSelectionSet {
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
}
