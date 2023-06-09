// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetDiscoverySectionCollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetDiscoverySectionCollections($profile_id: Int!) {
      section_collections(
        where: {profile_id: {_eq: $profile_id}}
        order_by: {position: asc}
      ) {
        __typename
        collection_uniq_id
        position
        profile_id
        section_id
        collection {
          __typename
          ...RemoteShortCollectionDetails
        }
      }
    }
    """

  public let operationName: String = "GetDiscoverySectionCollections"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteShortCollectionDetails.fragmentDefinition)
    return document
  }

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
        GraphQLField("section_collections", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")]], "order_by": ["position": "asc"]], type: .nonNull(.list(.nonNull(.object(SectionCollection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(sectionCollections: [SectionCollection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "section_collections": sectionCollections.map { (value: SectionCollection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230609084853.section_collections"
    public var sectionCollections: [SectionCollection] {
      get {
        return (resultMap["section_collections"] as! [ResultMap]).map { (value: ResultMap) -> SectionCollection in SectionCollection(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: SectionCollection) -> ResultMap in value.resultMap }, forKey: "section_collections")
      }
    }

    public struct SectionCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["section_collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("collection_uniq_id", type: .scalar(String.self)),
          GraphQLField("position", type: .scalar(Int.self)),
          GraphQLField("profile_id", type: .scalar(Int.self)),
          GraphQLField("section_id", type: .scalar(String.self)),
          GraphQLField("collection", type: .object(Collection.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(collectionUniqId: String? = nil, position: Int? = nil, profileId: Int? = nil, sectionId: String? = nil, collection: Collection? = nil) {
        self.init(unsafeResultMap: ["__typename": "section_collections", "collection_uniq_id": collectionUniqId, "position": position, "profile_id": profileId, "section_id": sectionId, "collection": collection.flatMap { (value: Collection) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var collectionUniqId: String? {
        get {
          return resultMap["collection_uniq_id"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "collection_uniq_id")
        }
      }

      public var position: Int? {
        get {
          return resultMap["position"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "position")
        }
      }

      public var profileId: Int? {
        get {
          return resultMap["profile_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "profile_id")
        }
      }

      public var sectionId: String? {
        get {
          return resultMap["section_id"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "section_id")
        }
      }

      /// An object relationship
      public var collection: Collection? {
        get {
          return (resultMap["collection"] as? ResultMap).flatMap { Collection(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "collection")
        }
      }

      public struct Collection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RemoteShortCollectionDetails.self),
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

          public var remoteShortCollectionDetails: RemoteShortCollectionDetails {
            get {
              return RemoteShortCollectionDetails(unsafeResultMap: resultMap)
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
