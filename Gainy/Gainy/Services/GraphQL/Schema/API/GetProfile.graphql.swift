// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetProfileQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetProfile($profileID: Int!) {
      app_profiles(where: {id: {_eq: $profileID}}) {
        __typename
        avatar_url
        email
        first_name
        last_name
        legal_address
        id
        user_id
        profile_interests {
          __typename
          interest_id
        }
        profile_categories {
          __typename
          category_id
        }
        profile_favorite_collections {
          __typename
          collection_id
        }
        profile_watchlist_tickers {
          __typename
          symbol
        }
        profile_plaid_access_tokens {
          __typename
          id
          created_at
        }
      }
    }
    """

  public let operationName: String = "GetProfile"

  public var profileID: Int

  public init(profileID: Int) {
    self.profileID = profileID
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("app_profiles", arguments: ["where": ["id": ["_eq": GraphQLVariable("profileID")]]], type: .nonNull(.list(.nonNull(.object(AppProfile.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appProfiles: [AppProfile]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_profiles": appProfiles.map { (value: AppProfile) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.profiles"
    public var appProfiles: [AppProfile] {
      get {
        return (resultMap["app_profiles"] as! [ResultMap]).map { (value: ResultMap) -> AppProfile in AppProfile(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppProfile) -> ResultMap in value.resultMap }, forKey: "app_profiles")
      }
    }

    public struct AppProfile: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profiles"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatar_url", type: .scalar(String.self)),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("first_name", type: .nonNull(.scalar(String.self))),
          GraphQLField("last_name", type: .nonNull(.scalar(String.self))),
          GraphQLField("legal_address", type: .scalar(String.self)),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("user_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("profile_interests", type: .nonNull(.list(.nonNull(.object(ProfileInterest.selections))))),
          GraphQLField("profile_categories", type: .nonNull(.list(.nonNull(.object(ProfileCategory.selections))))),
          GraphQLField("profile_favorite_collections", type: .nonNull(.list(.nonNull(.object(ProfileFavoriteCollection.selections))))),
          GraphQLField("profile_watchlist_tickers", type: .nonNull(.list(.nonNull(.object(ProfileWatchlistTicker.selections))))),
          GraphQLField("profile_plaid_access_tokens", type: .nonNull(.list(.nonNull(.object(ProfilePlaidAccessToken.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(avatarUrl: String? = nil, email: String, firstName: String, lastName: String, legalAddress: String? = nil, id: Int, userId: String, profileInterests: [ProfileInterest], profileCategories: [ProfileCategory], profileFavoriteCollections: [ProfileFavoriteCollection], profileWatchlistTickers: [ProfileWatchlistTicker], profilePlaidAccessTokens: [ProfilePlaidAccessToken]) {
        self.init(unsafeResultMap: ["__typename": "app_profiles", "avatar_url": avatarUrl, "email": email, "first_name": firstName, "last_name": lastName, "legal_address": legalAddress, "id": id, "user_id": userId, "profile_interests": profileInterests.map { (value: ProfileInterest) -> ResultMap in value.resultMap }, "profile_categories": profileCategories.map { (value: ProfileCategory) -> ResultMap in value.resultMap }, "profile_favorite_collections": profileFavoriteCollections.map { (value: ProfileFavoriteCollection) -> ResultMap in value.resultMap }, "profile_watchlist_tickers": profileWatchlistTickers.map { (value: ProfileWatchlistTicker) -> ResultMap in value.resultMap }, "profile_plaid_access_tokens": profilePlaidAccessTokens.map { (value: ProfilePlaidAccessToken) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var avatarUrl: String? {
        get {
          return resultMap["avatar_url"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatar_url")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var firstName: String {
        get {
          return resultMap["first_name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "first_name")
        }
      }

      public var lastName: String {
        get {
          return resultMap["last_name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "last_name")
        }
      }

      public var legalAddress: String? {
        get {
          return resultMap["legal_address"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "legal_address")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var userId: String {
        get {
          return resultMap["user_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "user_id")
        }
      }

      /// An array relationship
      public var profileInterests: [ProfileInterest] {
        get {
          return (resultMap["profile_interests"] as! [ResultMap]).map { (value: ResultMap) -> ProfileInterest in ProfileInterest(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: ProfileInterest) -> ResultMap in value.resultMap }, forKey: "profile_interests")
        }
      }

      /// An array relationship
      public var profileCategories: [ProfileCategory] {
        get {
          return (resultMap["profile_categories"] as! [ResultMap]).map { (value: ResultMap) -> ProfileCategory in ProfileCategory(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: ProfileCategory) -> ResultMap in value.resultMap }, forKey: "profile_categories")
        }
      }

      /// An array relationship
      public var profileFavoriteCollections: [ProfileFavoriteCollection] {
        get {
          return (resultMap["profile_favorite_collections"] as! [ResultMap]).map { (value: ResultMap) -> ProfileFavoriteCollection in ProfileFavoriteCollection(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: ProfileFavoriteCollection) -> ResultMap in value.resultMap }, forKey: "profile_favorite_collections")
        }
      }

      /// An array relationship
      public var profileWatchlistTickers: [ProfileWatchlistTicker] {
        get {
          return (resultMap["profile_watchlist_tickers"] as! [ResultMap]).map { (value: ResultMap) -> ProfileWatchlistTicker in ProfileWatchlistTicker(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: ProfileWatchlistTicker) -> ResultMap in value.resultMap }, forKey: "profile_watchlist_tickers")
        }
      }

      /// An array relationship
      public var profilePlaidAccessTokens: [ProfilePlaidAccessToken] {
        get {
          return (resultMap["profile_plaid_access_tokens"] as! [ResultMap]).map { (value: ResultMap) -> ProfilePlaidAccessToken in ProfilePlaidAccessToken(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: ProfilePlaidAccessToken) -> ResultMap in value.resultMap }, forKey: "profile_plaid_access_tokens")
        }
      }

      public struct ProfileInterest: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_interests"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("interest_id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(interestId: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profile_interests", "interest_id": interestId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var interestId: Int {
          get {
            return resultMap["interest_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "interest_id")
          }
        }
      }

      public struct ProfileCategory: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_categories"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("category_id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(categoryId: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profile_categories", "category_id": categoryId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var categoryId: Int {
          get {
            return resultMap["category_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "category_id")
          }
        }
      }

      public struct ProfileFavoriteCollection: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_favorite_collections"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("collection_id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(collectionId: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profile_favorite_collections", "collection_id": collectionId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var collectionId: Int {
          get {
            return resultMap["collection_id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "collection_id")
          }
        }
      }

      public struct ProfileWatchlistTicker: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_watchlist_tickers"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("symbol", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(symbol: String) {
          self.init(unsafeResultMap: ["__typename": "app_profile_watchlist_tickers", "symbol": symbol])
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
      }

      public struct ProfilePlaidAccessToken: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["app_profile_plaid_access_tokens"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("created_at", type: .nonNull(.scalar(timestamptz.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, createdAt: timestamptz) {
          self.init(unsafeResultMap: ["__typename": "app_profile_plaid_access_tokens", "id": id, "created_at": createdAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var createdAt: timestamptz {
          get {
            return resultMap["created_at"]! as! timestamptz
          }
          set {
            resultMap.updateValue(newValue, forKey: "created_at")
          }
        }
      }
    }
  }
}
