// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SearchCollectionDetailsAlgoliaQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchCollectionDetailsAlgolia($text: String!) {
      search_collections(query: $text, limit: 50) {
        __typename
        id
        collection {
          __typename
          ...RemoteCollectionDetails
        }
      }
    }
    """

  public let operationName: String = "SearchCollectionDetailsAlgolia"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteCollectionDetails.fragmentDefinition)
    return document
  }

  public var text: String

  public init(text: String) {
    self.text = text
  }

  public var variables: GraphQLMap? {
    return ["text": text]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("search_collections", arguments: ["query": GraphQLVariable("text"), "limit": 50], type: .list(.object(SearchCollection.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchCollections: [SearchCollection?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "search_collections": searchCollections.flatMap { (value: [SearchCollection?]) -> [ResultMap?] in value.map { (value: SearchCollection?) -> ResultMap? in value.flatMap { (value: SearchCollection) -> ResultMap in value.resultMap } } }])
    }

    public var searchCollections: [SearchCollection?]? {
      get {
        return (resultMap["search_collections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SearchCollection?] in value.map { (value: ResultMap?) -> SearchCollection? in value.flatMap { (value: ResultMap) -> SearchCollection in SearchCollection(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [SearchCollection?]) -> [ResultMap?] in value.map { (value: SearchCollection?) -> ResultMap? in value.flatMap { (value: SearchCollection) -> ResultMap in value.resultMap } } }, forKey: "search_collections")
      }
    }

    public struct SearchCollection: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Collection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("collection", type: .object(Collection.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, collection: Collection? = nil) {
        self.init(unsafeResultMap: ["__typename": "Collection", "id": id, "collection": collection.flatMap { (value: Collection) -> ResultMap in value.resultMap }])
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
}
