// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetTickerExtraDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetTickerExtraDetails($symbol: String!) {
      tickers(where: {symbol: {_eq: $symbol}}) {
        __typename
        ...RemoteTickerExtraDetails
      }
    }
    """

  public let operationName: String = "GetTickerExtraDetails"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteTickerExtraDetails.fragmentDefinition)
    document.append("\n" + RemoteCollectionDetails.fragmentDefinition)
    return document
  }

  public var symbol: String

  public init(symbol: String) {
    self.symbol = symbol
  }

  public var variables: GraphQLMap? {
    return ["symbol": symbol]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("tickers", arguments: ["where": ["symbol": ["_eq": GraphQLVariable("symbol")]]], type: .nonNull(.list(.nonNull(.object(Ticker.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(tickers: [Ticker]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "tickers": tickers.map { (value: Ticker) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230316132848.tickers"
    public var tickers: [Ticker] {
      get {
        return (resultMap["tickers"] as! [ResultMap]).map { (value: ResultMap) -> Ticker in Ticker(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Ticker) -> ResultMap in value.resultMap }, forKey: "tickers")
      }
    }

    public struct Ticker: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["tickers"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(RemoteTickerExtraDetails.self),
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

        public var remoteTickerExtraDetails: RemoteTickerExtraDetails {
          get {
            return RemoteTickerExtraDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}
