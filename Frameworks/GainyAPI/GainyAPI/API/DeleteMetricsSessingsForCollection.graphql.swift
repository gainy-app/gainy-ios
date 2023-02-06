// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DeleteMetricsSessingsForCollectionMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteMetricsSessingsForCollection($profileID: Int!, $collectionID: Int!) {
      delete_app_profile_ticker_metrics_settings(
        where: {collection_id: {_eq: $collectionID}, profile_id: {_eq: $profileID}}
      ) {
        __typename
        returning {
          __typename
          collection_id
          id
          field_name
          order
          profile_id
        }
      }
    }
    """

  public let operationName: String = "DeleteMetricsSessingsForCollection"

  public var profileID: Int
  public var collectionID: Int

  public init(profileID: Int, collectionID: Int) {
    self.profileID = profileID
    self.collectionID = collectionID
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "collectionID": collectionID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("delete_app_profile_ticker_metrics_settings", arguments: ["where": ["collection_id": ["_eq": GraphQLVariable("collectionID")], "profile_id": ["_eq": GraphQLVariable("profileID")]]], type: .object(DeleteAppProfileTickerMetricsSetting.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteAppProfileTickerMetricsSettings: DeleteAppProfileTickerMetricsSetting? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "delete_app_profile_ticker_metrics_settings": deleteAppProfileTickerMetricsSettings.flatMap { (value: DeleteAppProfileTickerMetricsSetting) -> ResultMap in value.resultMap }])
    }

    /// delete data from the table: "app.profile_ticker_metrics_settings"
    public var deleteAppProfileTickerMetricsSettings: DeleteAppProfileTickerMetricsSetting? {
      get {
        return (resultMap["delete_app_profile_ticker_metrics_settings"] as? ResultMap).flatMap { DeleteAppProfileTickerMetricsSetting(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "delete_app_profile_ticker_metrics_settings")
      }
    }

    public struct DeleteAppProfileTickerMetricsSetting: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_ticker_metrics_settings_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("returning", type: .nonNull(.list(.nonNull(.object(Returning.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(returning: [Returning]) {
        self.init(unsafeResultMap: ["__typename": "app_profile_ticker_metrics_settings_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// data from the rows affected by the mutation
      public var returning: [Returning] {
        get {
          return (resultMap["returning"] as! [ResultMap]).map { (value: ResultMap) -> Returning in Returning(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Returning) -> ResultMap in value.resultMap }, forKey: "returning")
        }
      }

      public struct Returning: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_ticker_metrics_settings"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("collection_id", type: .scalar(Int.self)),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("field_name", type: .nonNull(.scalar(String.self))),
            GraphQLField("order", type: .nonNull(.scalar(Int.self))),
            GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(collectionId: Int? = nil, id: Int, fieldName: String, order: Int, profileId: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profile_ticker_metrics_settings", "collection_id": collectionId, "id": id, "field_name": fieldName, "order": order, "profile_id": profileId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var collectionId: Int? {
          get {
            return resultMap["collection_id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "collection_id")
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

        public var fieldName: String {
          get {
            return resultMap["field_name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "field_name")
          }
        }

        public var order: Int {
          get {
            return resultMap["order"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "order")
          }
        }

        public var profileId: Int {
          get {
            return resultMap["profile_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "profile_id")
          }
        }
      }
    }
  }
}
