// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class InsertMetricsSessingsForCollectionMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertMetricsSessingsForCollection($profileID: Int!, $collectionID: Int!, $f1: String!, $f2: String!, $f3: String!, $f4: String!, $f5: String!) {
      insert_app_profile_ticker_metrics_settings(
        objects: [{profile_id: $profileID, collection_id: $collectionID, field_name: $f1, order: 0}, {profile_id: $profileID, collection_id: $collectionID, field_name: $f2, order: 1}, {profile_id: $profileID, collection_id: $collectionID, field_name: $f3, order: 2}, {profile_id: $profileID, collection_id: $collectionID, field_name: $f4, order: 3}, {profile_id: $profileID, collection_id: $collectionID, field_name: $f5, order: 4}]
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

  public let operationName: String = "InsertMetricsSessingsForCollection"

  public var profileID: Int
  public var collectionID: Int
  public var f1: String
  public var f2: String
  public var f3: String
  public var f4: String
  public var f5: String

  public init(profileID: Int, collectionID: Int, f1: String, f2: String, f3: String, f4: String, f5: String) {
    self.profileID = profileID
    self.collectionID = collectionID
    self.f1 = f1
    self.f2 = f2
    self.f3 = f3
    self.f4 = f4
    self.f5 = f5
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "collectionID": collectionID, "f1": f1, "f2": f2, "f3": f3, "f4": f4, "f5": f5]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_profile_ticker_metrics_settings", arguments: ["objects": [["profile_id": GraphQLVariable("profileID"), "collection_id": GraphQLVariable("collectionID"), "field_name": GraphQLVariable("f1"), "order": 0], ["profile_id": GraphQLVariable("profileID"), "collection_id": GraphQLVariable("collectionID"), "field_name": GraphQLVariable("f2"), "order": 1], ["profile_id": GraphQLVariable("profileID"), "collection_id": GraphQLVariable("collectionID"), "field_name": GraphQLVariable("f3"), "order": 2], ["profile_id": GraphQLVariable("profileID"), "collection_id": GraphQLVariable("collectionID"), "field_name": GraphQLVariable("f4"), "order": 3], ["profile_id": GraphQLVariable("profileID"), "collection_id": GraphQLVariable("collectionID"), "field_name": GraphQLVariable("f5"), "order": 4]]], type: .object(InsertAppProfileTickerMetricsSetting.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfileTickerMetricsSettings: InsertAppProfileTickerMetricsSetting? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profile_ticker_metrics_settings": insertAppProfileTickerMetricsSettings.flatMap { (value: InsertAppProfileTickerMetricsSetting) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.profile_ticker_metrics_settings"
    public var insertAppProfileTickerMetricsSettings: InsertAppProfileTickerMetricsSetting? {
      get {
        return (resultMap["insert_app_profile_ticker_metrics_settings"] as? ResultMap).flatMap { InsertAppProfileTickerMetricsSetting(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profile_ticker_metrics_settings")
      }
    }

    public struct InsertAppProfileTickerMetricsSetting: GraphQLSelectionSet {
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
