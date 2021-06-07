// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CollectionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Collections {
      collections {
        __typename
        id
        image
        name
        description
        stocks_count
        collection_tickers_symbols {
          __typename
          ticker_symbol
        }
        favorite_collections {
          __typename
          is_default
        }
      }
    }
    """

  public let operationName: String = "Collections"

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
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("image", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("stocks_count", type: .nonNull(.scalar(String.self))),
          GraphQLField("collection_tickers_symbols", type: .nonNull(.list(.nonNull(.object(CollectionTickersSymbol.selections))))),
          GraphQLField("favorite_collections", type: .nonNull(.list(.nonNull(.object(FavoriteCollection.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: String, image: String, name: String, description: String, stocksCount: String, collectionTickersSymbols: [CollectionTickersSymbol], favoriteCollections: [FavoriteCollection]) {
        self.init(unsafeResultMap: ["__typename": "collections", "id": id, "image": image, "name": name, "description": description, "stocks_count": stocksCount, "collection_tickers_symbols": collectionTickersSymbols.map { (value: CollectionTickersSymbol) -> ResultMap in value.resultMap }, "favorite_collections": favoriteCollections.map { (value: FavoriteCollection) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: String {
        get {
          return resultMap["id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var image: String {
        get {
          return resultMap["image"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "image")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var stocksCount: String {
        get {
          return resultMap["stocks_count"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "stocks_count")
        }
      }

      /// An array relationship
      public var collectionTickersSymbols: [CollectionTickersSymbol] {
        get {
          return (resultMap["collection_tickers_symbols"] as! [ResultMap]).map { (value: ResultMap) -> CollectionTickersSymbol in CollectionTickersSymbol(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: CollectionTickersSymbol) -> ResultMap in value.resultMap }, forKey: "collection_tickers_symbols")
        }
      }

      /// An array relationship
      public var favoriteCollections: [FavoriteCollection] {
        get {
          return (resultMap["favorite_collections"] as! [ResultMap]).map { (value: ResultMap) -> FavoriteCollection in FavoriteCollection(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: FavoriteCollection) -> ResultMap in value.resultMap }, forKey: "favorite_collections")
        }
      }

      public struct CollectionTickersSymbol: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["collection_tickers_symbols"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("ticker_symbol", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(tickerSymbol: String) {
          self.init(unsafeResultMap: ["__typename": "collection_tickers_symbols", "ticker_symbol": tickerSymbol])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var tickerSymbol: String {
          get {
            return resultMap["ticker_symbol"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "ticker_symbol")
          }
        }
      }

      public struct FavoriteCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["favorite_collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("is_default", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(isDefault: Bool) {
          self.init(unsafeResultMap: ["__typename": "favorite_collections", "is_default": isDefault])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var isDefault: Bool {
          get {
            return resultMap["is_default"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "is_default")
          }
        }
      }
    }
  }
}
