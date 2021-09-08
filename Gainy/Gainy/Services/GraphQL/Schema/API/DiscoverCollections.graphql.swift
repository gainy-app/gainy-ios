// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DiscoverCollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query DiscoverCollections {
      collections {
        __typename
        name
        image_url
        id
        description
        ticker_collections_aggregate {
          __typename
          aggregate {
            __typename
            count
          }
        }
      }
    }
    """

  public let operationName: String = "DiscoverCollections"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collections", type: .nonNull(.list(.nonNull(.object(Collection.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collections: [Collection]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collections": collections.map { (value: Collection) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "collections"
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
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("image_url", type: .scalar(String.self)),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("ticker_collections_aggregate", type: .nonNull(.object(TickerCollectionsAggregate.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, imageUrl: String? = nil, id: Int? = nil, description: String? = nil, tickerCollectionsAggregate: TickerCollectionsAggregate) {
        self.init(unsafeResultMap: ["__typename": "collections", "name": name, "image_url": imageUrl, "id": id, "description": description, "ticker_collections_aggregate": tickerCollectionsAggregate.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var imageUrl: String? {
        get {
          return resultMap["image_url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image_url")
        }
      }

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// An aggregate relationship
      public var tickerCollectionsAggregate: TickerCollectionsAggregate {
        get {
          return TickerCollectionsAggregate(unsafeResultMap: resultMap["ticker_collections_aggregate"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "ticker_collections_aggregate")
        }
      }

      public struct TickerCollectionsAggregate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ticker_collections_aggregate"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("aggregate", type: .object(Aggregate.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(aggregate: Aggregate? = nil) {
          self.init(unsafeResultMap: ["__typename": "ticker_collections_aggregate", "aggregate": aggregate.flatMap { (value: Aggregate) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var aggregate: Aggregate? {
          get {
            return (resultMap["aggregate"] as? ResultMap).flatMap { Aggregate(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "aggregate")
          }
        }

        public struct Aggregate: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ticker_collections_aggregate_fields"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("count", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(count: Int) {
            self.init(unsafeResultMap: ["__typename": "ticker_collections_aggregate_fields", "count": count])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var count: Int {
            get {
              return resultMap["count"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "count")
            }
          }
        }
      }
    }
  }
}
