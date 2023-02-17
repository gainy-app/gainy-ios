// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetCollectionMetricsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetCollectionMetrics($colID: String!) {
      collection_metrics(where: {collection_uniq_id: {_eq: $colID}}) {
        __typename
        value_change_1m
        value_change_1w
        value_change_3m
        value_change_1y
        value_change_5y
        value_change_all
        relative_daily_change
      }
    }
    """

  public let operationName: String = "GetCollectionMetrics"

  public var colID: String

  public init(colID: String) {
    self.colID = colID
  }

  public var variables: GraphQLMap? {
    return ["colID": colID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collection_metrics", arguments: ["where": ["collection_uniq_id": ["_eq": GraphQLVariable("colID")]]], type: .nonNull(.list(.nonNull(.object(CollectionMetric.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collectionMetrics: [CollectionMetric]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collection_metrics": collectionMetrics.map { (value: CollectionMetric) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230217143130.collection_metrics"
    public var collectionMetrics: [CollectionMetric] {
      get {
        return (resultMap["collection_metrics"] as! [ResultMap]).map { (value: ResultMap) -> CollectionMetric in CollectionMetric(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: CollectionMetric) -> ResultMap in value.resultMap }, forKey: "collection_metrics")
      }
    }

    public struct CollectionMetric: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collection_metrics"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("value_change_1m", type: .scalar(numeric.self)),
          GraphQLField("value_change_1w", type: .scalar(numeric.self)),
          GraphQLField("value_change_3m", type: .scalar(numeric.self)),
          GraphQLField("value_change_1y", type: .scalar(numeric.self)),
          GraphQLField("value_change_5y", type: .scalar(numeric.self)),
          GraphQLField("value_change_all", type: .scalar(numeric.self)),
          GraphQLField("relative_daily_change", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(valueChange_1m: numeric? = nil, valueChange_1w: numeric? = nil, valueChange_3m: numeric? = nil, valueChange_1y: numeric? = nil, valueChange_5y: numeric? = nil, valueChangeAll: numeric? = nil, relativeDailyChange: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "collection_metrics", "value_change_1m": valueChange_1m, "value_change_1w": valueChange_1w, "value_change_3m": valueChange_3m, "value_change_1y": valueChange_1y, "value_change_5y": valueChange_5y, "value_change_all": valueChangeAll, "relative_daily_change": relativeDailyChange])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var valueChange_1m: numeric? {
        get {
          return resultMap["value_change_1m"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "value_change_1m")
        }
      }

      public var valueChange_1w: numeric? {
        get {
          return resultMap["value_change_1w"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "value_change_1w")
        }
      }

      public var valueChange_3m: numeric? {
        get {
          return resultMap["value_change_3m"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "value_change_3m")
        }
      }

      public var valueChange_1y: numeric? {
        get {
          return resultMap["value_change_1y"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "value_change_1y")
        }
      }

      public var valueChange_5y: numeric? {
        get {
          return resultMap["value_change_5y"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "value_change_5y")
        }
      }

      public var valueChangeAll: numeric? {
        get {
          return resultMap["value_change_all"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "value_change_all")
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
    }
  }
}
