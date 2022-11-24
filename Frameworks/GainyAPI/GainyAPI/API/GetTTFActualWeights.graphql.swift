// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetCollectionTickerActualWeightsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetCollectionTickerActualWeights($collection_id: Int!) {
      collection_ticker_actual_weights(where: {collection_id: {_eq: $collection_id}}) {
        __typename
        symbol
        weight
      }
    }
    """

  public let operationName: String = "GetCollectionTickerActualWeights"

  public var collection_id: Int

  public init(collection_id: Int) {
    self.collection_id = collection_id
  }

  public var variables: GraphQLMap? {
    return ["collection_id": collection_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("collection_ticker_actual_weights", arguments: ["where": ["collection_id": ["_eq": GraphQLVariable("collection_id")]]], type: .nonNull(.list(.nonNull(.object(CollectionTickerActualWeight.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collectionTickerActualWeights: [CollectionTickerActualWeight]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "collection_ticker_actual_weights": collectionTickerActualWeights.map { (value: CollectionTickerActualWeight) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_221122062016.collection_ticker_actual_weights"
    public var collectionTickerActualWeights: [CollectionTickerActualWeight] {
      get {
        return (resultMap["collection_ticker_actual_weights"] as! [ResultMap]).map { (value: ResultMap) -> CollectionTickerActualWeight in CollectionTickerActualWeight(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: CollectionTickerActualWeight) -> ResultMap in value.resultMap }, forKey: "collection_ticker_actual_weights")
      }
    }

    public struct CollectionTickerActualWeight: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["collection_ticker_actual_weights"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          GraphQLField("weight", type: .scalar(numeric.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(symbol: String, weight: numeric? = nil) {
        self.init(unsafeResultMap: ["__typename": "collection_ticker_actual_weights", "symbol": symbol, "weight": weight])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var symbol: String {
        get {
          return resultMap["symbol"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "symbol")
        }
      }

      public var weight: numeric? {
        get {
          return resultMap["weight"] as? numeric
        }
        set {
          resultMap.updateValue(newValue, forKey: "weight")
        }
      }
    }
  }
}
