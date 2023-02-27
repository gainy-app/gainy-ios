// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UpdateProfileScoringSettingsWithInterestsPart2Mutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateProfileScoringSettingsWithInterestsPart2($profileID: Int!, $interests: [Int!]!) {
      set_recommendation_settings(profile_id: $profileID, interests: $interests) {
        __typename
        recommended_collections {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "UpdateProfileScoringSettingsWithInterestsPart2"

  public var profileID: Int
  public var interests: [Int]

  public init(profileID: Int, interests: [Int]) {
    self.profileID = profileID
    self.interests = interests
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "interests": interests]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("set_recommendation_settings", arguments: ["profile_id": GraphQLVariable("profileID"), "interests": GraphQLVariable("interests")], type: .object(SetRecommendationSetting.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(setRecommendationSettings: SetRecommendationSetting? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "set_recommendation_settings": setRecommendationSettings.flatMap { (value: SetRecommendationSetting) -> ResultMap in value.resultMap }])
    }

    public var setRecommendationSettings: SetRecommendationSetting? {
      get {
        return (resultMap["set_recommendation_settings"] as? ResultMap).flatMap { SetRecommendationSetting(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "set_recommendation_settings")
      }
    }

    public struct SetRecommendationSetting: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SetRecommendationSettingsOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("recommended_collections", type: .list(.object(RecommendedCollection.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(recommendedCollections: [RecommendedCollection?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "SetRecommendationSettingsOutput", "recommended_collections": recommendedCollections.flatMap { (value: [RecommendedCollection?]) -> [ResultMap?] in value.map { (value: RecommendedCollection?) -> ResultMap? in value.flatMap { (value: RecommendedCollection) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var recommendedCollections: [RecommendedCollection?]? {
        get {
          return (resultMap["recommended_collections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [RecommendedCollection?] in value.map { (value: ResultMap?) -> RecommendedCollection? in value.flatMap { (value: ResultMap) -> RecommendedCollection in RecommendedCollection(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [RecommendedCollection?]) -> [ResultMap?] in value.map { (value: RecommendedCollection?) -> ResultMap? in value.flatMap { (value: RecommendedCollection) -> ResultMap in value.resultMap } } }, forKey: "recommended_collections")
        }
      }

      public struct RecommendedCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Collection"]

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
          self.init(unsafeResultMap: ["__typename": "Collection", "id": id])
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
}
