// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class InsertTickerToWatchlistMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertTickerToWatchlist($profileID: Int!, $symbol: String!) {
      insert_app_profile_watchlist_tickers(
        objects: {profile_id: $profileID, symbol: $symbol}
      ) {
        __typename
        returning {
          __typename
          profile_id
          symbol
        }
      }
    }
    """

  public let operationName: String = "InsertTickerToWatchlist"

  public var profileID: Int
  public var symbol: String

  public init(profileID: Int, symbol: String) {
    self.profileID = profileID
    self.symbol = symbol
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "symbol": symbol]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_profile_watchlist_tickers", arguments: ["objects": ["profile_id": GraphQLVariable("profileID"), "symbol": GraphQLVariable("symbol")]], type: .object(InsertAppProfileWatchlistTicker.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfileWatchlistTickers: InsertAppProfileWatchlistTicker? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profile_watchlist_tickers": insertAppProfileWatchlistTickers.flatMap { (value: InsertAppProfileWatchlistTicker) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.profile_watchlist_tickers"
    public var insertAppProfileWatchlistTickers: InsertAppProfileWatchlistTicker? {
      get {
        return (resultMap["insert_app_profile_watchlist_tickers"] as? ResultMap).flatMap { InsertAppProfileWatchlistTicker(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profile_watchlist_tickers")
      }
    }

    public struct InsertAppProfileWatchlistTicker: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_watchlist_tickers_mutation_response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("returning", type: .nonNull(.list(.nonNull(.object(Returning.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(returning: [Returning]) {
        self.init(unsafeResultMap: ["__typename": "app_profile_watchlist_tickers_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// data from the rows affected by the mutation
      public var returning: [Returning] {
        get {
          return (resultMap["returning"] as! [ResultMap]).map { (value: ResultMap) -> Returning in Returning(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Returning) -> ResultMap in value.resultMap }, forKey: "returning")
        }
      }

      public struct Returning: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_watchlist_tickers"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(profileId: Int, symbol: String) {
          self.init(unsafeResultMap: ["__typename": "app_profile_watchlist_tickers", "profile_id": profileId, "symbol": symbol])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var profileId: Int {
          get {
            return resultMap["profile_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "profile_id")
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
      }
    }
  }
}
