// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchSelectedCollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchSelectedCollections($ids: [Int!]) @cached(ttl: 300) {
      collections(where: {id: {_in: $ids}, enabled: {_eq: "1"}}) {
        __typename
        ...RemoteCollectionDetails
      }
    }
    """

  public let operationName: String = "FetchSelectedCollections"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteCollectionDetails.fragmentDefinition)
    return document
  }

  public var ids: [Int]?

  public init(ids: [Int]?) {
    self.ids = ids
  }

  public var variables: GraphQLMap? {
    return ["ids": ids]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collections", arguments: ["where": ["id": ["_in": GraphQLVariable("ids")], "enabled": ["_eq": "1"]]], type: .nonNull(.list(.nonNull(.object(Collection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collections: [Collection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collections": collections.map { (value: Collection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221125174334.profile_collections"
    public var collections: [Collection] {
      get {
        return (resultMap["collections"] as! [ResultMap]).map { (value: ResultMap) -> Collection in Collection(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Collection) -> ResultMap in value.resultMap }, forKey: "collections")
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collections"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(RemoteCollectionDetails.self),
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

        public var remoteCollectionDetails: RemoteCollectionDetails {
          get {
            return RemoteCollectionDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
