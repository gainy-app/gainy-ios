// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class FetchNewsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchNews($symbol: String!) {
      fetchNewsData(symbol: $symbol) {
        __typename
        datetime
        description
        imageUrl
        sourceName
        sourceUrl
        title
        url
      }
    }
    """

  public let operationName: String = "FetchNews"

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
        GraphQLField("fetchNewsData", arguments: ["symbol": GraphQLVariable("symbol")], type: .list(.object(FetchNewsDatum.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(fetchNewsData: [FetchNewsDatum?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "fetchNewsData": fetchNewsData.flatMap { (value: [FetchNewsDatum?]) -> [ResultMap?] in value.map { (value: FetchNewsDatum?) -> ResultMap? in value.flatMap { (value: FetchNewsDatum) -> ResultMap in value.resultMap } } }])
    }

    public var fetchNewsData: [FetchNewsDatum?]? {
      get {
        return (resultMap["fetchNewsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [FetchNewsDatum?] in value.map { (value: ResultMap?) -> FetchNewsDatum? in value.flatMap { (value: ResultMap) -> FetchNewsDatum in FetchNewsDatum(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [FetchNewsDatum?]) -> [ResultMap?] in value.map { (value: FetchNewsDatum?) -> ResultMap? in value.flatMap { (value: FetchNewsDatum) -> ResultMap in value.resultMap } } }, forKey: "fetchNewsData")
      }
    }

    public struct FetchNewsDatum: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["NewsDataPoint"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("datetime", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("imageUrl", type: .scalar(String.self)),
          GraphQLField("sourceName", type: .scalar(String.self)),
          GraphQLField("sourceUrl", type: .scalar(String.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("url", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(datetime: String? = nil, description: String? = nil, imageUrl: String? = nil, sourceName: String? = nil, sourceUrl: String? = nil, title: String? = nil, url: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "NewsDataPoint", "datetime": datetime, "description": description, "imageUrl": imageUrl, "sourceName": sourceName, "sourceUrl": sourceUrl, "title": title, "url": url])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var datetime: String? {
        get {
          return resultMap["datetime"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "datetime")
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

      public var imageUrl: String? {
        get {
          return resultMap["imageUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "imageUrl")
        }
      }

      public var sourceName: String? {
        get {
          return resultMap["sourceName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "sourceName")
        }
      }

      public var sourceUrl: String? {
        get {
          return resultMap["sourceUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "sourceUrl")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var url: String? {
        get {
          return resultMap["url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }
    }
  }
}
