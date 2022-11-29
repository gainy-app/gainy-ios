// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetTtfTagsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTTFTags($uniqID: String!, $profileId: Int!) {
      collection_match_score_explanation(
        where: {profile_id: {_eq: $profileId}, collection_uniq_id: {_eq: $uniqID}}
      ) {
        __typename
        interest {
          __typename
          id
          name
          icon_url
        }
        category {
          __typename
          id
          name
          icon_url
          collection_id
        }
      }
    }
    """

  public let operationName: String = "GetTTFTags"

  public var uniqID: String
  public var profileId: Int

  public init(uniqID: String, profileId: Int) {
    self.uniqID = uniqID
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["uniqID": uniqID, "profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collection_match_score_explanation", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profileId")], "collection_uniq_id": ["_eq": GraphQLVariable("uniqID")]]], type: .nonNull(.list(.nonNull(.object(CollectionMatchScoreExplanation.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collectionMatchScoreExplanation: [CollectionMatchScoreExplanation]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collection_match_score_explanation": collectionMatchScoreExplanation.map { (value: CollectionMatchScoreExplanation) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221125174334.collection_match_score_explanation"
    public var collectionMatchScoreExplanation: [CollectionMatchScoreExplanation] {
      get {
        return (resultMap["collection_match_score_explanation"] as! [ResultMap]).map { (value: ResultMap) -> CollectionMatchScoreExplanation in CollectionMatchScoreExplanation(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: CollectionMatchScoreExplanation) -> ResultMap in value.resultMap }, forKey: "collection_match_score_explanation")
      }
    }

    public struct CollectionMatchScoreExplanation: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collection_match_score_explanation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("interest", type: .object(Interest.selections)),
          GraphQLField("category", type: .object(Category.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(interest: Interest? = nil, category: Category? = nil) {
        self.init(unsafeResultMap: ["__typename": "collection_match_score_explanation", "interest": interest.flatMap { (value: Interest) -> ResultMap in value.resultMap }, "category": category.flatMap { (value: Category) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// An object relationship
      public var interest: Interest? {
        get {
          return (resultMap["interest"] as? ResultMap).flatMap { Interest(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "interest")
        }
      }

      /// An object relationship
      public var category: Category? {
        get {
          return (resultMap["category"] as? ResultMap).flatMap { Category(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "category")
        }
      }

      public struct Interest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["interests"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("icon_url", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String? = nil, iconUrl: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "interests", "id": id, "name": name, "icon_url": iconUrl])
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

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var iconUrl: String? {
          get {
            return resultMap["icon_url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "icon_url")
          }
        }
      }

      public struct Category: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["categories"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("icon_url", type: .scalar(String.self)),
            GraphQLField("collection_id", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String? = nil, iconUrl: String? = nil, collectionId: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "categories", "id": id, "name": name, "icon_url": iconUrl, "collection_id": collectionId])
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

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var iconUrl: String? {
          get {
            return resultMap["icon_url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "icon_url")
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
      }
    }
  }
}
