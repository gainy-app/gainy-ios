// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetTtfPieChartQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTTFPieChart($uniqID: String!) {
      collection_piechart(where: {collection_uniq_id: {_eq: $uniqID}}) {
        __typename
        weight
        entity_type
        relative_daily_change
        entity_name
        entity_id
        absolute_value
        absolute_daily_change
      }
    }
    """

  public let operationName: String = "GetTTFPieChart"

  public var uniqID: String

  public init(uniqID: String) {
    self.uniqID = uniqID
  }

  public var variables: GraphQLMap? {
    return ["uniqID": uniqID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collection_piechart", arguments: ["where": ["collection_uniq_id": ["_eq": GraphQLVariable("uniqID")]]], type: .nonNull(.list(.nonNull(.object(CollectionPiechart.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collectionPiechart: [CollectionPiechart]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collection_piechart": collectionPiechart.map { (value: CollectionPiechart) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230504064834.collection_piechart"
    public var collectionPiechart: [CollectionPiechart] {
      get {
        return (resultMap["collection_piechart"] as! [ResultMap]).map { (value: ResultMap) -> CollectionPiechart in CollectionPiechart(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: CollectionPiechart) -> ResultMap in value.resultMap }, forKey: "collection_piechart")
      }
    }

    public struct CollectionPiechart: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collection_piechart"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("weight", type: .scalar(float8.self)),
          GraphQLField("entity_type", type: .scalar(String.self)),
          GraphQLField("relative_daily_change", type: .scalar(float8.self)),
          GraphQLField("entity_name", type: .scalar(String.self)),
          GraphQLField("entity_id", type: .scalar(String.self)),
          GraphQLField("absolute_value", type: .scalar(float8.self)),
          GraphQLField("absolute_daily_change", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(weight: float8? = nil, entityType: String? = nil, relativeDailyChange: float8? = nil, entityName: String? = nil, entityId: String? = nil, absoluteValue: float8? = nil, absoluteDailyChange: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "collection_piechart", "weight": weight, "entity_type": entityType, "relative_daily_change": relativeDailyChange, "entity_name": entityName, "entity_id": entityId, "absolute_value": absoluteValue, "absolute_daily_change": absoluteDailyChange])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var weight: float8? {
        get {
          return resultMap["weight"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "weight")
        }
      }

      public var entityType: String? {
        get {
          return resultMap["entity_type"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_type")
        }
      }

      public var relativeDailyChange: float8? {
        get {
          return resultMap["relative_daily_change"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "relative_daily_change")
        }
      }

      public var entityName: String? {
        get {
          return resultMap["entity_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_name")
        }
      }

      public var entityId: String? {
        get {
          return resultMap["entity_id"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "entity_id")
        }
      }

      public var absoluteValue: float8? {
        get {
          return resultMap["absolute_value"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "absolute_value")
        }
      }

      public var absoluteDailyChange: float8? {
        get {
          return resultMap["absolute_daily_change"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "absolute_daily_change")
        }
      }
    }
  }
}
