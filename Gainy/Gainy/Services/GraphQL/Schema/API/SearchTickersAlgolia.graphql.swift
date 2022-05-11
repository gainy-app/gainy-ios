// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SearchTickersAlgoliaQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchTickersAlgolia($text: String!) {
      search_tickers(query: $text, limit: 50) {
        __typename
        symbol
        ticker {
          __typename
          ...RemoteTickerDetails
        }
      }
    }
    """

  public let operationName: String = "SearchTickersAlgolia"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + RemoteTickerDetails.fragmentDefinition)
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
        GraphQLField("search_tickers", arguments: ["query": GraphQLVariable("text"), "limit": 50], type: .list(.object(SearchTicker.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchTickers: [SearchTicker?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "search_tickers": searchTickers.flatMap { (value: [SearchTicker?]) -> [ResultMap?] in value.map { (value: SearchTicker?) -> ResultMap? in value.flatMap { (value: SearchTicker) -> ResultMap in value.resultMap } } }])
    }

    public var searchTickers: [SearchTicker?]? {
      get {
        return (resultMap["search_tickers"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SearchTicker?] in value.map { (value: ResultMap?) -> SearchTicker? in value.flatMap { (value: ResultMap) -> SearchTicker in SearchTicker(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [SearchTicker?]) -> [ResultMap?] in value.map { (value: SearchTicker?) -> ResultMap? in value.flatMap { (value: SearchTicker) -> ResultMap in value.resultMap } } }, forKey: "search_tickers")
      }
    }

    public struct SearchTicker: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Ticker"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          GraphQLField("ticker", type: .object(Ticker.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(symbol: String, ticker: Ticker? = nil) {
        self.init(unsafeResultMap: ["__typename": "Ticker", "symbol": symbol, "ticker": ticker.flatMap { (value: Ticker) -> ResultMap in value.resultMap }])
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

      public var ticker: Ticker? {
        get {
          return (resultMap["ticker"] as? ResultMap).flatMap { Ticker(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "ticker")
        }
      }

      public struct Ticker: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["tickers"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RemoteTickerDetails.self),
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

          public var remoteTickerDetails: RemoteTickerDetails {
            get {
              return RemoteTickerDetails(unsafeResultMap: resultMap)
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
