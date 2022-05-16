// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchTtfMedianQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchTTFMedian($collectionUniqId: String!, $period: String!) {
      collection_chart(
        where: {collection_uniq_id: {_eq: $collectionUniqId}, period: {_eq: $period}}
      ) {
        __typename
        datetime
        period
        adjusted_close
      }
    }
    """

  public let operationName: String = "FetchTTFMedian"

  public var collectionUniqId: String
  public var period: String

  public init(collectionUniqId: String, period: String) {
    self.collectionUniqId = collectionUniqId
    self.period = period
  }

  public var variables: GraphQLMap? {
    return ["collectionUniqId": collectionUniqId, "period": period]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collection_chart", arguments: ["where": ["collection_uniq_id": ["_eq": GraphQLVariable("collectionUniqId")], "period": ["_eq": GraphQLVariable("period")]]], type: .nonNull(.list(.nonNull(.object(CollectionChart.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collectionChart: [CollectionChart]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collection_chart": collectionChart.map { (value: CollectionChart) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_220510085411.collection_chart"
    public var collectionChart: [CollectionChart] {
      get {
        return (resultMap["collection_chart"] as! [ResultMap]).map { (value: ResultMap) -> CollectionChart in CollectionChart(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: CollectionChart) -> ResultMap in value.resultMap }, forKey: "collection_chart")
      }
    }

    public struct CollectionChart: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collection_chart"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("datetime", type: .scalar(timestamp.self)),
          GraphQLField("period", type: .scalar(String.self)),
          GraphQLField("adjusted_close", type: .scalar(float8.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(datetime: timestamp? = nil, period: String? = nil, adjustedClose: float8? = nil) {
        self.init(unsafeResultMap: ["__typename": "collection_chart", "datetime": datetime, "period": period, "adjusted_close": adjustedClose])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var datetime: timestamp? {
        get {
          return resultMap["datetime"] as? timestamp
        }
        set {
          resultMap.updateValue(newValue, forKey: "datetime")
        }
      }

      public var period: String? {
        get {
          return resultMap["period"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "period")
        }
      }

      public var adjustedClose: float8? {
        get {
          return resultMap["adjusted_close"] as? float8
        }
        set {
          resultMap.updateValue(newValue, forKey: "adjusted_close")
        }
      }
    }
  }
}
