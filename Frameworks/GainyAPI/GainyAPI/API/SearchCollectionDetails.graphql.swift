// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SearchCollectionDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchCollectionDetails($text: String!) {
      collections(
        where: {_or: [{name: {_ilike: $text}}, {description: {_ilike: $text}}]}
      ) {
        __typename
        ...RemoteCollectionDetails
      }
    }
    """

  public let operationName: String = "SearchCollectionDetails"

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
        GraphQLField("collections", arguments: ["where": ["_or": [["name": ["_ilike": GraphQLVariable("text")]], ["description": ["_ilike": GraphQLVariable("text")]]]]], type: .nonNull(.list(.nonNull(.object(Collection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collections: [Collection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collections": collections.map { (value: Collection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221006121509.profile_collections"
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