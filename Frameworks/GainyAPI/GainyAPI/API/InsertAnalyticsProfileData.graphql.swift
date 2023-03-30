// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class InsertAnalyticsProfileDataMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertAnalyticsProfileData($profile_id: Int!, $service_name: String!, $metadata: jsonb!) {
      insert_app_analytics_profile_data(
        objects: {profile_id: $profile_id, service_name: $service_name, metadata: $metadata}
        on_conflict: {constraint: analytics_profile_data_pkey}
      ) {
        __typename
        affected_rows
      }
    }
    """

  public let operationName: String = "InsertAnalyticsProfileData"

  public var profile_id: Int
  public var service_name: String
  public var metadata: jsonb

  public init(profile_id: Int, service_name: String, metadata: jsonb) {
    self.profile_id = profile_id
    self.service_name = service_name
    self.metadata = metadata
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "service_name": service_name, "metadata": metadata]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_analytics_profile_data", arguments: ["objects": ["profile_id": GraphQLVariable("profile_id"), "service_name": GraphQLVariable("service_name"), "metadata": GraphQLVariable("metadata")], "on_conflict": ["constraint": "analytics_profile_data_pkey"]], type: .object(InsertAppAnalyticsProfileDatum.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppAnalyticsProfileData: InsertAppAnalyticsProfileDatum? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_analytics_profile_data": insertAppAnalyticsProfileData.flatMap { (value: InsertAppAnalyticsProfileDatum) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.analytics_profile_data"
    public var insertAppAnalyticsProfileData: InsertAppAnalyticsProfileDatum? {
      get {
        return (resultMap["insert_app_analytics_profile_data"] as? ResultMap).flatMap { InsertAppAnalyticsProfileDatum(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_analytics_profile_data")
      }
    }

    public struct InsertAppAnalyticsProfileDatum: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_analytics_profile_data_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("affected_rows", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(affectedRows: Int) {
        self.init(unsafeResultMap: ["__typename": "app_analytics_profile_data_mutation_response", "affected_rows": affectedRows])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// number of rows affected by the mutation
      public var affectedRows: Int {
        get {
          return resultMap["affected_rows"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "affected_rows")
        }
      }
    }
  }
}
