// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// input type for inserting data into table "app.profile_interests"
public struct app_profile_interests_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profile
  ///   - profileId
  public init(interestId: Swift.Optional<Int?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile": profile, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<Int?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// input type for inserting object relation for remote table "app.profiles"
public struct app_profiles_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_profiles_insert_input, onConflict: Swift.Optional<app_profiles_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_profiles_insert_input {
    get {
      return graphQLMap["data"] as! app_profiles_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profiles_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profiles_on_conflict?> ?? Swift.Optional<app_profiles_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profiles"
public struct app_profiles_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avatarUrl
  ///   - createdAt
  ///   - email
  ///   - firstName
  ///   - gender
  ///   - id
  ///   - lastName
  ///   - legalAddress
  ///   - portfolioGains
  ///   - profileCategories
  ///   - profileFavoriteCollections
  ///   - profileHoldings
  ///   - profileInterests
  ///   - profilePlaidAccessTokens
  ///   - profileScoringSetting
  ///   - profileWatchlistTickers
  ///   - userId
  public init(avatarUrl: Swift.Optional<String?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, email: Swift.Optional<String?> = nil, firstName: Swift.Optional<String?> = nil, gender: Swift.Optional<Int?> = nil, id: Swift.Optional<Int?> = nil, lastName: Swift.Optional<String?> = nil, legalAddress: Swift.Optional<String?> = nil, portfolioGains: Swift.Optional<portfolio_gains_obj_rel_insert_input?> = nil, profileCategories: Swift.Optional<app_profile_categories_arr_rel_insert_input?> = nil, profileFavoriteCollections: Swift.Optional<app_profile_favorite_collections_arr_rel_insert_input?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> = nil, profileInterests: Swift.Optional<app_profile_interests_arr_rel_insert_input?> = nil, profilePlaidAccessTokens: Swift.Optional<app_profile_plaid_access_tokens_arr_rel_insert_input?> = nil, profileScoringSetting: Swift.Optional<app_profile_scoring_settings_obj_rel_insert_input?> = nil, profileWatchlistTickers: Swift.Optional<app_profile_watchlist_tickers_arr_rel_insert_input?> = nil, userId: Swift.Optional<String?> = nil) {
    graphQLMap = ["avatar_url": avatarUrl, "created_at": createdAt, "email": email, "first_name": firstName, "gender": gender, "id": id, "last_name": lastName, "legal_address": legalAddress, "portfolio_gains": portfolioGains, "profile_categories": profileCategories, "profile_favorite_collections": profileFavoriteCollections, "profile_holdings": profileHoldings, "profile_interests": profileInterests, "profile_plaid_access_tokens": profilePlaidAccessTokens, "profile_scoring_setting": profileScoringSetting, "profile_watchlist_tickers": profileWatchlistTickers, "user_id": userId]
  }

  public var avatarUrl: Swift.Optional<String?> {
    get {
      return graphQLMap["avatar_url"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avatar_url")
    }
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var email: Swift.Optional<String?> {
    get {
      return graphQLMap["email"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var firstName: Swift.Optional<String?> {
    get {
      return graphQLMap["first_name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "first_name")
    }
  }

  public var gender: Swift.Optional<Int?> {
    get {
      return graphQLMap["gender"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gender")
    }
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var lastName: Swift.Optional<String?> {
    get {
      return graphQLMap["last_name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_name")
    }
  }

  public var legalAddress: Swift.Optional<String?> {
    get {
      return graphQLMap["legal_address"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "legal_address")
    }
  }

  public var portfolioGains: Swift.Optional<portfolio_gains_obj_rel_insert_input?> {
    get {
      return graphQLMap["portfolio_gains"] as? Swift.Optional<portfolio_gains_obj_rel_insert_input?> ?? Swift.Optional<portfolio_gains_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_gains")
    }
  }

  public var profileCategories: Swift.Optional<app_profile_categories_arr_rel_insert_input?> {
    get {
      return graphQLMap["profile_categories"] as? Swift.Optional<app_profile_categories_arr_rel_insert_input?> ?? Swift.Optional<app_profile_categories_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_categories")
    }
  }

  public var profileFavoriteCollections: Swift.Optional<app_profile_favorite_collections_arr_rel_insert_input?> {
    get {
      return graphQLMap["profile_favorite_collections"] as? Swift.Optional<app_profile_favorite_collections_arr_rel_insert_input?> ?? Swift.Optional<app_profile_favorite_collections_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_favorite_collections")
    }
  }

  public var profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> {
    get {
      return graphQLMap["profile_holdings"] as? Swift.Optional<app_profile_holdings_arr_rel_insert_input?> ?? Swift.Optional<app_profile_holdings_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_holdings")
    }
  }

  public var profileInterests: Swift.Optional<app_profile_interests_arr_rel_insert_input?> {
    get {
      return graphQLMap["profile_interests"] as? Swift.Optional<app_profile_interests_arr_rel_insert_input?> ?? Swift.Optional<app_profile_interests_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_interests")
    }
  }

  public var profilePlaidAccessTokens: Swift.Optional<app_profile_plaid_access_tokens_arr_rel_insert_input?> {
    get {
      return graphQLMap["profile_plaid_access_tokens"] as? Swift.Optional<app_profile_plaid_access_tokens_arr_rel_insert_input?> ?? Swift.Optional<app_profile_plaid_access_tokens_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_plaid_access_tokens")
    }
  }

  public var profileScoringSetting: Swift.Optional<app_profile_scoring_settings_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile_scoring_setting"] as? Swift.Optional<app_profile_scoring_settings_obj_rel_insert_input?> ?? Swift.Optional<app_profile_scoring_settings_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_scoring_setting")
    }
  }

  public var profileWatchlistTickers: Swift.Optional<app_profile_watchlist_tickers_arr_rel_insert_input?> {
    get {
      return graphQLMap["profile_watchlist_tickers"] as? Swift.Optional<app_profile_watchlist_tickers_arr_rel_insert_input?> ?? Swift.Optional<app_profile_watchlist_tickers_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_watchlist_tickers")
    }
  }

  public var userId: Swift.Optional<String?> {
    get {
      return graphQLMap["user_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "user_id")
    }
  }
}

/// input type for inserting object relation for remote table "portfolio_gains"
public struct portfolio_gains_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: portfolio_gains_insert_input, onConflict: Swift.Optional<portfolio_gains_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: portfolio_gains_insert_input {
    get {
      return graphQLMap["data"] as! portfolio_gains_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<portfolio_gains_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<portfolio_gains_on_conflict?> ?? Swift.Optional<portfolio_gains_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "portfolio_gains"
public struct portfolio_gains_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - absoluteGain_1d
  ///   - absoluteGain_1m
  ///   - absoluteGain_1w
  ///   - absoluteGain_1y
  ///   - absoluteGain_3m
  ///   - absoluteGain_5y
  ///   - absoluteGainTotal
  ///   - actualValue
  ///   - profile
  ///   - profileId
  ///   - relativeGain_1d
  ///   - relativeGain_1m
  ///   - relativeGain_1w
  ///   - relativeGain_1y
  ///   - relativeGain_3m
  ///   - relativeGain_5y
  ///   - relativeGainTotal
  ///   - updatedAt
  public init(absoluteGain_1d: Swift.Optional<float8?> = nil, absoluteGain_1m: Swift.Optional<float8?> = nil, absoluteGain_1w: Swift.Optional<float8?> = nil, absoluteGain_1y: Swift.Optional<float8?> = nil, absoluteGain_3m: Swift.Optional<float8?> = nil, absoluteGain_5y: Swift.Optional<float8?> = nil, absoluteGainTotal: Swift.Optional<float8?> = nil, actualValue: Swift.Optional<float8?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, relativeGain_1d: Swift.Optional<float8?> = nil, relativeGain_1m: Swift.Optional<float8?> = nil, relativeGain_1w: Swift.Optional<float8?> = nil, relativeGain_1y: Swift.Optional<float8?> = nil, relativeGain_3m: Swift.Optional<float8?> = nil, relativeGain_5y: Swift.Optional<float8?> = nil, relativeGainTotal: Swift.Optional<float8?> = nil, updatedAt: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "profile": profile, "profile_id": profileId, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "updated_at": updatedAt]
  }

  public var absoluteGain_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1d")
    }
  }

  public var absoluteGain_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1m")
    }
  }

  public var absoluteGain_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1w")
    }
  }

  public var absoluteGain_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1y")
    }
  }

  public var absoluteGain_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_3m")
    }
  }

  public var absoluteGain_5y: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_5y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_5y")
    }
  }

  public var absoluteGainTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_total")
    }
  }

  public var actualValue: Swift.Optional<float8?> {
    get {
      return graphQLMap["actual_value"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "actual_value")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var relativeGain_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGain_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1m")
    }
  }

  public var relativeGain_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1w")
    }
  }

  public var relativeGain_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1y")
    }
  }

  public var relativeGain_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_3m")
    }
  }

  public var relativeGain_5y: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_5y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_5y")
    }
  }

  public var relativeGainTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// on conflict condition type for table "portfolio_gains"
public struct portfolio_gains_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: portfolio_gains_constraint, updateColumns: [portfolio_gains_update_column], `where`: Swift.Optional<portfolio_gains_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: portfolio_gains_constraint {
    get {
      return graphQLMap["constraint"] as! portfolio_gains_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [portfolio_gains_update_column] {
    get {
      return graphQLMap["update_columns"] as! [portfolio_gains_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<portfolio_gains_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<portfolio_gains_bool_exp?> ?? Swift.Optional<portfolio_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "portfolio_gains"
public enum portfolio_gains_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case portfolioGainsUniqueProfileId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "portfolio_gains_unique_profile_id": self = .portfolioGainsUniqueProfileId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .portfolioGainsUniqueProfileId: return "portfolio_gains_unique_profile_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: portfolio_gains_constraint, rhs: portfolio_gains_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.portfolioGainsUniqueProfileId, .portfolioGainsUniqueProfileId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [portfolio_gains_constraint] {
    return [
      .portfolioGainsUniqueProfileId,
    ]
  }
}

/// update columns of table "portfolio_gains"
public enum portfolio_gains_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case absoluteGain_1d
  /// column name
  case absoluteGain_1m
  /// column name
  case absoluteGain_1w
  /// column name
  case absoluteGain_1y
  /// column name
  case absoluteGain_3m
  /// column name
  case absoluteGain_5y
  /// column name
  case absoluteGainTotal
  /// column name
  case actualValue
  /// column name
  case profileId
  /// column name
  case relativeGain_1d
  /// column name
  case relativeGain_1m
  /// column name
  case relativeGain_1w
  /// column name
  case relativeGain_1y
  /// column name
  case relativeGain_3m
  /// column name
  case relativeGain_5y
  /// column name
  case relativeGainTotal
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "absolute_gain_1d": self = .absoluteGain_1d
      case "absolute_gain_1m": self = .absoluteGain_1m
      case "absolute_gain_1w": self = .absoluteGain_1w
      case "absolute_gain_1y": self = .absoluteGain_1y
      case "absolute_gain_3m": self = .absoluteGain_3m
      case "absolute_gain_5y": self = .absoluteGain_5y
      case "absolute_gain_total": self = .absoluteGainTotal
      case "actual_value": self = .actualValue
      case "profile_id": self = .profileId
      case "relative_gain_1d": self = .relativeGain_1d
      case "relative_gain_1m": self = .relativeGain_1m
      case "relative_gain_1w": self = .relativeGain_1w
      case "relative_gain_1y": self = .relativeGain_1y
      case "relative_gain_3m": self = .relativeGain_3m
      case "relative_gain_5y": self = .relativeGain_5y
      case "relative_gain_total": self = .relativeGainTotal
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .absoluteGain_1d: return "absolute_gain_1d"
      case .absoluteGain_1m: return "absolute_gain_1m"
      case .absoluteGain_1w: return "absolute_gain_1w"
      case .absoluteGain_1y: return "absolute_gain_1y"
      case .absoluteGain_3m: return "absolute_gain_3m"
      case .absoluteGain_5y: return "absolute_gain_5y"
      case .absoluteGainTotal: return "absolute_gain_total"
      case .actualValue: return "actual_value"
      case .profileId: return "profile_id"
      case .relativeGain_1d: return "relative_gain_1d"
      case .relativeGain_1m: return "relative_gain_1m"
      case .relativeGain_1w: return "relative_gain_1w"
      case .relativeGain_1y: return "relative_gain_1y"
      case .relativeGain_3m: return "relative_gain_3m"
      case .relativeGain_5y: return "relative_gain_5y"
      case .relativeGainTotal: return "relative_gain_total"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: portfolio_gains_update_column, rhs: portfolio_gains_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.absoluteGain_1d, .absoluteGain_1d): return true
      case (.absoluteGain_1m, .absoluteGain_1m): return true
      case (.absoluteGain_1w, .absoluteGain_1w): return true
      case (.absoluteGain_1y, .absoluteGain_1y): return true
      case (.absoluteGain_3m, .absoluteGain_3m): return true
      case (.absoluteGain_5y, .absoluteGain_5y): return true
      case (.absoluteGainTotal, .absoluteGainTotal): return true
      case (.actualValue, .actualValue): return true
      case (.profileId, .profileId): return true
      case (.relativeGain_1d, .relativeGain_1d): return true
      case (.relativeGain_1m, .relativeGain_1m): return true
      case (.relativeGain_1w, .relativeGain_1w): return true
      case (.relativeGain_1y, .relativeGain_1y): return true
      case (.relativeGain_3m, .relativeGain_3m): return true
      case (.relativeGain_5y, .relativeGain_5y): return true
      case (.relativeGainTotal, .relativeGainTotal): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [portfolio_gains_update_column] {
    return [
      .absoluteGain_1d,
      .absoluteGain_1m,
      .absoluteGain_1w,
      .absoluteGain_1y,
      .absoluteGain_3m,
      .absoluteGain_5y,
      .absoluteGainTotal,
      .actualValue,
      .profileId,
      .relativeGain_1d,
      .relativeGain_1m,
      .relativeGain_1w,
      .relativeGain_1y,
      .relativeGain_3m,
      .relativeGain_5y,
      .relativeGainTotal,
      .updatedAt,
    ]
  }
}

/// Boolean expression to filter rows from the table "portfolio_gains". All fields are combined with a logical 'AND'.
public struct portfolio_gains_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - absoluteGain_1d
  ///   - absoluteGain_1m
  ///   - absoluteGain_1w
  ///   - absoluteGain_1y
  ///   - absoluteGain_3m
  ///   - absoluteGain_5y
  ///   - absoluteGainTotal
  ///   - actualValue
  ///   - profile
  ///   - profileId
  ///   - relativeGain_1d
  ///   - relativeGain_1m
  ///   - relativeGain_1w
  ///   - relativeGain_1y
  ///   - relativeGain_3m
  ///   - relativeGain_5y
  ///   - relativeGainTotal
  ///   - updatedAt
  public init(_and: Swift.Optional<[portfolio_gains_bool_exp]?> = nil, _not: Swift.Optional<portfolio_gains_bool_exp?> = nil, _or: Swift.Optional<[portfolio_gains_bool_exp]?> = nil, absoluteGain_1d: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1m: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1w: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1y: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_3m: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_5y: Swift.Optional<float8_comparison_exp?> = nil, absoluteGainTotal: Swift.Optional<float8_comparison_exp?> = nil, actualValue: Swift.Optional<float8_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, relativeGain_1d: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1m: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1w: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1y: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_3m: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_5y: Swift.Optional<float8_comparison_exp?> = nil, relativeGainTotal: Swift.Optional<float8_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "profile": profile, "profile_id": profileId, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[portfolio_gains_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[portfolio_gains_bool_exp]?> ?? Swift.Optional<[portfolio_gains_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<portfolio_gains_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<portfolio_gains_bool_exp?> ?? Swift.Optional<portfolio_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[portfolio_gains_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[portfolio_gains_bool_exp]?> ?? Swift.Optional<[portfolio_gains_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var absoluteGain_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1d")
    }
  }

  public var absoluteGain_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1m")
    }
  }

  public var absoluteGain_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1w")
    }
  }

  public var absoluteGain_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1y")
    }
  }

  public var absoluteGain_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_3m")
    }
  }

  public var absoluteGain_5y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_5y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_5y")
    }
  }

  public var absoluteGainTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_total")
    }
  }

  public var actualValue: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["actual_value"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "actual_value")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var relativeGain_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGain_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1m")
    }
  }

  public var relativeGain_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1w")
    }
  }

  public var relativeGain_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1y")
    }
  }

  public var relativeGain_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_3m")
    }
  }

  public var relativeGain_5y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_5y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_5y")
    }
  }

  public var relativeGainTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to compare columns of type "float8". All fields are combined with logical 'AND'.
public struct float8_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _in
  ///   - _isNull
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nin
  public init(_eq: Swift.Optional<float8?> = nil, _gt: Swift.Optional<float8?> = nil, _gte: Swift.Optional<float8?> = nil, _in: Swift.Optional<[float8]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<float8?> = nil, _lte: Swift.Optional<float8?> = nil, _neq: Swift.Optional<float8?> = nil, _nin: Swift.Optional<[float8]?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  public var _eq: Swift.Optional<float8?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<float8?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<float8?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  public var _in: Swift.Optional<[float8]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[float8]?> ?? Swift.Optional<[float8]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_in")
    }
  }

  public var _isNull: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_is_null"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_is_null")
    }
  }

  public var _lt: Swift.Optional<float8?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<float8?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<float8?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[float8]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[float8]?> ?? Swift.Optional<[float8]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profiles". All fields are combined with a logical 'AND'.
public struct app_profiles_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - avatarUrl
  ///   - createdAt
  ///   - email
  ///   - firstName
  ///   - gender
  ///   - id
  ///   - lastName
  ///   - legalAddress
  ///   - portfolioGains
  ///   - profileCategories
  ///   - profileFavoriteCollections
  ///   - profileHoldings
  ///   - profileInterests
  ///   - profilePlaidAccessTokens
  ///   - profileScoringSetting
  ///   - profileWatchlistTickers
  ///   - userId
  public init(_and: Swift.Optional<[app_profiles_bool_exp]?> = nil, _not: Swift.Optional<app_profiles_bool_exp?> = nil, _or: Swift.Optional<[app_profiles_bool_exp]?> = nil, avatarUrl: Swift.Optional<String_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, email: Swift.Optional<String_comparison_exp?> = nil, firstName: Swift.Optional<String_comparison_exp?> = nil, gender: Swift.Optional<Int_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, lastName: Swift.Optional<String_comparison_exp?> = nil, legalAddress: Swift.Optional<String_comparison_exp?> = nil, portfolioGains: Swift.Optional<portfolio_gains_bool_exp?> = nil, profileCategories: Swift.Optional<app_profile_categories_bool_exp?> = nil, profileFavoriteCollections: Swift.Optional<app_profile_favorite_collections_bool_exp?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> = nil, profileInterests: Swift.Optional<app_profile_interests_bool_exp?> = nil, profilePlaidAccessTokens: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> = nil, profileScoringSetting: Swift.Optional<app_profile_scoring_settings_bool_exp?> = nil, profileWatchlistTickers: Swift.Optional<app_profile_watchlist_tickers_bool_exp?> = nil, userId: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "avatar_url": avatarUrl, "created_at": createdAt, "email": email, "first_name": firstName, "gender": gender, "id": id, "last_name": lastName, "legal_address": legalAddress, "portfolio_gains": portfolioGains, "profile_categories": profileCategories, "profile_favorite_collections": profileFavoriteCollections, "profile_holdings": profileHoldings, "profile_interests": profileInterests, "profile_plaid_access_tokens": profilePlaidAccessTokens, "profile_scoring_setting": profileScoringSetting, "profile_watchlist_tickers": profileWatchlistTickers, "user_id": userId]
  }

  public var _and: Swift.Optional<[app_profiles_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profiles_bool_exp]?> ?? Swift.Optional<[app_profiles_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profiles_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profiles_bool_exp]?> ?? Swift.Optional<[app_profiles_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var avatarUrl: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["avatar_url"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avatar_url")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var email: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["email"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var firstName: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["first_name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "first_name")
    }
  }

  public var gender: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["gender"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gender")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var lastName: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["last_name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_name")
    }
  }

  public var legalAddress: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["legal_address"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "legal_address")
    }
  }

  public var portfolioGains: Swift.Optional<portfolio_gains_bool_exp?> {
    get {
      return graphQLMap["portfolio_gains"] as? Swift.Optional<portfolio_gains_bool_exp?> ?? Swift.Optional<portfolio_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_gains")
    }
  }

  public var profileCategories: Swift.Optional<app_profile_categories_bool_exp?> {
    get {
      return graphQLMap["profile_categories"] as? Swift.Optional<app_profile_categories_bool_exp?> ?? Swift.Optional<app_profile_categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_categories")
    }
  }

  public var profileFavoriteCollections: Swift.Optional<app_profile_favorite_collections_bool_exp?> {
    get {
      return graphQLMap["profile_favorite_collections"] as? Swift.Optional<app_profile_favorite_collections_bool_exp?> ?? Swift.Optional<app_profile_favorite_collections_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_favorite_collections")
    }
  }

  public var profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> {
    get {
      return graphQLMap["profile_holdings"] as? Swift.Optional<app_profile_holdings_bool_exp?> ?? Swift.Optional<app_profile_holdings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_holdings")
    }
  }

  public var profileInterests: Swift.Optional<app_profile_interests_bool_exp?> {
    get {
      return graphQLMap["profile_interests"] as? Swift.Optional<app_profile_interests_bool_exp?> ?? Swift.Optional<app_profile_interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_interests")
    }
  }

  public var profilePlaidAccessTokens: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> {
    get {
      return graphQLMap["profile_plaid_access_tokens"] as? Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> ?? Swift.Optional<app_profile_plaid_access_tokens_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_plaid_access_tokens")
    }
  }

  public var profileScoringSetting: Swift.Optional<app_profile_scoring_settings_bool_exp?> {
    get {
      return graphQLMap["profile_scoring_setting"] as? Swift.Optional<app_profile_scoring_settings_bool_exp?> ?? Swift.Optional<app_profile_scoring_settings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_scoring_setting")
    }
  }

  public var profileWatchlistTickers: Swift.Optional<app_profile_watchlist_tickers_bool_exp?> {
    get {
      return graphQLMap["profile_watchlist_tickers"] as? Swift.Optional<app_profile_watchlist_tickers_bool_exp?> ?? Swift.Optional<app_profile_watchlist_tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_watchlist_tickers")
    }
  }

  public var userId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["user_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "user_id")
    }
  }
}

/// Boolean expression to compare columns of type "String". All fields are combined with logical 'AND'.
public struct String_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _ilike: does the column match the given case-insensitive pattern
  ///   - _in
  ///   - _iregex: does the column match the given POSIX regular expression, case insensitive
  ///   - _isNull
  ///   - _like: does the column match the given pattern
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nilike: does the column NOT match the given case-insensitive pattern
  ///   - _nin
  ///   - _niregex: does the column NOT match the given POSIX regular expression, case insensitive
  ///   - _nlike: does the column NOT match the given pattern
  ///   - _nregex: does the column NOT match the given POSIX regular expression, case sensitive
  ///   - _nsimilar: does the column NOT match the given SQL regular expression
  ///   - _regex: does the column match the given POSIX regular expression, case sensitive
  ///   - _similar: does the column match the given SQL regular expression
  public init(_eq: Swift.Optional<String?> = nil, _gt: Swift.Optional<String?> = nil, _gte: Swift.Optional<String?> = nil, _ilike: Swift.Optional<String?> = nil, _in: Swift.Optional<[String]?> = nil, _iregex: Swift.Optional<String?> = nil, _isNull: Swift.Optional<Bool?> = nil, _like: Swift.Optional<String?> = nil, _lt: Swift.Optional<String?> = nil, _lte: Swift.Optional<String?> = nil, _neq: Swift.Optional<String?> = nil, _nilike: Swift.Optional<String?> = nil, _nin: Swift.Optional<[String]?> = nil, _niregex: Swift.Optional<String?> = nil, _nlike: Swift.Optional<String?> = nil, _nregex: Swift.Optional<String?> = nil, _nsimilar: Swift.Optional<String?> = nil, _regex: Swift.Optional<String?> = nil, _similar: Swift.Optional<String?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_ilike": _ilike, "_in": _in, "_iregex": _iregex, "_is_null": _isNull, "_like": _like, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nilike": _nilike, "_nin": _nin, "_niregex": _niregex, "_nlike": _nlike, "_nregex": _nregex, "_nsimilar": _nsimilar, "_regex": _regex, "_similar": _similar]
  }

  public var _eq: Swift.Optional<String?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<String?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<String?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  /// does the column match the given case-insensitive pattern
  public var _ilike: Swift.Optional<String?> {
    get {
      return graphQLMap["_ilike"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_ilike")
    }
  }

  public var _in: Swift.Optional<[String]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[String]?> ?? Swift.Optional<[String]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_in")
    }
  }

  /// does the column match the given POSIX regular expression, case insensitive
  public var _iregex: Swift.Optional<String?> {
    get {
      return graphQLMap["_iregex"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_iregex")
    }
  }

  public var _isNull: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_is_null"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_is_null")
    }
  }

  /// does the column match the given pattern
  public var _like: Swift.Optional<String?> {
    get {
      return graphQLMap["_like"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_like")
    }
  }

  public var _lt: Swift.Optional<String?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<String?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<String?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  /// does the column NOT match the given case-insensitive pattern
  public var _nilike: Swift.Optional<String?> {
    get {
      return graphQLMap["_nilike"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nilike")
    }
  }

  public var _nin: Swift.Optional<[String]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[String]?> ?? Swift.Optional<[String]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }

  /// does the column NOT match the given POSIX regular expression, case insensitive
  public var _niregex: Swift.Optional<String?> {
    get {
      return graphQLMap["_niregex"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_niregex")
    }
  }

  /// does the column NOT match the given pattern
  public var _nlike: Swift.Optional<String?> {
    get {
      return graphQLMap["_nlike"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nlike")
    }
  }

  /// does the column NOT match the given POSIX regular expression, case sensitive
  public var _nregex: Swift.Optional<String?> {
    get {
      return graphQLMap["_nregex"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nregex")
    }
  }

  /// does the column NOT match the given SQL regular expression
  public var _nsimilar: Swift.Optional<String?> {
    get {
      return graphQLMap["_nsimilar"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nsimilar")
    }
  }

  /// does the column match the given POSIX regular expression, case sensitive
  public var _regex: Swift.Optional<String?> {
    get {
      return graphQLMap["_regex"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_regex")
    }
  }

  /// does the column match the given SQL regular expression
  public var _similar: Swift.Optional<String?> {
    get {
      return graphQLMap["_similar"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_similar")
    }
  }
}

/// Boolean expression to compare columns of type "timestamptz". All fields are combined with logical 'AND'.
public struct timestamptz_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _in
  ///   - _isNull
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nin
  public init(_eq: Swift.Optional<timestamptz?> = nil, _gt: Swift.Optional<timestamptz?> = nil, _gte: Swift.Optional<timestamptz?> = nil, _in: Swift.Optional<[timestamptz]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<timestamptz?> = nil, _lte: Swift.Optional<timestamptz?> = nil, _neq: Swift.Optional<timestamptz?> = nil, _nin: Swift.Optional<[timestamptz]?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  public var _eq: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  public var _in: Swift.Optional<[timestamptz]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[timestamptz]?> ?? Swift.Optional<[timestamptz]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_in")
    }
  }

  public var _isNull: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_is_null"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_is_null")
    }
  }

  public var _lt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[timestamptz]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[timestamptz]?> ?? Swift.Optional<[timestamptz]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }
}

/// Boolean expression to compare columns of type "Int". All fields are combined with logical 'AND'.
public struct Int_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _in
  ///   - _isNull
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nin
  public init(_eq: Swift.Optional<Int?> = nil, _gt: Swift.Optional<Int?> = nil, _gte: Swift.Optional<Int?> = nil, _in: Swift.Optional<[Int]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<Int?> = nil, _lte: Swift.Optional<Int?> = nil, _neq: Swift.Optional<Int?> = nil, _nin: Swift.Optional<[Int]?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  public var _eq: Swift.Optional<Int?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<Int?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<Int?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  public var _in: Swift.Optional<[Int]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[Int]?> ?? Swift.Optional<[Int]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_in")
    }
  }

  public var _isNull: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_is_null"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_is_null")
    }
  }

  public var _lt: Swift.Optional<Int?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<Int?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<Int?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[Int]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[Int]?> ?? Swift.Optional<[Int]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_categories". All fields are combined with a logical 'AND'.
public struct app_profile_categories_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - categoryId
  ///   - profile
  ///   - profileId
  public init(_and: Swift.Optional<[app_profile_categories_bool_exp]?> = nil, _not: Swift.Optional<app_profile_categories_bool_exp?> = nil, _or: Swift.Optional<[app_profile_categories_bool_exp]?> = nil, categoryId: Swift.Optional<Int_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "category_id": categoryId, "profile": profile, "profile_id": profileId]
  }

  public var _and: Swift.Optional<[app_profile_categories_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_categories_bool_exp]?> ?? Swift.Optional<[app_profile_categories_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_categories_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_categories_bool_exp?> ?? Swift.Optional<app_profile_categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_categories_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_categories_bool_exp]?> ?? Swift.Optional<[app_profile_categories_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var categoryId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_favorite_collections". All fields are combined with a logical 'AND'.
public struct app_profile_favorite_collections_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - collectionId
  ///   - profile
  ///   - profileId
  public init(_and: Swift.Optional<[app_profile_favorite_collections_bool_exp]?> = nil, _not: Swift.Optional<app_profile_favorite_collections_bool_exp?> = nil, _or: Swift.Optional<[app_profile_favorite_collections_bool_exp]?> = nil, collectionId: Swift.Optional<Int_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "collection_id": collectionId, "profile": profile, "profile_id": profileId]
  }

  public var _and: Swift.Optional<[app_profile_favorite_collections_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_favorite_collections_bool_exp]?> ?? Swift.Optional<[app_profile_favorite_collections_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_favorite_collections_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_favorite_collections_bool_exp?> ?? Swift.Optional<app_profile_favorite_collections_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_favorite_collections_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_favorite_collections_bool_exp]?> ?? Swift.Optional<[app_profile_favorite_collections_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var collectionId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_holdings". All fields are combined with a logical 'AND'.
public struct app_profile_holdings_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - account
  ///   - accountId
  ///   - createdAt
  ///   - holdingDetails
  ///   - holdingTransactions
  ///   - id
  ///   - isoCurrencyCode
  ///   - plaidAccessTokenId
  ///   - portfolioHoldingGains
  ///   - profile
  ///   - profileId
  ///   - quantity
  ///   - refId
  ///   - security
  ///   - securityId
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_profile_holdings_bool_exp]?> = nil, _not: Swift.Optional<app_profile_holdings_bool_exp?> = nil, _or: Swift.Optional<[app_profile_holdings_bool_exp]?> = nil, account: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> = nil, accountId: Swift.Optional<Int_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, holdingDetails: Swift.Optional<portfolio_holding_details_bool_exp?> = nil, holdingTransactions: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, isoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, plaidAccessTokenId: Swift.Optional<Int_comparison_exp?> = nil, portfolioHoldingGains: Swift.Optional<portfolio_holding_gains_bool_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, quantity: Swift.Optional<float8_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, security: Swift.Optional<app_portfolio_securities_bool_exp?> = nil, securityId: Swift.Optional<Int_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "account": account, "account_id": accountId, "created_at": createdAt, "holding_details": holdingDetails, "holding_transactions": holdingTransactions, "id": id, "iso_currency_code": isoCurrencyCode, "plaid_access_token_id": plaidAccessTokenId, "portfolio_holding_gains": portfolioHoldingGains, "profile": profile, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[app_profile_holdings_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_holdings_bool_exp]?> ?? Swift.Optional<[app_profile_holdings_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_holdings_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_holdings_bool_exp?> ?? Swift.Optional<app_profile_holdings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_holdings_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_holdings_bool_exp]?> ?? Swift.Optional<[app_profile_holdings_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var account: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> {
    get {
      return graphQLMap["account"] as? Swift.Optional<app_profile_portfolio_accounts_bool_exp?> ?? Swift.Optional<app_profile_portfolio_accounts_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account")
    }
  }

  public var accountId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var holdingDetails: Swift.Optional<portfolio_holding_details_bool_exp?> {
    get {
      return graphQLMap["holding_details"] as? Swift.Optional<portfolio_holding_details_bool_exp?> ?? Swift.Optional<portfolio_holding_details_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding_details")
    }
  }

  public var holdingTransactions: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> {
    get {
      return graphQLMap["holding_transactions"] as? Swift.Optional<app_profile_portfolio_transactions_bool_exp?> ?? Swift.Optional<app_profile_portfolio_transactions_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding_transactions")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var isoCurrencyCode: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["iso_currency_code"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "iso_currency_code")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var portfolioHoldingGains: Swift.Optional<portfolio_holding_gains_bool_exp?> {
    get {
      return graphQLMap["portfolio_holding_gains"] as? Swift.Optional<portfolio_holding_gains_bool_exp?> ?? Swift.Optional<portfolio_holding_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_holding_gains")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var refId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var security: Swift.Optional<app_portfolio_securities_bool_exp?> {
    get {
      return graphQLMap["security"] as? Swift.Optional<app_portfolio_securities_bool_exp?> ?? Swift.Optional<app_portfolio_securities_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security")
    }
  }

  public var securityId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }

  public var updatedAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_portfolio_accounts". All fields are combined with a logical 'AND'.
public struct app_profile_portfolio_accounts_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - balanceAvailable
  ///   - balanceCurrent
  ///   - balanceIsoCurrencyCode
  ///   - balanceLimit
  ///   - createdAt
  ///   - id
  ///   - mask
  ///   - name
  ///   - officialName
  ///   - plaidAccessTokenId
  ///   - profile
  ///   - profileHoldings
  ///   - profileId
  ///   - refId
  ///   - subtype
  ///   - type
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?> = nil, _not: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> = nil, _or: Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?> = nil, balanceAvailable: Swift.Optional<float8_comparison_exp?> = nil, balanceCurrent: Swift.Optional<float8_comparison_exp?> = nil, balanceIsoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, balanceLimit: Swift.Optional<float8_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, mask: Swift.Optional<String_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, officialName: Swift.Optional<String_comparison_exp?> = nil, plaidAccessTokenId: Swift.Optional<Int_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, subtype: Swift.Optional<String_comparison_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "balance_available": balanceAvailable, "balance_current": balanceCurrent, "balance_iso_currency_code": balanceIsoCurrencyCode, "balance_limit": balanceLimit, "created_at": createdAt, "id": id, "mask": mask, "name": name, "official_name": officialName, "plaid_access_token_id": plaidAccessTokenId, "profile": profile, "profile_holdings": profileHoldings, "profile_id": profileId, "ref_id": refId, "subtype": subtype, "type": type, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?> ?? Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_portfolio_accounts_bool_exp?> ?? Swift.Optional<app_profile_portfolio_accounts_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?> ?? Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var balanceAvailable: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["balance_available"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "balance_available")
    }
  }

  public var balanceCurrent: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["balance_current"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "balance_current")
    }
  }

  public var balanceIsoCurrencyCode: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["balance_iso_currency_code"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "balance_iso_currency_code")
    }
  }

  public var balanceLimit: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["balance_limit"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "balance_limit")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var mask: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["mask"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "mask")
    }
  }

  public var name: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var officialName: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["official_name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "official_name")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> {
    get {
      return graphQLMap["profile_holdings"] as? Swift.Optional<app_profile_holdings_bool_exp?> ?? Swift.Optional<app_profile_holdings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_holdings")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var refId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var subtype: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["subtype"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "subtype")
    }
  }

  public var type: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "portfolio_holding_details". All fields are combined with a logical 'AND'.
public struct portfolio_holding_details_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - accountId
  ///   - holding
  ///   - holdingId
  ///   - lttQuantityTotal
  ///   - marketCapitalization
  ///   - nextEarningsDate
  ///   - purchaseDate
  ///   - relativeGain_1d
  ///   - relativeGainTotal
  ///   - securityType
  ///   - ticker
  ///   - tickerName
  ///   - tickerSymbol
  ///   - valueToPortfolioValue
  public init(_and: Swift.Optional<[portfolio_holding_details_bool_exp]?> = nil, _not: Swift.Optional<portfolio_holding_details_bool_exp?> = nil, _or: Swift.Optional<[portfolio_holding_details_bool_exp]?> = nil, accountId: Swift.Optional<Int_comparison_exp?> = nil, holding: Swift.Optional<app_profile_holdings_bool_exp?> = nil, holdingId: Swift.Optional<Int_comparison_exp?> = nil, lttQuantityTotal: Swift.Optional<float8_comparison_exp?> = nil, marketCapitalization: Swift.Optional<bigint_comparison_exp?> = nil, nextEarningsDate: Swift.Optional<timestamp_comparison_exp?> = nil, purchaseDate: Swift.Optional<timestamp_comparison_exp?> = nil, relativeGain_1d: Swift.Optional<float8_comparison_exp?> = nil, relativeGainTotal: Swift.Optional<float8_comparison_exp?> = nil, securityType: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil, tickerName: Swift.Optional<String_comparison_exp?> = nil, tickerSymbol: Swift.Optional<String_comparison_exp?> = nil, valueToPortfolioValue: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "account_id": accountId, "holding": holding, "holding_id": holdingId, "ltt_quantity_total": lttQuantityTotal, "market_capitalization": marketCapitalization, "next_earnings_date": nextEarningsDate, "purchase_date": purchaseDate, "relative_gain_1d": relativeGain_1d, "relative_gain_total": relativeGainTotal, "security_type": securityType, "ticker": ticker, "ticker_name": tickerName, "ticker_symbol": tickerSymbol, "value_to_portfolio_value": valueToPortfolioValue]
  }

  public var _and: Swift.Optional<[portfolio_holding_details_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[portfolio_holding_details_bool_exp]?> ?? Swift.Optional<[portfolio_holding_details_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<portfolio_holding_details_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<portfolio_holding_details_bool_exp?> ?? Swift.Optional<portfolio_holding_details_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[portfolio_holding_details_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[portfolio_holding_details_bool_exp]?> ?? Swift.Optional<[portfolio_holding_details_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var accountId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var holding: Swift.Optional<app_profile_holdings_bool_exp?> {
    get {
      return graphQLMap["holding"] as? Swift.Optional<app_profile_holdings_bool_exp?> ?? Swift.Optional<app_profile_holdings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding")
    }
  }

  public var holdingId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["holding_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding_id")
    }
  }

  public var lttQuantityTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["ltt_quantity_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ltt_quantity_total")
    }
  }

  public var marketCapitalization: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["market_capitalization"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capitalization")
    }
  }

  public var nextEarningsDate: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["next_earnings_date"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "next_earnings_date")
    }
  }

  public var purchaseDate: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["purchase_date"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "purchase_date")
    }
  }

  public var relativeGain_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGainTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var securityType: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["security_type"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_type")
    }
  }

  public var ticker: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }

  public var tickerName: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["ticker_name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_name")
    }
  }

  public var tickerSymbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["ticker_symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_symbol")
    }
  }

  public var valueToPortfolioValue: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["value_to_portfolio_value"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "value_to_portfolio_value")
    }
  }
}

/// Boolean expression to compare columns of type "bigint". All fields are combined with logical 'AND'.
public struct bigint_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _in
  ///   - _isNull
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nin
  public init(_eq: Swift.Optional<bigint?> = nil, _gt: Swift.Optional<bigint?> = nil, _gte: Swift.Optional<bigint?> = nil, _in: Swift.Optional<[bigint]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<bigint?> = nil, _lte: Swift.Optional<bigint?> = nil, _neq: Swift.Optional<bigint?> = nil, _nin: Swift.Optional<[bigint]?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  public var _eq: Swift.Optional<bigint?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<bigint?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<bigint?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  public var _in: Swift.Optional<[bigint]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[bigint]?> ?? Swift.Optional<[bigint]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_in")
    }
  }

  public var _isNull: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_is_null"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_is_null")
    }
  }

  public var _lt: Swift.Optional<bigint?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<bigint?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<bigint?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[bigint]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[bigint]?> ?? Swift.Optional<[bigint]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }
}

/// Boolean expression to compare columns of type "timestamp". All fields are combined with logical 'AND'.
public struct timestamp_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _in
  ///   - _isNull
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nin
  public init(_eq: Swift.Optional<timestamp?> = nil, _gt: Swift.Optional<timestamp?> = nil, _gte: Swift.Optional<timestamp?> = nil, _in: Swift.Optional<[timestamp]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<timestamp?> = nil, _lte: Swift.Optional<timestamp?> = nil, _neq: Swift.Optional<timestamp?> = nil, _nin: Swift.Optional<[timestamp]?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  public var _eq: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  public var _in: Swift.Optional<[timestamp]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[timestamp]?> ?? Swift.Optional<[timestamp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_in")
    }
  }

  public var _isNull: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_is_null"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_is_null")
    }
  }

  public var _lt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[timestamp]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[timestamp]?> ?? Swift.Optional<[timestamp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }
}

/// Boolean expression to filter rows from the table "tickers". All fields are combined with a logical 'AND'.
public struct tickers_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - countryName
  ///   - description
  ///   - gicGroup
  ///   - gicIndustry
  ///   - gicSector
  ///   - gicSubIndustry
  ///   - historicalGrowthRates
  ///   - industry
  ///   - ipoDate
  ///   - logoUrl
  ///   - name
  ///   - phone
  ///   - realtimeMetrics
  ///   - sector
  ///   - symbol
  ///   - tickerAnalystRatings
  ///   - tickerCategories
  ///   - tickerCollections
  ///   - tickerEvents
  ///   - tickerFinancials
  ///   - tickerGrowthRate_1m
  ///   - tickerGrowthRate_1w
  ///   - tickerHighlights
  ///   - tickerIndustries
  ///   - tickerInterests
  ///   - tickerMetrics
  ///   - type
  ///   - updatedAt
  ///   - webUrl
  public init(_and: Swift.Optional<[tickers_bool_exp]?> = nil, _not: Swift.Optional<tickers_bool_exp?> = nil, _or: Swift.Optional<[tickers_bool_exp]?> = nil, countryName: Swift.Optional<String_comparison_exp?> = nil, description: Swift.Optional<String_comparison_exp?> = nil, gicGroup: Swift.Optional<String_comparison_exp?> = nil, gicIndustry: Swift.Optional<String_comparison_exp?> = nil, gicSector: Swift.Optional<String_comparison_exp?> = nil, gicSubIndustry: Swift.Optional<String_comparison_exp?> = nil, historicalGrowthRates: Swift.Optional<historical_growth_rate_bool_exp?> = nil, industry: Swift.Optional<String_comparison_exp?> = nil, ipoDate: Swift.Optional<date_comparison_exp?> = nil, logoUrl: Swift.Optional<String_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, phone: Swift.Optional<String_comparison_exp?> = nil, realtimeMetrics: Swift.Optional<ticker_realtime_metrics_bool_exp?> = nil, sector: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, tickerAnalystRatings: Swift.Optional<analyst_ratings_bool_exp?> = nil, tickerCategories: Swift.Optional<ticker_categories_bool_exp?> = nil, tickerCollections: Swift.Optional<ticker_collections_bool_exp?> = nil, tickerEvents: Swift.Optional<ticker_events_bool_exp?> = nil, tickerFinancials: Swift.Optional<ticker_financials_bool_exp?> = nil, tickerGrowthRate_1m: Swift.Optional<growth_rate_1m_bool_exp?> = nil, tickerGrowthRate_1w: Swift.Optional<growth_rate_1w_bool_exp?> = nil, tickerHighlights: Swift.Optional<ticker_highlights_bool_exp?> = nil, tickerIndustries: Swift.Optional<ticker_industries_bool_exp?> = nil, tickerInterests: Swift.Optional<ticker_interests_bool_exp?> = nil, tickerMetrics: Swift.Optional<ticker_metrics_bool_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil, webUrl: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "country_name": countryName, "description": description, "gic_group": gicGroup, "gic_industry": gicIndustry, "gic_sector": gicSector, "gic_sub_industry": gicSubIndustry, "historical_growth_rates": historicalGrowthRates, "industry": industry, "ipo_date": ipoDate, "logo_url": logoUrl, "name": name, "phone": phone, "realtime_metrics": realtimeMetrics, "sector": sector, "symbol": symbol, "ticker_analyst_ratings": tickerAnalystRatings, "ticker_categories": tickerCategories, "ticker_collections": tickerCollections, "ticker_events": tickerEvents, "ticker_financials": tickerFinancials, "ticker_growth_rate_1m": tickerGrowthRate_1m, "ticker_growth_rate_1w": tickerGrowthRate_1w, "ticker_highlights": tickerHighlights, "ticker_industries": tickerIndustries, "ticker_interests": tickerInterests, "ticker_metrics": tickerMetrics, "type": type, "updated_at": updatedAt, "web_url": webUrl]
  }

  public var _and: Swift.Optional<[tickers_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[tickers_bool_exp]?> ?? Swift.Optional<[tickers_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[tickers_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[tickers_bool_exp]?> ?? Swift.Optional<[tickers_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var countryName: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["country_name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country_name")
    }
  }

  public var description: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var gicGroup: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["gic_group"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_group")
    }
  }

  public var gicIndustry: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["gic_industry"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_industry")
    }
  }

  public var gicSector: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["gic_sector"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_sector")
    }
  }

  public var gicSubIndustry: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["gic_sub_industry"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_sub_industry")
    }
  }

  public var historicalGrowthRates: Swift.Optional<historical_growth_rate_bool_exp?> {
    get {
      return graphQLMap["historical_growth_rates"] as? Swift.Optional<historical_growth_rate_bool_exp?> ?? Swift.Optional<historical_growth_rate_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "historical_growth_rates")
    }
  }

  public var industry: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["industry"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry")
    }
  }

  public var ipoDate: Swift.Optional<date_comparison_exp?> {
    get {
      return graphQLMap["ipo_date"] as? Swift.Optional<date_comparison_exp?> ?? Swift.Optional<date_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ipo_date")
    }
  }

  public var logoUrl: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["logo_url"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "logo_url")
    }
  }

  public var name: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var phone: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["phone"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "phone")
    }
  }

  public var realtimeMetrics: Swift.Optional<ticker_realtime_metrics_bool_exp?> {
    get {
      return graphQLMap["realtime_metrics"] as? Swift.Optional<ticker_realtime_metrics_bool_exp?> ?? Swift.Optional<ticker_realtime_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "realtime_metrics")
    }
  }

  public var sector: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["sector"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sector")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var tickerAnalystRatings: Swift.Optional<analyst_ratings_bool_exp?> {
    get {
      return graphQLMap["ticker_analyst_ratings"] as? Swift.Optional<analyst_ratings_bool_exp?> ?? Swift.Optional<analyst_ratings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_analyst_ratings")
    }
  }

  public var tickerCategories: Swift.Optional<ticker_categories_bool_exp?> {
    get {
      return graphQLMap["ticker_categories"] as? Swift.Optional<ticker_categories_bool_exp?> ?? Swift.Optional<ticker_categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_categories")
    }
  }

  public var tickerCollections: Swift.Optional<ticker_collections_bool_exp?> {
    get {
      return graphQLMap["ticker_collections"] as? Swift.Optional<ticker_collections_bool_exp?> ?? Swift.Optional<ticker_collections_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_collections")
    }
  }

  public var tickerEvents: Swift.Optional<ticker_events_bool_exp?> {
    get {
      return graphQLMap["ticker_events"] as? Swift.Optional<ticker_events_bool_exp?> ?? Swift.Optional<ticker_events_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_events")
    }
  }

  public var tickerFinancials: Swift.Optional<ticker_financials_bool_exp?> {
    get {
      return graphQLMap["ticker_financials"] as? Swift.Optional<ticker_financials_bool_exp?> ?? Swift.Optional<ticker_financials_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_financials")
    }
  }

  public var tickerGrowthRate_1m: Swift.Optional<growth_rate_1m_bool_exp?> {
    get {
      return graphQLMap["ticker_growth_rate_1m"] as? Swift.Optional<growth_rate_1m_bool_exp?> ?? Swift.Optional<growth_rate_1m_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_growth_rate_1m")
    }
  }

  public var tickerGrowthRate_1w: Swift.Optional<growth_rate_1w_bool_exp?> {
    get {
      return graphQLMap["ticker_growth_rate_1w"] as? Swift.Optional<growth_rate_1w_bool_exp?> ?? Swift.Optional<growth_rate_1w_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_growth_rate_1w")
    }
  }

  public var tickerHighlights: Swift.Optional<ticker_highlights_bool_exp?> {
    get {
      return graphQLMap["ticker_highlights"] as? Swift.Optional<ticker_highlights_bool_exp?> ?? Swift.Optional<ticker_highlights_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_highlights")
    }
  }

  public var tickerIndustries: Swift.Optional<ticker_industries_bool_exp?> {
    get {
      return graphQLMap["ticker_industries"] as? Swift.Optional<ticker_industries_bool_exp?> ?? Swift.Optional<ticker_industries_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industries")
    }
  }

  public var tickerInterests: Swift.Optional<ticker_interests_bool_exp?> {
    get {
      return graphQLMap["ticker_interests"] as? Swift.Optional<ticker_interests_bool_exp?> ?? Swift.Optional<ticker_interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_interests")
    }
  }

  public var tickerMetrics: Swift.Optional<ticker_metrics_bool_exp?> {
    get {
      return graphQLMap["ticker_metrics"] as? Swift.Optional<ticker_metrics_bool_exp?> ?? Swift.Optional<ticker_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_metrics")
    }
  }

  public var type: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }

  public var webUrl: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["web_url"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "web_url")
    }
  }
}

/// Boolean expression to filter rows from the table "historical_growth_rate". All fields are combined with a logical 'AND'.
public struct historical_growth_rate_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - date
  ///   - growthRate_1d
  ///   - growthRate_1m
  ///   - growthRate_1w
  ///   - growthRate_1y
  ///   - growthRate_3m
  ///   - id
  ///   - symbol
  public init(_and: Swift.Optional<[historical_growth_rate_bool_exp]?> = nil, _not: Swift.Optional<historical_growth_rate_bool_exp?> = nil, _or: Swift.Optional<[historical_growth_rate_bool_exp]?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, growthRate_1d: Swift.Optional<float8_comparison_exp?> = nil, growthRate_1m: Swift.Optional<float8_comparison_exp?> = nil, growthRate_1w: Swift.Optional<float8_comparison_exp?> = nil, growthRate_1y: Swift.Optional<float8_comparison_exp?> = nil, growthRate_3m: Swift.Optional<float8_comparison_exp?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "growth_rate_1d": growthRate_1d, "growth_rate_1m": growthRate_1m, "growth_rate_1w": growthRate_1w, "growth_rate_1y": growthRate_1y, "growth_rate_3m": growthRate_3m, "id": id, "symbol": symbol]
  }

  public var _and: Swift.Optional<[historical_growth_rate_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[historical_growth_rate_bool_exp]?> ?? Swift.Optional<[historical_growth_rate_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<historical_growth_rate_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<historical_growth_rate_bool_exp?> ?? Swift.Optional<historical_growth_rate_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[historical_growth_rate_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[historical_growth_rate_bool_exp]?> ?? Swift.Optional<[historical_growth_rate_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var date: Swift.Optional<date_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<date_comparison_exp?> ?? Swift.Optional<date_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var growthRate_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["growth_rate_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_1d")
    }
  }

  public var growthRate_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["growth_rate_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_1m")
    }
  }

  public var growthRate_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["growth_rate_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_1w")
    }
  }

  public var growthRate_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["growth_rate_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_1y")
    }
  }

  public var growthRate_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["growth_rate_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_3m")
    }
  }

  public var id: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// Boolean expression to compare columns of type "date". All fields are combined with logical 'AND'.
public struct date_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _in
  ///   - _isNull
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nin
  public init(_eq: Swift.Optional<date?> = nil, _gt: Swift.Optional<date?> = nil, _gte: Swift.Optional<date?> = nil, _in: Swift.Optional<[date]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<date?> = nil, _lte: Swift.Optional<date?> = nil, _neq: Swift.Optional<date?> = nil, _nin: Swift.Optional<[date]?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  public var _eq: Swift.Optional<date?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<date?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<date?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  public var _in: Swift.Optional<[date]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[date]?> ?? Swift.Optional<[date]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_in")
    }
  }

  public var _isNull: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_is_null"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_is_null")
    }
  }

  public var _lt: Swift.Optional<date?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<date?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<date?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[date]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[date]?> ?? Swift.Optional<[date]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }
}

/// Boolean expression to filter rows from the table "ticker_realtime_metrics". All fields are combined with a logical 'AND'.
public struct ticker_realtime_metrics_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - absoluteDailyChange
  ///   - actualPrice
  ///   - dailyVolume
  ///   - relativeDailyChange
  ///   - symbol
  ///   - time
  public init(_and: Swift.Optional<[ticker_realtime_metrics_bool_exp]?> = nil, _not: Swift.Optional<ticker_realtime_metrics_bool_exp?> = nil, _or: Swift.Optional<[ticker_realtime_metrics_bool_exp]?> = nil, absoluteDailyChange: Swift.Optional<float8_comparison_exp?> = nil, actualPrice: Swift.Optional<float8_comparison_exp?> = nil, dailyVolume: Swift.Optional<float8_comparison_exp?> = nil, relativeDailyChange: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, time: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "daily_volume": dailyVolume, "relative_daily_change": relativeDailyChange, "symbol": symbol, "time": time]
  }

  public var _and: Swift.Optional<[ticker_realtime_metrics_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_realtime_metrics_bool_exp]?> ?? Swift.Optional<[ticker_realtime_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_realtime_metrics_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_realtime_metrics_bool_exp?> ?? Swift.Optional<ticker_realtime_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_realtime_metrics_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_realtime_metrics_bool_exp]?> ?? Swift.Optional<[ticker_realtime_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var absoluteDailyChange: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_daily_change"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_daily_change")
    }
  }

  public var actualPrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["actual_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "actual_price")
    }
  }

  public var dailyVolume: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["daily_volume"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "daily_volume")
    }
  }

  public var relativeDailyChange: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_daily_change"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_daily_change")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var time: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["time"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "time")
    }
  }
}

/// Boolean expression to filter rows from the table "analyst_ratings". All fields are combined with a logical 'AND'.
public struct analyst_ratings_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - buy
  ///   - hold
  ///   - rating
  ///   - sell
  ///   - strongBuy
  ///   - strongSell
  ///   - symbol
  ///   - targetPrice
  public init(_and: Swift.Optional<[analyst_ratings_bool_exp]?> = nil, _not: Swift.Optional<analyst_ratings_bool_exp?> = nil, _or: Swift.Optional<[analyst_ratings_bool_exp]?> = nil, buy: Swift.Optional<Int_comparison_exp?> = nil, hold: Swift.Optional<Int_comparison_exp?> = nil, rating: Swift.Optional<float8_comparison_exp?> = nil, sell: Swift.Optional<Int_comparison_exp?> = nil, strongBuy: Swift.Optional<Int_comparison_exp?> = nil, strongSell: Swift.Optional<Int_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, targetPrice: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "buy": buy, "hold": hold, "rating": rating, "sell": sell, "strong_buy": strongBuy, "strong_sell": strongSell, "symbol": symbol, "target_price": targetPrice]
  }

  public var _and: Swift.Optional<[analyst_ratings_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[analyst_ratings_bool_exp]?> ?? Swift.Optional<[analyst_ratings_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<analyst_ratings_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<analyst_ratings_bool_exp?> ?? Swift.Optional<analyst_ratings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[analyst_ratings_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[analyst_ratings_bool_exp]?> ?? Swift.Optional<[analyst_ratings_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var buy: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["buy"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "buy")
    }
  }

  public var hold: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["hold"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hold")
    }
  }

  public var rating: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["rating"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "rating")
    }
  }

  public var sell: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["sell"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sell")
    }
  }

  public var strongBuy: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["strong_buy"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "strong_buy")
    }
  }

  public var strongSell: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["strong_sell"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "strong_sell")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var targetPrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["target_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "target_price")
    }
  }
}

/// Boolean expression to filter rows from the table "ticker_categories". All fields are combined with a logical 'AND'.
public struct ticker_categories_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - categories
  ///   - categoryId
  ///   - symbol
  public init(_and: Swift.Optional<[ticker_categories_bool_exp]?> = nil, _not: Swift.Optional<ticker_categories_bool_exp?> = nil, _or: Swift.Optional<[ticker_categories_bool_exp]?> = nil, categories: Swift.Optional<categories_bool_exp?> = nil, categoryId: Swift.Optional<Int_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "categories": categories, "category_id": categoryId, "symbol": symbol]
  }

  public var _and: Swift.Optional<[ticker_categories_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_categories_bool_exp]?> ?? Swift.Optional<[ticker_categories_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_categories_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_categories_bool_exp?> ?? Swift.Optional<ticker_categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_categories_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_categories_bool_exp]?> ?? Swift.Optional<[ticker_categories_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var categories: Swift.Optional<categories_bool_exp?> {
    get {
      return graphQLMap["categories"] as? Swift.Optional<categories_bool_exp?> ?? Swift.Optional<categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "categories")
    }
  }

  public var categoryId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// Boolean expression to filter rows from the table "categories". All fields are combined with a logical 'AND'.
public struct categories_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - iconUrl
  ///   - id
  ///   - name
  ///   - riskScore
  public init(_and: Swift.Optional<[categories_bool_exp]?> = nil, _not: Swift.Optional<categories_bool_exp?> = nil, _or: Swift.Optional<[categories_bool_exp]?> = nil, iconUrl: Swift.Optional<String_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, riskScore: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "icon_url": iconUrl, "id": id, "name": name, "risk_score": riskScore]
  }

  public var _and: Swift.Optional<[categories_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[categories_bool_exp]?> ?? Swift.Optional<[categories_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<categories_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<categories_bool_exp?> ?? Swift.Optional<categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[categories_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[categories_bool_exp]?> ?? Swift.Optional<[categories_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var iconUrl: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["icon_url"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "icon_url")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var riskScore: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["risk_score"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_score")
    }
  }
}

/// Boolean expression to filter rows from the table "profile_ticker_collections". All fields are combined with a logical 'AND'.
public struct ticker_collections_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - collectionId
  ///   - profile
  ///   - profileId
  ///   - symbol
  ///   - ticker
  public init(_and: Swift.Optional<[ticker_collections_bool_exp]?> = nil, _not: Swift.Optional<ticker_collections_bool_exp?> = nil, _or: Swift.Optional<[ticker_collections_bool_exp]?> = nil, collectionId: Swift.Optional<Int_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "collection_id": collectionId, "profile": profile, "profile_id": profileId, "symbol": symbol, "ticker": ticker]
  }

  public var _and: Swift.Optional<[ticker_collections_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_collections_bool_exp]?> ?? Swift.Optional<[ticker_collections_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_collections_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_collections_bool_exp?> ?? Swift.Optional<ticker_collections_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_collections_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_collections_bool_exp]?> ?? Swift.Optional<[ticker_collections_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var collectionId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// Boolean expression to filter rows from the table "ticker_events". All fields are combined with a logical 'AND'.
public struct ticker_events_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - createdAt
  ///   - date
  ///   - description
  ///   - symbol
  ///   - timestamp
  ///   - type
  public init(_and: Swift.Optional<[ticker_events_bool_exp]?> = nil, _not: Swift.Optional<ticker_events_bool_exp?> = nil, _or: Swift.Optional<[ticker_events_bool_exp]?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, description: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, timestamp: Swift.Optional<timestamptz_comparison_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "created_at": createdAt, "date": date, "description": description, "symbol": symbol, "timestamp": timestamp, "type": type]
  }

  public var _and: Swift.Optional<[ticker_events_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_events_bool_exp]?> ?? Swift.Optional<[ticker_events_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_events_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_events_bool_exp?> ?? Swift.Optional<ticker_events_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_events_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_events_bool_exp]?> ?? Swift.Optional<[ticker_events_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var date: Swift.Optional<date_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<date_comparison_exp?> ?? Swift.Optional<date_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var description: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var timestamp: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["timestamp"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "timestamp")
    }
  }

  public var type: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }
}

/// Boolean expression to filter rows from the table "ticker_financials". All fields are combined with a logical 'AND'.
public struct ticker_financials_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - createdAt
  ///   - dividendGrowth
  ///   - enterpriseValueToSales
  ///   - highlight
  ///   - marketCapitalization
  ///   - monthPricePerformance
  ///   - netProfitMargin
  ///   - peRatio
  ///   - quarterAgoClose
  ///   - quarterPricePerformance
  ///   - quarterlyRevenueGrowthYoy
  ///   - revenueTtm
  ///   - symbol
  public init(_and: Swift.Optional<[ticker_financials_bool_exp]?> = nil, _not: Swift.Optional<ticker_financials_bool_exp?> = nil, _or: Swift.Optional<[ticker_financials_bool_exp]?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, dividendGrowth: Swift.Optional<float8_comparison_exp?> = nil, enterpriseValueToSales: Swift.Optional<Float_comparison_exp?> = nil, highlight: Swift.Optional<String_comparison_exp?> = nil, marketCapitalization: Swift.Optional<Float_comparison_exp?> = nil, monthPricePerformance: Swift.Optional<Float_comparison_exp?> = nil, netProfitMargin: Swift.Optional<Float_comparison_exp?> = nil, peRatio: Swift.Optional<Float_comparison_exp?> = nil, quarterAgoClose: Swift.Optional<Float_comparison_exp?> = nil, quarterPricePerformance: Swift.Optional<Float_comparison_exp?> = nil, quarterlyRevenueGrowthYoy: Swift.Optional<Float_comparison_exp?> = nil, revenueTtm: Swift.Optional<Float_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "created_at": createdAt, "dividend_growth": dividendGrowth, "enterprise_value_to_sales": enterpriseValueToSales, "highlight": highlight, "market_capitalization": marketCapitalization, "month_price_performance": monthPricePerformance, "net_profit_margin": netProfitMargin, "pe_ratio": peRatio, "quarter_ago_close": quarterAgoClose, "quarter_price_performance": quarterPricePerformance, "quarterly_revenue_growth_yoy": quarterlyRevenueGrowthYoy, "revenue_ttm": revenueTtm, "symbol": symbol]
  }

  public var _and: Swift.Optional<[ticker_financials_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_financials_bool_exp]?> ?? Swift.Optional<[ticker_financials_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_financials_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_financials_bool_exp?> ?? Swift.Optional<ticker_financials_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_financials_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_financials_bool_exp]?> ?? Swift.Optional<[ticker_financials_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var dividendGrowth: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["dividend_growth"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_growth")
    }
  }

  public var enterpriseValueToSales: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["enterprise_value_to_sales"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enterprise_value_to_sales")
    }
  }

  public var highlight: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["highlight"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "highlight")
    }
  }

  public var marketCapitalization: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["market_capitalization"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capitalization")
    }
  }

  public var monthPricePerformance: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["month_price_performance"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "month_price_performance")
    }
  }

  public var netProfitMargin: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["net_profit_margin"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_profit_margin")
    }
  }

  public var peRatio: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["pe_ratio"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "pe_ratio")
    }
  }

  public var quarterAgoClose: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["quarter_ago_close"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quarter_ago_close")
    }
  }

  public var quarterPricePerformance: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["quarter_price_performance"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quarter_price_performance")
    }
  }

  public var quarterlyRevenueGrowthYoy: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["quarterly_revenue_growth_yoy"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quarterly_revenue_growth_yoy")
    }
  }

  public var revenueTtm: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["revenue_ttm"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_ttm")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// Boolean expression to compare columns of type "Float". All fields are combined with logical 'AND'.
public struct Float_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _in
  ///   - _isNull
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nin
  public init(_eq: Swift.Optional<Double?> = nil, _gt: Swift.Optional<Double?> = nil, _gte: Swift.Optional<Double?> = nil, _in: Swift.Optional<[Double]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<Double?> = nil, _lte: Swift.Optional<Double?> = nil, _neq: Swift.Optional<Double?> = nil, _nin: Swift.Optional<[Double]?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  public var _eq: Swift.Optional<Double?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<Double?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<Double?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  public var _in: Swift.Optional<[Double]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[Double]?> ?? Swift.Optional<[Double]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_in")
    }
  }

  public var _isNull: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_is_null"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_is_null")
    }
  }

  public var _lt: Swift.Optional<Double?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<Double?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<Double?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[Double]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[Double]?> ?? Swift.Optional<[Double]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }
}

/// Boolean expression to filter rows from the table "growth_rate_1m". All fields are combined with a logical 'AND'.
public struct growth_rate_1m_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - date
  ///   - growthRate
  ///   - symbol
  public init(_and: Swift.Optional<[growth_rate_1m_bool_exp]?> = nil, _not: Swift.Optional<growth_rate_1m_bool_exp?> = nil, _or: Swift.Optional<[growth_rate_1m_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, growthRate: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "growth_rate": growthRate, "symbol": symbol]
  }

  public var _and: Swift.Optional<[growth_rate_1m_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[growth_rate_1m_bool_exp]?> ?? Swift.Optional<[growth_rate_1m_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<growth_rate_1m_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<growth_rate_1m_bool_exp?> ?? Swift.Optional<growth_rate_1m_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[growth_rate_1m_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[growth_rate_1m_bool_exp]?> ?? Swift.Optional<[growth_rate_1m_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var date: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var growthRate: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["growth_rate"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// Boolean expression to filter rows from the table "growth_rate_1w". All fields are combined with a logical 'AND'.
public struct growth_rate_1w_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - date
  ///   - growthRate
  ///   - symbol
  public init(_and: Swift.Optional<[growth_rate_1w_bool_exp]?> = nil, _not: Swift.Optional<growth_rate_1w_bool_exp?> = nil, _or: Swift.Optional<[growth_rate_1w_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, growthRate: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "growth_rate": growthRate, "symbol": symbol]
  }

  public var _and: Swift.Optional<[growth_rate_1w_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[growth_rate_1w_bool_exp]?> ?? Swift.Optional<[growth_rate_1w_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<growth_rate_1w_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<growth_rate_1w_bool_exp?> ?? Swift.Optional<growth_rate_1w_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[growth_rate_1w_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[growth_rate_1w_bool_exp]?> ?? Swift.Optional<[growth_rate_1w_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var date: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var growthRate: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["growth_rate"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// Boolean expression to filter rows from the table "ticker_highlights". All fields are combined with a logical 'AND'.
public struct ticker_highlights_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - createdAt
  ///   - highlight
  ///   - symbol
  ///   - ticker
  public init(_and: Swift.Optional<[ticker_highlights_bool_exp]?> = nil, _not: Swift.Optional<ticker_highlights_bool_exp?> = nil, _or: Swift.Optional<[ticker_highlights_bool_exp]?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, highlight: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "created_at": createdAt, "highlight": highlight, "symbol": symbol, "ticker": ticker]
  }

  public var _and: Swift.Optional<[ticker_highlights_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_highlights_bool_exp]?> ?? Swift.Optional<[ticker_highlights_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_highlights_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_highlights_bool_exp?> ?? Swift.Optional<ticker_highlights_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_highlights_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_highlights_bool_exp]?> ?? Swift.Optional<[ticker_highlights_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var highlight: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["highlight"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "highlight")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// Boolean expression to filter rows from the table "ticker_industries". All fields are combined with a logical 'AND'.
public struct ticker_industries_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - gainyIndustry
  ///   - industryId
  ///   - symbol
  ///   - ticker
  public init(_and: Swift.Optional<[ticker_industries_bool_exp]?> = nil, _not: Swift.Optional<ticker_industries_bool_exp?> = nil, _or: Swift.Optional<[ticker_industries_bool_exp]?> = nil, gainyIndustry: Swift.Optional<gainy_industries_bool_exp?> = nil, industryId: Swift.Optional<Int_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "gainy_industry": gainyIndustry, "industry_id": industryId, "symbol": symbol, "ticker": ticker]
  }

  public var _and: Swift.Optional<[ticker_industries_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_industries_bool_exp]?> ?? Swift.Optional<[ticker_industries_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_industries_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_industries_bool_exp?> ?? Swift.Optional<ticker_industries_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_industries_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_industries_bool_exp]?> ?? Swift.Optional<[ticker_industries_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var gainyIndustry: Swift.Optional<gainy_industries_bool_exp?> {
    get {
      return graphQLMap["gainy_industry"] as? Swift.Optional<gainy_industries_bool_exp?> ?? Swift.Optional<gainy_industries_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gainy_industry")
    }
  }

  public var industryId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// Boolean expression to filter rows from the table "gainy_industries". All fields are combined with a logical 'AND'.
public struct gainy_industries_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - id
  ///   - industryStatsDailies
  ///   - industryStatsQuarterlies
  ///   - name
  ///   - tickerIndustries
  ///   - tickerIndustryMedian_1m
  ///   - tickerIndustryMedian_1w
  public init(_and: Swift.Optional<[gainy_industries_bool_exp]?> = nil, _not: Swift.Optional<gainy_industries_bool_exp?> = nil, _or: Swift.Optional<[gainy_industries_bool_exp]?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, industryStatsDailies: Swift.Optional<industry_stats_daily_bool_exp?> = nil, industryStatsQuarterlies: Swift.Optional<industry_stats_quarterly_bool_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, tickerIndustries: Swift.Optional<ticker_industries_bool_exp?> = nil, tickerIndustryMedian_1m: Swift.Optional<industry_median_1m_bool_exp?> = nil, tickerIndustryMedian_1w: Swift.Optional<industry_median_1w_bool_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "id": id, "industry_stats_dailies": industryStatsDailies, "industry_stats_quarterlies": industryStatsQuarterlies, "name": name, "ticker_industries": tickerIndustries, "ticker_industry_median_1m": tickerIndustryMedian_1m, "ticker_industry_median_1w": tickerIndustryMedian_1w]
  }

  public var _and: Swift.Optional<[gainy_industries_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[gainy_industries_bool_exp]?> ?? Swift.Optional<[gainy_industries_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<gainy_industries_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<gainy_industries_bool_exp?> ?? Swift.Optional<gainy_industries_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[gainy_industries_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[gainy_industries_bool_exp]?> ?? Swift.Optional<[gainy_industries_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var industryStatsDailies: Swift.Optional<industry_stats_daily_bool_exp?> {
    get {
      return graphQLMap["industry_stats_dailies"] as? Swift.Optional<industry_stats_daily_bool_exp?> ?? Swift.Optional<industry_stats_daily_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_stats_dailies")
    }
  }

  public var industryStatsQuarterlies: Swift.Optional<industry_stats_quarterly_bool_exp?> {
    get {
      return graphQLMap["industry_stats_quarterlies"] as? Swift.Optional<industry_stats_quarterly_bool_exp?> ?? Swift.Optional<industry_stats_quarterly_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_stats_quarterlies")
    }
  }

  public var name: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var tickerIndustries: Swift.Optional<ticker_industries_bool_exp?> {
    get {
      return graphQLMap["ticker_industries"] as? Swift.Optional<ticker_industries_bool_exp?> ?? Swift.Optional<ticker_industries_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industries")
    }
  }

  public var tickerIndustryMedian_1m: Swift.Optional<industry_median_1m_bool_exp?> {
    get {
      return graphQLMap["ticker_industry_median_1m"] as? Swift.Optional<industry_median_1m_bool_exp?> ?? Swift.Optional<industry_median_1m_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industry_median_1m")
    }
  }

  public var tickerIndustryMedian_1w: Swift.Optional<industry_median_1w_bool_exp?> {
    get {
      return graphQLMap["ticker_industry_median_1w"] as? Swift.Optional<industry_median_1w_bool_exp?> ?? Swift.Optional<industry_median_1w_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industry_median_1w")
    }
  }
}

/// Boolean expression to filter rows from the table "industry_stats_daily". All fields are combined with a logical 'AND'.
public struct industry_stats_daily_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - date
  ///   - id
  ///   - industryId
  ///   - medianGrowthRate_1d
  ///   - medianGrowthRate_1m
  ///   - medianGrowthRate_1w
  ///   - medianGrowthRate_1y
  ///   - medianGrowthRate_3m
  ///   - medianPrice
  public init(_and: Swift.Optional<[industry_stats_daily_bool_exp]?> = nil, _not: Swift.Optional<industry_stats_daily_bool_exp?> = nil, _or: Swift.Optional<[industry_stats_daily_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, industryId: Swift.Optional<Int_comparison_exp?> = nil, medianGrowthRate_1d: Swift.Optional<float8_comparison_exp?> = nil, medianGrowthRate_1m: Swift.Optional<float8_comparison_exp?> = nil, medianGrowthRate_1w: Swift.Optional<float8_comparison_exp?> = nil, medianGrowthRate_1y: Swift.Optional<float8_comparison_exp?> = nil, medianGrowthRate_3m: Swift.Optional<float8_comparison_exp?> = nil, medianPrice: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "id": id, "industry_id": industryId, "median_growth_rate_1d": medianGrowthRate_1d, "median_growth_rate_1m": medianGrowthRate_1m, "median_growth_rate_1w": medianGrowthRate_1w, "median_growth_rate_1y": medianGrowthRate_1y, "median_growth_rate_3m": medianGrowthRate_3m, "median_price": medianPrice]
  }

  public var _and: Swift.Optional<[industry_stats_daily_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[industry_stats_daily_bool_exp]?> ?? Swift.Optional<[industry_stats_daily_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<industry_stats_daily_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<industry_stats_daily_bool_exp?> ?? Swift.Optional<industry_stats_daily_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[industry_stats_daily_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[industry_stats_daily_bool_exp]?> ?? Swift.Optional<[industry_stats_daily_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var date: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var id: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var industryId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var medianGrowthRate_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_growth_rate_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_1d")
    }
  }

  public var medianGrowthRate_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_growth_rate_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_1m")
    }
  }

  public var medianGrowthRate_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_growth_rate_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_1w")
    }
  }

  public var medianGrowthRate_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_growth_rate_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_1y")
    }
  }

  public var medianGrowthRate_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_growth_rate_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_3m")
    }
  }

  public var medianPrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_price")
    }
  }
}

/// Boolean expression to filter rows from the table "industry_stats_quarterly". All fields are combined with a logical 'AND'.
public struct industry_stats_quarterly_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - date
  ///   - industryId
  ///   - medianNetIncome
  ///   - medianRevenue
  public init(_and: Swift.Optional<[industry_stats_quarterly_bool_exp]?> = nil, _not: Swift.Optional<industry_stats_quarterly_bool_exp?> = nil, _or: Swift.Optional<[industry_stats_quarterly_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, industryId: Swift.Optional<Int_comparison_exp?> = nil, medianNetIncome: Swift.Optional<float8_comparison_exp?> = nil, medianRevenue: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "industry_id": industryId, "median_net_income": medianNetIncome, "median_revenue": medianRevenue]
  }

  public var _and: Swift.Optional<[industry_stats_quarterly_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[industry_stats_quarterly_bool_exp]?> ?? Swift.Optional<[industry_stats_quarterly_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<industry_stats_quarterly_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<industry_stats_quarterly_bool_exp?> ?? Swift.Optional<industry_stats_quarterly_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[industry_stats_quarterly_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[industry_stats_quarterly_bool_exp]?> ?? Swift.Optional<[industry_stats_quarterly_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var date: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var industryId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var medianNetIncome: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_net_income"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_net_income")
    }
  }

  public var medianRevenue: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_revenue"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_revenue")
    }
  }
}

/// Boolean expression to filter rows from the table "industry_median_1m". All fields are combined with a logical 'AND'.
public struct industry_median_1m_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - date
  ///   - industryId
  ///   - medianGrowthRate
  ///   - medianPrice
  public init(_and: Swift.Optional<[industry_median_1m_bool_exp]?> = nil, _not: Swift.Optional<industry_median_1m_bool_exp?> = nil, _or: Swift.Optional<[industry_median_1m_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, industryId: Swift.Optional<Int_comparison_exp?> = nil, medianGrowthRate: Swift.Optional<float8_comparison_exp?> = nil, medianPrice: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "industry_id": industryId, "median_growth_rate": medianGrowthRate, "median_price": medianPrice]
  }

  public var _and: Swift.Optional<[industry_median_1m_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[industry_median_1m_bool_exp]?> ?? Swift.Optional<[industry_median_1m_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<industry_median_1m_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<industry_median_1m_bool_exp?> ?? Swift.Optional<industry_median_1m_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[industry_median_1m_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[industry_median_1m_bool_exp]?> ?? Swift.Optional<[industry_median_1m_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var date: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var industryId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var medianGrowthRate: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_growth_rate"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate")
    }
  }

  public var medianPrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_price")
    }
  }
}

/// Boolean expression to filter rows from the table "industry_median_1w". All fields are combined with a logical 'AND'.
public struct industry_median_1w_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - date
  ///   - industryId
  ///   - medianGrowthRate
  ///   - medianPrice
  public init(_and: Swift.Optional<[industry_median_1w_bool_exp]?> = nil, _not: Swift.Optional<industry_median_1w_bool_exp?> = nil, _or: Swift.Optional<[industry_median_1w_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, industryId: Swift.Optional<Int_comparison_exp?> = nil, medianGrowthRate: Swift.Optional<float8_comparison_exp?> = nil, medianPrice: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "industry_id": industryId, "median_growth_rate": medianGrowthRate, "median_price": medianPrice]
  }

  public var _and: Swift.Optional<[industry_median_1w_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[industry_median_1w_bool_exp]?> ?? Swift.Optional<[industry_median_1w_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<industry_median_1w_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<industry_median_1w_bool_exp?> ?? Swift.Optional<industry_median_1w_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[industry_median_1w_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[industry_median_1w_bool_exp]?> ?? Swift.Optional<[industry_median_1w_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var date: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var industryId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var medianGrowthRate: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_growth_rate"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate")
    }
  }

  public var medianPrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_price")
    }
  }
}

/// Boolean expression to filter rows from the table "ticker_interests". All fields are combined with a logical 'AND'.
public struct ticker_interests_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - interest
  ///   - interestId
  ///   - symbol
  ///   - ticker
  public init(_and: Swift.Optional<[ticker_interests_bool_exp]?> = nil, _not: Swift.Optional<ticker_interests_bool_exp?> = nil, _or: Swift.Optional<[ticker_interests_bool_exp]?> = nil, interest: Swift.Optional<interests_bool_exp?> = nil, interestId: Swift.Optional<Int_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "interest": interest, "interest_id": interestId, "symbol": symbol, "ticker": ticker]
  }

  public var _and: Swift.Optional<[ticker_interests_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_interests_bool_exp]?> ?? Swift.Optional<[ticker_interests_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_interests_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_interests_bool_exp?> ?? Swift.Optional<ticker_interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_interests_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_interests_bool_exp]?> ?? Swift.Optional<[ticker_interests_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var interest: Swift.Optional<interests_bool_exp?> {
    get {
      return graphQLMap["interest"] as? Swift.Optional<interests_bool_exp?> ?? Swift.Optional<interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest")
    }
  }

  public var interestId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// Boolean expression to filter rows from the table "interests". All fields are combined with a logical 'AND'.
public struct interests_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - enabled
  ///   - iconUrl
  ///   - id
  ///   - name
  ///   - tickerInterests
  public init(_and: Swift.Optional<[interests_bool_exp]?> = nil, _not: Swift.Optional<interests_bool_exp?> = nil, _or: Swift.Optional<[interests_bool_exp]?> = nil, enabled: Swift.Optional<String_comparison_exp?> = nil, iconUrl: Swift.Optional<String_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, tickerInterests: Swift.Optional<ticker_interests_bool_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "enabled": enabled, "icon_url": iconUrl, "id": id, "name": name, "ticker_interests": tickerInterests]
  }

  public var _and: Swift.Optional<[interests_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[interests_bool_exp]?> ?? Swift.Optional<[interests_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<interests_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<interests_bool_exp?> ?? Swift.Optional<interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[interests_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[interests_bool_exp]?> ?? Swift.Optional<[interests_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var enabled: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["enabled"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enabled")
    }
  }

  public var iconUrl: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["icon_url"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "icon_url")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var tickerInterests: Swift.Optional<ticker_interests_bool_exp?> {
    get {
      return graphQLMap["ticker_interests"] as? Swift.Optional<ticker_interests_bool_exp?> ?? Swift.Optional<ticker_interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_interests")
    }
  }
}

/// Boolean expression to filter rows from the table "ticker_metrics". All fields are combined with a logical 'AND'.
public struct ticker_metrics_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - absoluteHistoricalVolatilityAdjustedCurrent
  ///   - absoluteHistoricalVolatilityAdjustedMax_1y
  ///   - absoluteHistoricalVolatilityAdjustedMin_1y
  ///   - addressCity
  ///   - addressCounty
  ///   - addressFull
  ///   - addressState
  ///   - assetCashAndEquivalents
  ///   - avgVolume_10d
  ///   - avgVolume_90d
  ///   - beatenQuarterlyEpsEstimationCountTtm
  ///   - beta
  ///   - dividendFrequency
  ///   - dividendPayoutRatio
  ///   - dividendYield
  ///   - dividendsPerShare
  ///   - ebitda
  ///   - ebitdaGrowthYoy
  ///   - ebitdaTtm
  ///   - enterpriseValueToEbitda
  ///   - enterpriseValueToSales
  ///   - epsActual
  ///   - epsDifference
  ///   - epsEstimate
  ///   - epsGrowthFwd
  ///   - epsGrowthYoy
  ///   - epsSurprise
  ///   - exchangeName
  ///   - impliedVolatility
  ///   - marketCapitalization
  ///   - netDebt
  ///   - netIncome
  ///   - netIncomeTtm
  ///   - priceChange_1m
  ///   - priceChange_1y
  ///   - priceChange_3m
  ///   - priceToBookValue
  ///   - priceToEarningsTtm
  ///   - priceToSalesTtm
  ///   - profitMargin
  ///   - relativeHistoricalVolatilityAdjustedCurrent
  ///   - relativeHistoricalVolatilityAdjustedMax_1y
  ///   - relativeHistoricalVolatilityAdjustedMin_1y
  ///   - revenueActual
  ///   - revenueEstimateAvg_0y
  ///   - revenueGrowthFwd
  ///   - revenueGrowthYoy
  ///   - revenuePerShareTtm
  ///   - revenueTtm
  ///   - roa
  ///   - roi
  ///   - sharesFloat
  ///   - sharesOutstanding
  ///   - shortPercentOutstanding
  ///   - shortRatio
  ///   - symbol
  ///   - ticker
  ///   - totalAssets
  ///   - yearsOfConsecutiveDividendGrowth
  public init(_and: Swift.Optional<[ticker_metrics_bool_exp]?> = nil, _not: Swift.Optional<ticker_metrics_bool_exp?> = nil, _or: Swift.Optional<[ticker_metrics_bool_exp]?> = nil, absoluteHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8_comparison_exp?> = nil, absoluteHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8_comparison_exp?> = nil, absoluteHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8_comparison_exp?> = nil, addressCity: Swift.Optional<String_comparison_exp?> = nil, addressCounty: Swift.Optional<String_comparison_exp?> = nil, addressFull: Swift.Optional<String_comparison_exp?> = nil, addressState: Swift.Optional<String_comparison_exp?> = nil, assetCashAndEquivalents: Swift.Optional<float8_comparison_exp?> = nil, avgVolume_10d: Swift.Optional<float8_comparison_exp?> = nil, avgVolume_90d: Swift.Optional<float8_comparison_exp?> = nil, beatenQuarterlyEpsEstimationCountTtm: Swift.Optional<Int_comparison_exp?> = nil, beta: Swift.Optional<float8_comparison_exp?> = nil, dividendFrequency: Swift.Optional<String_comparison_exp?> = nil, dividendPayoutRatio: Swift.Optional<float8_comparison_exp?> = nil, dividendYield: Swift.Optional<float8_comparison_exp?> = nil, dividendsPerShare: Swift.Optional<float8_comparison_exp?> = nil, ebitda: Swift.Optional<float8_comparison_exp?> = nil, ebitdaGrowthYoy: Swift.Optional<float8_comparison_exp?> = nil, ebitdaTtm: Swift.Optional<float8_comparison_exp?> = nil, enterpriseValueToEbitda: Swift.Optional<float8_comparison_exp?> = nil, enterpriseValueToSales: Swift.Optional<float8_comparison_exp?> = nil, epsActual: Swift.Optional<float8_comparison_exp?> = nil, epsDifference: Swift.Optional<float8_comparison_exp?> = nil, epsEstimate: Swift.Optional<float8_comparison_exp?> = nil, epsGrowthFwd: Swift.Optional<float8_comparison_exp?> = nil, epsGrowthYoy: Swift.Optional<float8_comparison_exp?> = nil, epsSurprise: Swift.Optional<float8_comparison_exp?> = nil, exchangeName: Swift.Optional<String_comparison_exp?> = nil, impliedVolatility: Swift.Optional<float8_comparison_exp?> = nil, marketCapitalization: Swift.Optional<bigint_comparison_exp?> = nil, netDebt: Swift.Optional<float8_comparison_exp?> = nil, netIncome: Swift.Optional<float8_comparison_exp?> = nil, netIncomeTtm: Swift.Optional<float8_comparison_exp?> = nil, priceChange_1m: Swift.Optional<float8_comparison_exp?> = nil, priceChange_1y: Swift.Optional<float8_comparison_exp?> = nil, priceChange_3m: Swift.Optional<float8_comparison_exp?> = nil, priceToBookValue: Swift.Optional<float8_comparison_exp?> = nil, priceToEarningsTtm: Swift.Optional<float8_comparison_exp?> = nil, priceToSalesTtm: Swift.Optional<float8_comparison_exp?> = nil, profitMargin: Swift.Optional<float8_comparison_exp?> = nil, relativeHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8_comparison_exp?> = nil, relativeHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8_comparison_exp?> = nil, relativeHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8_comparison_exp?> = nil, revenueActual: Swift.Optional<float8_comparison_exp?> = nil, revenueEstimateAvg_0y: Swift.Optional<float8_comparison_exp?> = nil, revenueGrowthFwd: Swift.Optional<float8_comparison_exp?> = nil, revenueGrowthYoy: Swift.Optional<float8_comparison_exp?> = nil, revenuePerShareTtm: Swift.Optional<float8_comparison_exp?> = nil, revenueTtm: Swift.Optional<float8_comparison_exp?> = nil, roa: Swift.Optional<float8_comparison_exp?> = nil, roi: Swift.Optional<float8_comparison_exp?> = nil, sharesFloat: Swift.Optional<bigint_comparison_exp?> = nil, sharesOutstanding: Swift.Optional<bigint_comparison_exp?> = nil, shortPercentOutstanding: Swift.Optional<float8_comparison_exp?> = nil, shortRatio: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil, totalAssets: Swift.Optional<float8_comparison_exp?> = nil, yearsOfConsecutiveDividendGrowth: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "absolute_historical_volatility_adjusted_current": absoluteHistoricalVolatilityAdjustedCurrent, "absolute_historical_volatility_adjusted_max_1y": absoluteHistoricalVolatilityAdjustedMax_1y, "absolute_historical_volatility_adjusted_min_1y": absoluteHistoricalVolatilityAdjustedMin_1y, "address_city": addressCity, "address_county": addressCounty, "address_full": addressFull, "address_state": addressState, "asset_cash_and_equivalents": assetCashAndEquivalents, "avg_volume_10d": avgVolume_10d, "avg_volume_90d": avgVolume_90d, "beaten_quarterly_eps_estimation_count_ttm": beatenQuarterlyEpsEstimationCountTtm, "beta": beta, "dividend_frequency": dividendFrequency, "dividend_payout_ratio": dividendPayoutRatio, "dividend_yield": dividendYield, "dividends_per_share": dividendsPerShare, "ebitda": ebitda, "ebitda_growth_yoy": ebitdaGrowthYoy, "ebitda_ttm": ebitdaTtm, "enterprise_value_to_ebitda": enterpriseValueToEbitda, "enterprise_value_to_sales": enterpriseValueToSales, "eps_actual": epsActual, "eps_difference": epsDifference, "eps_estimate": epsEstimate, "eps_growth_fwd": epsGrowthFwd, "eps_growth_yoy": epsGrowthYoy, "eps_surprise": epsSurprise, "exchange_name": exchangeName, "implied_volatility": impliedVolatility, "market_capitalization": marketCapitalization, "net_debt": netDebt, "net_income": netIncome, "net_income_ttm": netIncomeTtm, "price_change_1m": priceChange_1m, "price_change_1y": priceChange_1y, "price_change_3m": priceChange_3m, "price_to_book_value": priceToBookValue, "price_to_earnings_ttm": priceToEarningsTtm, "price_to_sales_ttm": priceToSalesTtm, "profit_margin": profitMargin, "relative_historical_volatility_adjusted_current": relativeHistoricalVolatilityAdjustedCurrent, "relative_historical_volatility_adjusted_max_1y": relativeHistoricalVolatilityAdjustedMax_1y, "relative_historical_volatility_adjusted_min_1y": relativeHistoricalVolatilityAdjustedMin_1y, "revenue_actual": revenueActual, "revenue_estimate_avg_0y": revenueEstimateAvg_0y, "revenue_growth_fwd": revenueGrowthFwd, "revenue_growth_yoy": revenueGrowthYoy, "revenue_per_share_ttm": revenuePerShareTtm, "revenue_ttm": revenueTtm, "roa": roa, "roi": roi, "shares_float": sharesFloat, "shares_outstanding": sharesOutstanding, "short_percent_outstanding": shortPercentOutstanding, "short_ratio": shortRatio, "symbol": symbol, "ticker": ticker, "total_assets": totalAssets, "years_of_consecutive_dividend_growth": yearsOfConsecutiveDividendGrowth]
  }

  public var _and: Swift.Optional<[ticker_metrics_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[ticker_metrics_bool_exp]?> ?? Swift.Optional<[ticker_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<ticker_metrics_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<ticker_metrics_bool_exp?> ?? Swift.Optional<ticker_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[ticker_metrics_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[ticker_metrics_bool_exp]?> ?? Swift.Optional<[ticker_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var absoluteHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_current"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_current")
    }
  }

  public var absoluteHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_max_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_max_1y")
    }
  }

  public var absoluteHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_min_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_min_1y")
    }
  }

  public var addressCity: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["address_city"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_city")
    }
  }

  public var addressCounty: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["address_county"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_county")
    }
  }

  public var addressFull: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["address_full"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_full")
    }
  }

  public var addressState: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["address_state"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_state")
    }
  }

  public var assetCashAndEquivalents: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["asset_cash_and_equivalents"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "asset_cash_and_equivalents")
    }
  }

  public var avgVolume_10d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["avg_volume_10d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg_volume_10d")
    }
  }

  public var avgVolume_90d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["avg_volume_90d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg_volume_90d")
    }
  }

  public var beatenQuarterlyEpsEstimationCountTtm: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["beaten_quarterly_eps_estimation_count_ttm"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beaten_quarterly_eps_estimation_count_ttm")
    }
  }

  public var beta: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["beta"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beta")
    }
  }

  public var dividendFrequency: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["dividend_frequency"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_frequency")
    }
  }

  public var dividendPayoutRatio: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["dividend_payout_ratio"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_payout_ratio")
    }
  }

  public var dividendYield: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["dividend_yield"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_yield")
    }
  }

  public var dividendsPerShare: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["dividends_per_share"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividends_per_share")
    }
  }

  public var ebitda: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["ebitda"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda")
    }
  }

  public var ebitdaGrowthYoy: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["ebitda_growth_yoy"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda_growth_yoy")
    }
  }

  public var ebitdaTtm: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["ebitda_ttm"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda_ttm")
    }
  }

  public var enterpriseValueToEbitda: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["enterprise_value_to_ebitda"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enterprise_value_to_ebitda")
    }
  }

  public var enterpriseValueToSales: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["enterprise_value_to_sales"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enterprise_value_to_sales")
    }
  }

  public var epsActual: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["eps_actual"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_actual")
    }
  }

  public var epsDifference: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["eps_difference"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_difference")
    }
  }

  public var epsEstimate: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["eps_estimate"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_estimate")
    }
  }

  public var epsGrowthFwd: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["eps_growth_fwd"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_growth_fwd")
    }
  }

  public var epsGrowthYoy: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["eps_growth_yoy"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_growth_yoy")
    }
  }

  public var epsSurprise: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["eps_surprise"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_surprise")
    }
  }

  public var exchangeName: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["exchange_name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange_name")
    }
  }

  public var impliedVolatility: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["implied_volatility"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "implied_volatility")
    }
  }

  public var marketCapitalization: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["market_capitalization"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capitalization")
    }
  }

  public var netDebt: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["net_debt"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_debt")
    }
  }

  public var netIncome: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["net_income"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_income")
    }
  }

  public var netIncomeTtm: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["net_income_ttm"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_income_ttm")
    }
  }

  public var priceChange_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1m")
    }
  }

  public var priceChange_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1y")
    }
  }

  public var priceChange_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_3m")
    }
  }

  public var priceToBookValue: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_to_book_value"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_book_value")
    }
  }

  public var priceToEarningsTtm: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_to_earnings_ttm"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_earnings_ttm")
    }
  }

  public var priceToSalesTtm: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_to_sales_ttm"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_sales_ttm")
    }
  }

  public var profitMargin: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["profit_margin"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profit_margin")
    }
  }

  public var relativeHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_current"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_current")
    }
  }

  public var relativeHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_max_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_max_1y")
    }
  }

  public var relativeHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_min_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_min_1y")
    }
  }

  public var revenueActual: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["revenue_actual"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_actual")
    }
  }

  public var revenueEstimateAvg_0y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["revenue_estimate_avg_0y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_estimate_avg_0y")
    }
  }

  public var revenueGrowthFwd: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["revenue_growth_fwd"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_growth_fwd")
    }
  }

  public var revenueGrowthYoy: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["revenue_growth_yoy"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_growth_yoy")
    }
  }

  public var revenuePerShareTtm: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["revenue_per_share_ttm"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_per_share_ttm")
    }
  }

  public var revenueTtm: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["revenue_ttm"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_ttm")
    }
  }

  public var roa: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["roa"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "roa")
    }
  }

  public var roi: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["roi"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "roi")
    }
  }

  public var sharesFloat: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["shares_float"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "shares_float")
    }
  }

  public var sharesOutstanding: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["shares_outstanding"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "shares_outstanding")
    }
  }

  public var shortPercentOutstanding: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["short_percent_outstanding"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_percent_outstanding")
    }
  }

  public var shortRatio: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["short_ratio"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_ratio")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }

  public var totalAssets: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["total_assets"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "total_assets")
    }
  }

  public var yearsOfConsecutiveDividendGrowth: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["years_of_consecutive_dividend_growth"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "years_of_consecutive_dividend_growth")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_portfolio_transactions". All fields are combined with a logical 'AND'.
public struct app_profile_portfolio_transactions_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - account
  ///   - accountId
  ///   - amount
  ///   - createdAt
  ///   - date
  ///   - fees
  ///   - id
  ///   - isoCurrencyCode
  ///   - name
  ///   - plaidAccessTokenId
  ///   - portfolioTransactionGains
  ///   - price
  ///   - profile
  ///   - profileId
  ///   - quantity
  ///   - refId
  ///   - security
  ///   - securityId
  ///   - subtype
  ///   - type
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?> = nil, _not: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> = nil, _or: Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?> = nil, account: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> = nil, accountId: Swift.Optional<Int_comparison_exp?> = nil, amount: Swift.Optional<float8_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, fees: Swift.Optional<float8_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, isoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, plaidAccessTokenId: Swift.Optional<Int_comparison_exp?> = nil, portfolioTransactionGains: Swift.Optional<portfolio_transaction_gains_bool_exp?> = nil, price: Swift.Optional<float8_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, quantity: Swift.Optional<float8_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, security: Swift.Optional<app_portfolio_securities_bool_exp?> = nil, securityId: Swift.Optional<Int_comparison_exp?> = nil, subtype: Swift.Optional<String_comparison_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "account": account, "account_id": accountId, "amount": amount, "created_at": createdAt, "date": date, "fees": fees, "id": id, "iso_currency_code": isoCurrencyCode, "name": name, "plaid_access_token_id": plaidAccessTokenId, "portfolio_transaction_gains": portfolioTransactionGains, "price": price, "profile": profile, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "subtype": subtype, "type": type, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?> ?? Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_portfolio_transactions_bool_exp?> ?? Swift.Optional<app_profile_portfolio_transactions_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?> ?? Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var account: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> {
    get {
      return graphQLMap["account"] as? Swift.Optional<app_profile_portfolio_accounts_bool_exp?> ?? Swift.Optional<app_profile_portfolio_accounts_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account")
    }
  }

  public var accountId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var amount: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["amount"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "amount")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var date: Swift.Optional<date_comparison_exp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<date_comparison_exp?> ?? Swift.Optional<date_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var fees: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["fees"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fees")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var isoCurrencyCode: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["iso_currency_code"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "iso_currency_code")
    }
  }

  public var name: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var portfolioTransactionGains: Swift.Optional<portfolio_transaction_gains_bool_exp?> {
    get {
      return graphQLMap["portfolio_transaction_gains"] as? Swift.Optional<portfolio_transaction_gains_bool_exp?> ?? Swift.Optional<portfolio_transaction_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_transaction_gains")
    }
  }

  public var price: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var refId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var security: Swift.Optional<app_portfolio_securities_bool_exp?> {
    get {
      return graphQLMap["security"] as? Swift.Optional<app_portfolio_securities_bool_exp?> ?? Swift.Optional<app_portfolio_securities_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security")
    }
  }

  public var securityId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }

  public var subtype: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["subtype"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "subtype")
    }
  }

  public var type: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "portfolio_transaction_gains". All fields are combined with a logical 'AND'.
public struct portfolio_transaction_gains_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - absoluteGain_1d
  ///   - absoluteGain_1m
  ///   - absoluteGain_1w
  ///   - absoluteGain_1y
  ///   - absoluteGain_3m
  ///   - absoluteGain_5y
  ///   - absoluteGainTotal
  ///   - relativeGain_1d
  ///   - relativeGain_1m
  ///   - relativeGain_1w
  ///   - relativeGain_1y
  ///   - relativeGain_3m
  ///   - relativeGain_5y
  ///   - relativeGainTotal
  ///   - transaction
  ///   - transactionId
  ///   - updatedAt
  public init(_and: Swift.Optional<[portfolio_transaction_gains_bool_exp]?> = nil, _not: Swift.Optional<portfolio_transaction_gains_bool_exp?> = nil, _or: Swift.Optional<[portfolio_transaction_gains_bool_exp]?> = nil, absoluteGain_1d: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1m: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1w: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1y: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_3m: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_5y: Swift.Optional<float8_comparison_exp?> = nil, absoluteGainTotal: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1d: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1m: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1w: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1y: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_3m: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_5y: Swift.Optional<float8_comparison_exp?> = nil, relativeGainTotal: Swift.Optional<float8_comparison_exp?> = nil, transaction: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> = nil, transactionId: Swift.Optional<Int_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "transaction": transaction, "transaction_id": transactionId, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[portfolio_transaction_gains_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[portfolio_transaction_gains_bool_exp]?> ?? Swift.Optional<[portfolio_transaction_gains_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<portfolio_transaction_gains_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<portfolio_transaction_gains_bool_exp?> ?? Swift.Optional<portfolio_transaction_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[portfolio_transaction_gains_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[portfolio_transaction_gains_bool_exp]?> ?? Swift.Optional<[portfolio_transaction_gains_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var absoluteGain_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1d")
    }
  }

  public var absoluteGain_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1m")
    }
  }

  public var absoluteGain_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1w")
    }
  }

  public var absoluteGain_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1y")
    }
  }

  public var absoluteGain_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_3m")
    }
  }

  public var absoluteGain_5y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_5y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_5y")
    }
  }

  public var absoluteGainTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_total")
    }
  }

  public var relativeGain_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGain_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1m")
    }
  }

  public var relativeGain_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1w")
    }
  }

  public var relativeGain_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1y")
    }
  }

  public var relativeGain_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_3m")
    }
  }

  public var relativeGain_5y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_5y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_5y")
    }
  }

  public var relativeGainTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var transaction: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> {
    get {
      return graphQLMap["transaction"] as? Swift.Optional<app_profile_portfolio_transactions_bool_exp?> ?? Swift.Optional<app_profile_portfolio_transactions_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "transaction")
    }
  }

  public var transactionId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["transaction_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "transaction_id")
    }
  }

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "app.portfolio_securities". All fields are combined with a logical 'AND'.
public struct app_portfolio_securities_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - closePrice
  ///   - closePriceAsOf
  ///   - createdAt
  ///   - id
  ///   - isoCurrencyCode
  ///   - name
  ///   - profileHoldings
  ///   - refId
  ///   - tickerSymbol
  ///   - tickers
  ///   - type
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_portfolio_securities_bool_exp]?> = nil, _not: Swift.Optional<app_portfolio_securities_bool_exp?> = nil, _or: Swift.Optional<[app_portfolio_securities_bool_exp]?> = nil, closePrice: Swift.Optional<float8_comparison_exp?> = nil, closePriceAsOf: Swift.Optional<timestamp_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, isoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, tickerSymbol: Swift.Optional<String_comparison_exp?> = nil, tickers: Swift.Optional<tickers_bool_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "close_price": closePrice, "close_price_as_of": closePriceAsOf, "created_at": createdAt, "id": id, "iso_currency_code": isoCurrencyCode, "name": name, "profile_holdings": profileHoldings, "ref_id": refId, "ticker_symbol": tickerSymbol, "tickers": tickers, "type": type, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[app_portfolio_securities_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_portfolio_securities_bool_exp]?> ?? Swift.Optional<[app_portfolio_securities_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_portfolio_securities_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_portfolio_securities_bool_exp?> ?? Swift.Optional<app_portfolio_securities_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_portfolio_securities_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_portfolio_securities_bool_exp]?> ?? Swift.Optional<[app_portfolio_securities_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var closePrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["close_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close_price")
    }
  }

  public var closePriceAsOf: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["close_price_as_of"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close_price_as_of")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var isoCurrencyCode: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["iso_currency_code"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "iso_currency_code")
    }
  }

  public var name: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> {
    get {
      return graphQLMap["profile_holdings"] as? Swift.Optional<app_profile_holdings_bool_exp?> ?? Swift.Optional<app_profile_holdings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_holdings")
    }
  }

  public var refId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var tickerSymbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["ticker_symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_symbol")
    }
  }

  public var tickers: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["tickers"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "tickers")
    }
  }

  public var type: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "portfolio_holding_gains". All fields are combined with a logical 'AND'.
public struct portfolio_holding_gains_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - absoluteGain_1d
  ///   - absoluteGain_1m
  ///   - absoluteGain_1w
  ///   - absoluteGain_1y
  ///   - absoluteGain_3m
  ///   - absoluteGain_5y
  ///   - absoluteGainTotal
  ///   - actualValue
  ///   - holding
  ///   - holdingId
  ///   - lttQuantityTotal
  ///   - relativeGain_1d
  ///   - relativeGain_1m
  ///   - relativeGain_1w
  ///   - relativeGain_1y
  ///   - relativeGain_3m
  ///   - relativeGain_5y
  ///   - relativeGainTotal
  ///   - updatedAt
  ///   - valueToPortfolioValue
  public init(_and: Swift.Optional<[portfolio_holding_gains_bool_exp]?> = nil, _not: Swift.Optional<portfolio_holding_gains_bool_exp?> = nil, _or: Swift.Optional<[portfolio_holding_gains_bool_exp]?> = nil, absoluteGain_1d: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1m: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1w: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_1y: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_3m: Swift.Optional<float8_comparison_exp?> = nil, absoluteGain_5y: Swift.Optional<float8_comparison_exp?> = nil, absoluteGainTotal: Swift.Optional<float8_comparison_exp?> = nil, actualValue: Swift.Optional<float8_comparison_exp?> = nil, holding: Swift.Optional<app_profile_holdings_bool_exp?> = nil, holdingId: Swift.Optional<Int_comparison_exp?> = nil, lttQuantityTotal: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1d: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1m: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1w: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1y: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_3m: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_5y: Swift.Optional<float8_comparison_exp?> = nil, relativeGainTotal: Swift.Optional<float8_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil, valueToPortfolioValue: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "holding": holding, "holding_id": holdingId, "ltt_quantity_total": lttQuantityTotal, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "updated_at": updatedAt, "value_to_portfolio_value": valueToPortfolioValue]
  }

  public var _and: Swift.Optional<[portfolio_holding_gains_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[portfolio_holding_gains_bool_exp]?> ?? Swift.Optional<[portfolio_holding_gains_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<portfolio_holding_gains_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<portfolio_holding_gains_bool_exp?> ?? Swift.Optional<portfolio_holding_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[portfolio_holding_gains_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[portfolio_holding_gains_bool_exp]?> ?? Swift.Optional<[portfolio_holding_gains_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var absoluteGain_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1d")
    }
  }

  public var absoluteGain_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1m")
    }
  }

  public var absoluteGain_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1w")
    }
  }

  public var absoluteGain_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1y")
    }
  }

  public var absoluteGain_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_3m")
    }
  }

  public var absoluteGain_5y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_5y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_5y")
    }
  }

  public var absoluteGainTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["absolute_gain_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_total")
    }
  }

  public var actualValue: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["actual_value"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "actual_value")
    }
  }

  public var holding: Swift.Optional<app_profile_holdings_bool_exp?> {
    get {
      return graphQLMap["holding"] as? Swift.Optional<app_profile_holdings_bool_exp?> ?? Swift.Optional<app_profile_holdings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding")
    }
  }

  public var holdingId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["holding_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding_id")
    }
  }

  public var lttQuantityTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["ltt_quantity_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ltt_quantity_total")
    }
  }

  public var relativeGain_1d: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGain_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1m")
    }
  }

  public var relativeGain_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1w")
    }
  }

  public var relativeGain_1y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_1y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1y")
    }
  }

  public var relativeGain_3m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_3m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_3m")
    }
  }

  public var relativeGain_5y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_5y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_5y")
    }
  }

  public var relativeGainTotal: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }

  public var valueToPortfolioValue: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["value_to_portfolio_value"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "value_to_portfolio_value")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_interests". All fields are combined with a logical 'AND'.
public struct app_profile_interests_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - interestId
  ///   - profile
  ///   - profileId
  public init(_and: Swift.Optional<[app_profile_interests_bool_exp]?> = nil, _not: Swift.Optional<app_profile_interests_bool_exp?> = nil, _or: Swift.Optional<[app_profile_interests_bool_exp]?> = nil, interestId: Swift.Optional<Int_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "interest_id": interestId, "profile": profile, "profile_id": profileId]
  }

  public var _and: Swift.Optional<[app_profile_interests_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_interests_bool_exp]?> ?? Swift.Optional<[app_profile_interests_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_interests_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_interests_bool_exp?> ?? Swift.Optional<app_profile_interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_interests_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_interests_bool_exp]?> ?? Swift.Optional<[app_profile_interests_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var interestId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_plaid_access_tokens". All fields are combined with a logical 'AND'.
public struct app_profile_plaid_access_tokens_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - accessToken
  ///   - createdAt
  ///   - id
  ///   - itemId
  ///   - profile
  ///   - profileId
  public init(_and: Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?> = nil, _not: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> = nil, _or: Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?> = nil, accessToken: Swift.Optional<String_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, itemId: Swift.Optional<String_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "access_token": accessToken, "created_at": createdAt, "id": id, "item_id": itemId, "profile": profile, "profile_id": profileId]
  }

  public var _and: Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?> ?? Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> ?? Swift.Optional<app_profile_plaid_access_tokens_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?> ?? Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var accessToken: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["access_token"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "access_token")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var itemId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["item_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "item_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_scoring_settings". All fields are combined with a logical 'AND'.
public struct app_profile_scoring_settings_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - averageMarketReturn
  ///   - createdAt
  ///   - damageOfFailure
  ///   - ifMarketDrops_20IWillBuy
  ///   - ifMarketDrops_40IWillBuy
  ///   - investmentHorizon
  ///   - profile
  ///   - profileId
  ///   - riskLevel
  ///   - stockMarketRiskLevel
  ///   - tradingExperience
  ///   - unexpectedPurchasesSource
  public init(_and: Swift.Optional<[app_profile_scoring_settings_bool_exp]?> = nil, _not: Swift.Optional<app_profile_scoring_settings_bool_exp?> = nil, _or: Swift.Optional<[app_profile_scoring_settings_bool_exp]?> = nil, averageMarketReturn: Swift.Optional<Int_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, damageOfFailure: Swift.Optional<Float_comparison_exp?> = nil, ifMarketDrops_20IWillBuy: Swift.Optional<Float_comparison_exp?> = nil, ifMarketDrops_40IWillBuy: Swift.Optional<Float_comparison_exp?> = nil, investmentHorizon: Swift.Optional<Float_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, riskLevel: Swift.Optional<Float_comparison_exp?> = nil, stockMarketRiskLevel: Swift.Optional<String_comparison_exp?> = nil, tradingExperience: Swift.Optional<String_comparison_exp?> = nil, unexpectedPurchasesSource: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "average_market_return": averageMarketReturn, "created_at": createdAt, "damage_of_failure": damageOfFailure, "if_market_drops_20_i_will_buy": ifMarketDrops_20IWillBuy, "if_market_drops_40_i_will_buy": ifMarketDrops_40IWillBuy, "investment_horizon": investmentHorizon, "profile": profile, "profile_id": profileId, "risk_level": riskLevel, "stock_market_risk_level": stockMarketRiskLevel, "trading_experience": tradingExperience, "unexpected_purchases_source": unexpectedPurchasesSource]
  }

  public var _and: Swift.Optional<[app_profile_scoring_settings_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_scoring_settings_bool_exp]?> ?? Swift.Optional<[app_profile_scoring_settings_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_scoring_settings_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_scoring_settings_bool_exp?> ?? Swift.Optional<app_profile_scoring_settings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_scoring_settings_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_scoring_settings_bool_exp]?> ?? Swift.Optional<[app_profile_scoring_settings_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var averageMarketReturn: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["average_market_return"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "average_market_return")
    }
  }

  public var createdAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var damageOfFailure: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["damage_of_failure"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "damage_of_failure")
    }
  }

  public var ifMarketDrops_20IWillBuy: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["if_market_drops_20_i_will_buy"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "if_market_drops_20_i_will_buy")
    }
  }

  public var ifMarketDrops_40IWillBuy: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["if_market_drops_40_i_will_buy"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "if_market_drops_40_i_will_buy")
    }
  }

  public var investmentHorizon: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["investment_horizon"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "investment_horizon")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var riskLevel: Swift.Optional<Float_comparison_exp?> {
    get {
      return graphQLMap["risk_level"] as? Swift.Optional<Float_comparison_exp?> ?? Swift.Optional<Float_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_level")
    }
  }

  public var stockMarketRiskLevel: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["stock_market_risk_level"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stock_market_risk_level")
    }
  }

  public var tradingExperience: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["trading_experience"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "trading_experience")
    }
  }

  public var unexpectedPurchasesSource: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["unexpected_purchases_source"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "unexpected_purchases_source")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_watchlist_tickers". All fields are combined with a logical 'AND'.
public struct app_profile_watchlist_tickers_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - profile
  ///   - profileId
  ///   - symbol
  public init(_and: Swift.Optional<[app_profile_watchlist_tickers_bool_exp]?> = nil, _not: Swift.Optional<app_profile_watchlist_tickers_bool_exp?> = nil, _or: Swift.Optional<[app_profile_watchlist_tickers_bool_exp]?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "profile": profile, "profile_id": profileId, "symbol": symbol]
  }

  public var _and: Swift.Optional<[app_profile_watchlist_tickers_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_watchlist_tickers_bool_exp]?> ?? Swift.Optional<[app_profile_watchlist_tickers_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_watchlist_tickers_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_watchlist_tickers_bool_exp?> ?? Swift.Optional<app_profile_watchlist_tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_watchlist_tickers_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_watchlist_tickers_bool_exp]?> ?? Swift.Optional<[app_profile_watchlist_tickers_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var profile: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// input type for inserting array relation for remote table "app.profile_categories"
public struct app_profile_categories_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [app_profile_categories_insert_input], onConflict: Swift.Optional<app_profile_categories_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [app_profile_categories_insert_input] {
    get {
      return graphQLMap["data"] as! [app_profile_categories_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_categories_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_categories_on_conflict?> ?? Swift.Optional<app_profile_categories_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_categories"
public struct app_profile_categories_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profile
  ///   - profileId
  public init(categoryId: Swift.Optional<Int?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile": profile, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<Int?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// on conflict condition type for table "app.profile_categories"
public struct app_profile_categories_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_categories_constraint, updateColumns: [app_profile_categories_update_column], `where`: Swift.Optional<app_profile_categories_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_categories_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_categories_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_categories_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_categories_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_categories_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_categories_bool_exp?> ?? Swift.Optional<app_profile_categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_categories"
public enum app_profile_categories_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profileCategoriesPkey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_categories_pkey": self = .profileCategoriesPkey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileCategoriesPkey: return "profile_categories_pkey"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_categories_constraint, rhs: app_profile_categories_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profileCategoriesPkey, .profileCategoriesPkey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_categories_constraint] {
    return [
      .profileCategoriesPkey,
    ]
  }
}

/// update columns of table "app.profile_categories"
public enum app_profile_categories_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case categoryId
  /// column name
  case profileId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "category_id": self = .categoryId
      case "profile_id": self = .profileId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .categoryId: return "category_id"
      case .profileId: return "profile_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_categories_update_column, rhs: app_profile_categories_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.categoryId, .categoryId): return true
      case (.profileId, .profileId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_categories_update_column] {
    return [
      .categoryId,
      .profileId,
    ]
  }
}

/// input type for inserting array relation for remote table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [app_profile_favorite_collections_insert_input], onConflict: Swift.Optional<app_profile_favorite_collections_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [app_profile_favorite_collections_insert_input] {
    get {
      return graphQLMap["data"] as! [app_profile_favorite_collections_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_favorite_collections_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_favorite_collections_on_conflict?> ?? Swift.Optional<app_profile_favorite_collections_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profile
  ///   - profileId
  public init(collectionId: Swift.Optional<Int?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile": profile, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<Int?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// on conflict condition type for table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_favorite_collections_constraint, updateColumns: [app_profile_favorite_collections_update_column], `where`: Swift.Optional<app_profile_favorite_collections_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_favorite_collections_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_favorite_collections_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_favorite_collections_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_favorite_collections_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_favorite_collections_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_favorite_collections_bool_exp?> ?? Swift.Optional<app_profile_favorite_collections_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_favorite_collections"
public enum app_profile_favorite_collections_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profileFavoriteCollectionsPkey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_favorite_collections_pkey": self = .profileFavoriteCollectionsPkey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileFavoriteCollectionsPkey: return "profile_favorite_collections_pkey"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_favorite_collections_constraint, rhs: app_profile_favorite_collections_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profileFavoriteCollectionsPkey, .profileFavoriteCollectionsPkey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_favorite_collections_constraint] {
    return [
      .profileFavoriteCollectionsPkey,
    ]
  }
}

/// update columns of table "app.profile_favorite_collections"
public enum app_profile_favorite_collections_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case collectionId
  /// column name
  case profileId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "collection_id": self = .collectionId
      case "profile_id": self = .profileId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .collectionId: return "collection_id"
      case .profileId: return "profile_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_favorite_collections_update_column, rhs: app_profile_favorite_collections_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.collectionId, .collectionId): return true
      case (.profileId, .profileId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_favorite_collections_update_column] {
    return [
      .collectionId,
      .profileId,
    ]
  }
}

/// input type for inserting array relation for remote table "app.profile_holdings"
public struct app_profile_holdings_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [app_profile_holdings_insert_input], onConflict: Swift.Optional<app_profile_holdings_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [app_profile_holdings_insert_input] {
    get {
      return graphQLMap["data"] as! [app_profile_holdings_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_holdings_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_holdings_on_conflict?> ?? Swift.Optional<app_profile_holdings_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_holdings"
public struct app_profile_holdings_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - account
  ///   - accountId
  ///   - createdAt
  ///   - holdingDetails
  ///   - holdingTransactions
  ///   - id
  ///   - isoCurrencyCode
  ///   - plaidAccessTokenId
  ///   - portfolioHoldingGains
  ///   - profile
  ///   - profileId
  ///   - quantity
  ///   - refId
  ///   - security
  ///   - securityId
  ///   - updatedAt
  public init(account: Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> = nil, accountId: Swift.Optional<Int?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, holdingDetails: Swift.Optional<portfolio_holding_details_obj_rel_insert_input?> = nil, holdingTransactions: Swift.Optional<app_profile_portfolio_transactions_arr_rel_insert_input?> = nil, id: Swift.Optional<Int?> = nil, isoCurrencyCode: Swift.Optional<String?> = nil, plaidAccessTokenId: Swift.Optional<Int?> = nil, portfolioHoldingGains: Swift.Optional<portfolio_holding_gains_obj_rel_insert_input?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, quantity: Swift.Optional<float8?> = nil, refId: Swift.Optional<String?> = nil, security: Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> = nil, securityId: Swift.Optional<Int?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["account": account, "account_id": accountId, "created_at": createdAt, "holding_details": holdingDetails, "holding_transactions": holdingTransactions, "id": id, "iso_currency_code": isoCurrencyCode, "plaid_access_token_id": plaidAccessTokenId, "portfolio_holding_gains": portfolioHoldingGains, "profile": profile, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "updated_at": updatedAt]
  }

  public var account: Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> {
    get {
      return graphQLMap["account"] as? Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> ?? Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account")
    }
  }

  public var accountId: Swift.Optional<Int?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var holdingDetails: Swift.Optional<portfolio_holding_details_obj_rel_insert_input?> {
    get {
      return graphQLMap["holding_details"] as? Swift.Optional<portfolio_holding_details_obj_rel_insert_input?> ?? Swift.Optional<portfolio_holding_details_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding_details")
    }
  }

  public var holdingTransactions: Swift.Optional<app_profile_portfolio_transactions_arr_rel_insert_input?> {
    get {
      return graphQLMap["holding_transactions"] as? Swift.Optional<app_profile_portfolio_transactions_arr_rel_insert_input?> ?? Swift.Optional<app_profile_portfolio_transactions_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding_transactions")
    }
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var isoCurrencyCode: Swift.Optional<String?> {
    get {
      return graphQLMap["iso_currency_code"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "iso_currency_code")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<Int?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var portfolioHoldingGains: Swift.Optional<portfolio_holding_gains_obj_rel_insert_input?> {
    get {
      return graphQLMap["portfolio_holding_gains"] as? Swift.Optional<portfolio_holding_gains_obj_rel_insert_input?> ?? Swift.Optional<portfolio_holding_gains_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_holding_gains")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<float8?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var refId: Swift.Optional<String?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var security: Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> {
    get {
      return graphQLMap["security"] as? Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> ?? Swift.Optional<app_portfolio_securities_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security")
    }
  }

  public var securityId: Swift.Optional<Int?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }

  public var updatedAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// input type for inserting object relation for remote table "app.profile_portfolio_accounts"
public struct app_profile_portfolio_accounts_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_profile_portfolio_accounts_insert_input, onConflict: Swift.Optional<app_profile_portfolio_accounts_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_profile_portfolio_accounts_insert_input {
    get {
      return graphQLMap["data"] as! app_profile_portfolio_accounts_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_portfolio_accounts_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_portfolio_accounts_on_conflict?> ?? Swift.Optional<app_profile_portfolio_accounts_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_portfolio_accounts"
public struct app_profile_portfolio_accounts_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - balanceAvailable
  ///   - balanceCurrent
  ///   - balanceIsoCurrencyCode
  ///   - balanceLimit
  ///   - createdAt
  ///   - id
  ///   - mask
  ///   - name
  ///   - officialName
  ///   - plaidAccessTokenId
  ///   - profile
  ///   - profileHoldings
  ///   - profileId
  ///   - refId
  ///   - subtype
  ///   - type
  ///   - updatedAt
  public init(balanceAvailable: Swift.Optional<float8?> = nil, balanceCurrent: Swift.Optional<float8?> = nil, balanceIsoCurrencyCode: Swift.Optional<String?> = nil, balanceLimit: Swift.Optional<float8?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, id: Swift.Optional<Int?> = nil, mask: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, officialName: Swift.Optional<String?> = nil, plaidAccessTokenId: Swift.Optional<Int?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, refId: Swift.Optional<String?> = nil, subtype: Swift.Optional<String?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["balance_available": balanceAvailable, "balance_current": balanceCurrent, "balance_iso_currency_code": balanceIsoCurrencyCode, "balance_limit": balanceLimit, "created_at": createdAt, "id": id, "mask": mask, "name": name, "official_name": officialName, "plaid_access_token_id": plaidAccessTokenId, "profile": profile, "profile_holdings": profileHoldings, "profile_id": profileId, "ref_id": refId, "subtype": subtype, "type": type, "updated_at": updatedAt]
  }

  public var balanceAvailable: Swift.Optional<float8?> {
    get {
      return graphQLMap["balance_available"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "balance_available")
    }
  }

  public var balanceCurrent: Swift.Optional<float8?> {
    get {
      return graphQLMap["balance_current"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "balance_current")
    }
  }

  public var balanceIsoCurrencyCode: Swift.Optional<String?> {
    get {
      return graphQLMap["balance_iso_currency_code"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "balance_iso_currency_code")
    }
  }

  public var balanceLimit: Swift.Optional<float8?> {
    get {
      return graphQLMap["balance_limit"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "balance_limit")
    }
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var mask: Swift.Optional<String?> {
    get {
      return graphQLMap["mask"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "mask")
    }
  }

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var officialName: Swift.Optional<String?> {
    get {
      return graphQLMap["official_name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "official_name")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<Int?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> {
    get {
      return graphQLMap["profile_holdings"] as? Swift.Optional<app_profile_holdings_arr_rel_insert_input?> ?? Swift.Optional<app_profile_holdings_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_holdings")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var refId: Swift.Optional<String?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var subtype: Swift.Optional<String?> {
    get {
      return graphQLMap["subtype"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "subtype")
    }
  }

  public var type: Swift.Optional<String?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// on conflict condition type for table "app.profile_portfolio_accounts"
public struct app_profile_portfolio_accounts_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_portfolio_accounts_constraint, updateColumns: [app_profile_portfolio_accounts_update_column], `where`: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_portfolio_accounts_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_portfolio_accounts_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_portfolio_accounts_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_portfolio_accounts_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_portfolio_accounts_bool_exp?> ?? Swift.Optional<app_profile_portfolio_accounts_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_portfolio_accounts"
public enum app_profile_portfolio_accounts_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profilePortfolioAccountsPkey
  /// unique or primary key constraint
  case profilePortfolioAccountsRefIdKey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_portfolio_accounts_pkey": self = .profilePortfolioAccountsPkey
      case "profile_portfolio_accounts_ref_id_key": self = .profilePortfolioAccountsRefIdKey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profilePortfolioAccountsPkey: return "profile_portfolio_accounts_pkey"
      case .profilePortfolioAccountsRefIdKey: return "profile_portfolio_accounts_ref_id_key"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_portfolio_accounts_constraint, rhs: app_profile_portfolio_accounts_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profilePortfolioAccountsPkey, .profilePortfolioAccountsPkey): return true
      case (.profilePortfolioAccountsRefIdKey, .profilePortfolioAccountsRefIdKey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_portfolio_accounts_constraint] {
    return [
      .profilePortfolioAccountsPkey,
      .profilePortfolioAccountsRefIdKey,
    ]
  }
}

/// update columns of table "app.profile_portfolio_accounts"
public enum app_profile_portfolio_accounts_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case balanceAvailable
  /// column name
  case balanceCurrent
  /// column name
  case balanceIsoCurrencyCode
  /// column name
  case balanceLimit
  /// column name
  case createdAt
  /// column name
  case id
  /// column name
  case mask
  /// column name
  case name
  /// column name
  case officialName
  /// column name
  case plaidAccessTokenId
  /// column name
  case profileId
  /// column name
  case refId
  /// column name
  case subtype
  /// column name
  case type
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "balance_available": self = .balanceAvailable
      case "balance_current": self = .balanceCurrent
      case "balance_iso_currency_code": self = .balanceIsoCurrencyCode
      case "balance_limit": self = .balanceLimit
      case "created_at": self = .createdAt
      case "id": self = .id
      case "mask": self = .mask
      case "name": self = .name
      case "official_name": self = .officialName
      case "plaid_access_token_id": self = .plaidAccessTokenId
      case "profile_id": self = .profileId
      case "ref_id": self = .refId
      case "subtype": self = .subtype
      case "type": self = .type
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .balanceAvailable: return "balance_available"
      case .balanceCurrent: return "balance_current"
      case .balanceIsoCurrencyCode: return "balance_iso_currency_code"
      case .balanceLimit: return "balance_limit"
      case .createdAt: return "created_at"
      case .id: return "id"
      case .mask: return "mask"
      case .name: return "name"
      case .officialName: return "official_name"
      case .plaidAccessTokenId: return "plaid_access_token_id"
      case .profileId: return "profile_id"
      case .refId: return "ref_id"
      case .subtype: return "subtype"
      case .type: return "type"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_portfolio_accounts_update_column, rhs: app_profile_portfolio_accounts_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.balanceAvailable, .balanceAvailable): return true
      case (.balanceCurrent, .balanceCurrent): return true
      case (.balanceIsoCurrencyCode, .balanceIsoCurrencyCode): return true
      case (.balanceLimit, .balanceLimit): return true
      case (.createdAt, .createdAt): return true
      case (.id, .id): return true
      case (.mask, .mask): return true
      case (.name, .name): return true
      case (.officialName, .officialName): return true
      case (.plaidAccessTokenId, .plaidAccessTokenId): return true
      case (.profileId, .profileId): return true
      case (.refId, .refId): return true
      case (.subtype, .subtype): return true
      case (.type, .type): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_portfolio_accounts_update_column] {
    return [
      .balanceAvailable,
      .balanceCurrent,
      .balanceIsoCurrencyCode,
      .balanceLimit,
      .createdAt,
      .id,
      .mask,
      .name,
      .officialName,
      .plaidAccessTokenId,
      .profileId,
      .refId,
      .subtype,
      .type,
      .updatedAt,
    ]
  }
}

/// input type for inserting object relation for remote table "portfolio_holding_details"
public struct portfolio_holding_details_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: portfolio_holding_details_insert_input, onConflict: Swift.Optional<portfolio_holding_details_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: portfolio_holding_details_insert_input {
    get {
      return graphQLMap["data"] as! portfolio_holding_details_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<portfolio_holding_details_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<portfolio_holding_details_on_conflict?> ?? Swift.Optional<portfolio_holding_details_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "portfolio_holding_details"
public struct portfolio_holding_details_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - holding
  ///   - holdingId
  ///   - lttQuantityTotal
  ///   - marketCapitalization
  ///   - nextEarningsDate
  ///   - purchaseDate
  ///   - relativeGain_1d
  ///   - relativeGainTotal
  ///   - securityType
  ///   - ticker
  ///   - tickerName
  ///   - tickerSymbol
  ///   - valueToPortfolioValue
  public init(accountId: Swift.Optional<Int?> = nil, holding: Swift.Optional<app_profile_holdings_obj_rel_insert_input?> = nil, holdingId: Swift.Optional<Int?> = nil, lttQuantityTotal: Swift.Optional<float8?> = nil, marketCapitalization: Swift.Optional<bigint?> = nil, nextEarningsDate: Swift.Optional<timestamp?> = nil, purchaseDate: Swift.Optional<timestamp?> = nil, relativeGain_1d: Swift.Optional<float8?> = nil, relativeGainTotal: Swift.Optional<float8?> = nil, securityType: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil, tickerName: Swift.Optional<String?> = nil, tickerSymbol: Swift.Optional<String?> = nil, valueToPortfolioValue: Swift.Optional<float8?> = nil) {
    graphQLMap = ["account_id": accountId, "holding": holding, "holding_id": holdingId, "ltt_quantity_total": lttQuantityTotal, "market_capitalization": marketCapitalization, "next_earnings_date": nextEarningsDate, "purchase_date": purchaseDate, "relative_gain_1d": relativeGain_1d, "relative_gain_total": relativeGainTotal, "security_type": securityType, "ticker": ticker, "ticker_name": tickerName, "ticker_symbol": tickerSymbol, "value_to_portfolio_value": valueToPortfolioValue]
  }

  public var accountId: Swift.Optional<Int?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var holding: Swift.Optional<app_profile_holdings_obj_rel_insert_input?> {
    get {
      return graphQLMap["holding"] as? Swift.Optional<app_profile_holdings_obj_rel_insert_input?> ?? Swift.Optional<app_profile_holdings_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding")
    }
  }

  public var holdingId: Swift.Optional<Int?> {
    get {
      return graphQLMap["holding_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding_id")
    }
  }

  public var lttQuantityTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["ltt_quantity_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ltt_quantity_total")
    }
  }

  public var marketCapitalization: Swift.Optional<bigint?> {
    get {
      return graphQLMap["market_capitalization"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capitalization")
    }
  }

  public var nextEarningsDate: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["next_earnings_date"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "next_earnings_date")
    }
  }

  public var purchaseDate: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["purchase_date"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "purchase_date")
    }
  }

  public var relativeGain_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGainTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var securityType: Swift.Optional<String?> {
    get {
      return graphQLMap["security_type"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_type")
    }
  }

  public var ticker: Swift.Optional<tickers_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_obj_rel_insert_input?> ?? Swift.Optional<tickers_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }

  public var tickerName: Swift.Optional<String?> {
    get {
      return graphQLMap["ticker_name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_name")
    }
  }

  public var tickerSymbol: Swift.Optional<String?> {
    get {
      return graphQLMap["ticker_symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_symbol")
    }
  }

  public var valueToPortfolioValue: Swift.Optional<float8?> {
    get {
      return graphQLMap["value_to_portfolio_value"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "value_to_portfolio_value")
    }
  }
}

/// input type for inserting object relation for remote table "app.profile_holdings"
public struct app_profile_holdings_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_profile_holdings_insert_input, onConflict: Swift.Optional<app_profile_holdings_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_profile_holdings_insert_input {
    get {
      return graphQLMap["data"] as! app_profile_holdings_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_holdings_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_holdings_on_conflict?> ?? Swift.Optional<app_profile_holdings_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// on conflict condition type for table "app.profile_holdings"
public struct app_profile_holdings_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_holdings_constraint, updateColumns: [app_profile_holdings_update_column], `where`: Swift.Optional<app_profile_holdings_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_holdings_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_holdings_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_holdings_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_holdings_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_holdings_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_holdings_bool_exp?> ?? Swift.Optional<app_profile_holdings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_holdings"
public enum app_profile_holdings_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profileHoldingsPkey
  /// unique or primary key constraint
  case profileHoldingsRefIdKey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_holdings_pkey": self = .profileHoldingsPkey
      case "profile_holdings_ref_id_key": self = .profileHoldingsRefIdKey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileHoldingsPkey: return "profile_holdings_pkey"
      case .profileHoldingsRefIdKey: return "profile_holdings_ref_id_key"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_holdings_constraint, rhs: app_profile_holdings_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profileHoldingsPkey, .profileHoldingsPkey): return true
      case (.profileHoldingsRefIdKey, .profileHoldingsRefIdKey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_holdings_constraint] {
    return [
      .profileHoldingsPkey,
      .profileHoldingsRefIdKey,
    ]
  }
}

/// update columns of table "app.profile_holdings"
public enum app_profile_holdings_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case accountId
  /// column name
  case createdAt
  /// column name
  case id
  /// column name
  case isoCurrencyCode
  /// column name
  case plaidAccessTokenId
  /// column name
  case profileId
  /// column name
  case quantity
  /// column name
  case refId
  /// column name
  case securityId
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "account_id": self = .accountId
      case "created_at": self = .createdAt
      case "id": self = .id
      case "iso_currency_code": self = .isoCurrencyCode
      case "plaid_access_token_id": self = .plaidAccessTokenId
      case "profile_id": self = .profileId
      case "quantity": self = .quantity
      case "ref_id": self = .refId
      case "security_id": self = .securityId
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .accountId: return "account_id"
      case .createdAt: return "created_at"
      case .id: return "id"
      case .isoCurrencyCode: return "iso_currency_code"
      case .plaidAccessTokenId: return "plaid_access_token_id"
      case .profileId: return "profile_id"
      case .quantity: return "quantity"
      case .refId: return "ref_id"
      case .securityId: return "security_id"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_holdings_update_column, rhs: app_profile_holdings_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.accountId, .accountId): return true
      case (.createdAt, .createdAt): return true
      case (.id, .id): return true
      case (.isoCurrencyCode, .isoCurrencyCode): return true
      case (.plaidAccessTokenId, .plaidAccessTokenId): return true
      case (.profileId, .profileId): return true
      case (.quantity, .quantity): return true
      case (.refId, .refId): return true
      case (.securityId, .securityId): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_holdings_update_column] {
    return [
      .accountId,
      .createdAt,
      .id,
      .isoCurrencyCode,
      .plaidAccessTokenId,
      .profileId,
      .quantity,
      .refId,
      .securityId,
      .updatedAt,
    ]
  }
}

/// input type for inserting object relation for remote table "tickers"
public struct tickers_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: tickers_insert_input, onConflict: Swift.Optional<tickers_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: tickers_insert_input {
    get {
      return graphQLMap["data"] as! tickers_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<tickers_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<tickers_on_conflict?> ?? Swift.Optional<tickers_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "tickers"
public struct tickers_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - countryName
  ///   - description
  ///   - gicGroup
  ///   - gicIndustry
  ///   - gicSector
  ///   - gicSubIndustry
  ///   - historicalGrowthRates
  ///   - industry
  ///   - ipoDate
  ///   - logoUrl
  ///   - name
  ///   - phone
  ///   - realtimeMetrics
  ///   - sector
  ///   - symbol
  ///   - tickerAnalystRatings
  ///   - tickerCategories
  ///   - tickerCollections
  ///   - tickerEvents
  ///   - tickerFinancials
  ///   - tickerGrowthRate_1m
  ///   - tickerGrowthRate_1w
  ///   - tickerHighlights
  ///   - tickerIndustries
  ///   - tickerInterests
  ///   - tickerMetrics
  ///   - type
  ///   - updatedAt
  ///   - webUrl
  public init(countryName: Swift.Optional<String?> = nil, description: Swift.Optional<String?> = nil, gicGroup: Swift.Optional<String?> = nil, gicIndustry: Swift.Optional<String?> = nil, gicSector: Swift.Optional<String?> = nil, gicSubIndustry: Swift.Optional<String?> = nil, historicalGrowthRates: Swift.Optional<historical_growth_rate_arr_rel_insert_input?> = nil, industry: Swift.Optional<String?> = nil, ipoDate: Swift.Optional<date?> = nil, logoUrl: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, phone: Swift.Optional<String?> = nil, realtimeMetrics: Swift.Optional<ticker_realtime_metrics_obj_rel_insert_input?> = nil, sector: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil, tickerAnalystRatings: Swift.Optional<analyst_ratings_obj_rel_insert_input?> = nil, tickerCategories: Swift.Optional<ticker_categories_arr_rel_insert_input?> = nil, tickerCollections: Swift.Optional<ticker_collections_arr_rel_insert_input?> = nil, tickerEvents: Swift.Optional<ticker_events_arr_rel_insert_input?> = nil, tickerFinancials: Swift.Optional<ticker_financials_arr_rel_insert_input?> = nil, tickerGrowthRate_1m: Swift.Optional<growth_rate_1m_arr_rel_insert_input?> = nil, tickerGrowthRate_1w: Swift.Optional<growth_rate_1w_arr_rel_insert_input?> = nil, tickerHighlights: Swift.Optional<ticker_highlights_arr_rel_insert_input?> = nil, tickerIndustries: Swift.Optional<ticker_industries_arr_rel_insert_input?> = nil, tickerInterests: Swift.Optional<ticker_interests_arr_rel_insert_input?> = nil, tickerMetrics: Swift.Optional<ticker_metrics_obj_rel_insert_input?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamp?> = nil, webUrl: Swift.Optional<String?> = nil) {
    graphQLMap = ["country_name": countryName, "description": description, "gic_group": gicGroup, "gic_industry": gicIndustry, "gic_sector": gicSector, "gic_sub_industry": gicSubIndustry, "historical_growth_rates": historicalGrowthRates, "industry": industry, "ipo_date": ipoDate, "logo_url": logoUrl, "name": name, "phone": phone, "realtime_metrics": realtimeMetrics, "sector": sector, "symbol": symbol, "ticker_analyst_ratings": tickerAnalystRatings, "ticker_categories": tickerCategories, "ticker_collections": tickerCollections, "ticker_events": tickerEvents, "ticker_financials": tickerFinancials, "ticker_growth_rate_1m": tickerGrowthRate_1m, "ticker_growth_rate_1w": tickerGrowthRate_1w, "ticker_highlights": tickerHighlights, "ticker_industries": tickerIndustries, "ticker_interests": tickerInterests, "ticker_metrics": tickerMetrics, "type": type, "updated_at": updatedAt, "web_url": webUrl]
  }

  public var countryName: Swift.Optional<String?> {
    get {
      return graphQLMap["country_name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country_name")
    }
  }

  public var description: Swift.Optional<String?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var gicGroup: Swift.Optional<String?> {
    get {
      return graphQLMap["gic_group"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_group")
    }
  }

  public var gicIndustry: Swift.Optional<String?> {
    get {
      return graphQLMap["gic_industry"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_industry")
    }
  }

  public var gicSector: Swift.Optional<String?> {
    get {
      return graphQLMap["gic_sector"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_sector")
    }
  }

  public var gicSubIndustry: Swift.Optional<String?> {
    get {
      return graphQLMap["gic_sub_industry"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_sub_industry")
    }
  }

  public var historicalGrowthRates: Swift.Optional<historical_growth_rate_arr_rel_insert_input?> {
    get {
      return graphQLMap["historical_growth_rates"] as? Swift.Optional<historical_growth_rate_arr_rel_insert_input?> ?? Swift.Optional<historical_growth_rate_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "historical_growth_rates")
    }
  }

  public var industry: Swift.Optional<String?> {
    get {
      return graphQLMap["industry"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry")
    }
  }

  public var ipoDate: Swift.Optional<date?> {
    get {
      return graphQLMap["ipo_date"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ipo_date")
    }
  }

  public var logoUrl: Swift.Optional<String?> {
    get {
      return graphQLMap["logo_url"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "logo_url")
    }
  }

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var phone: Swift.Optional<String?> {
    get {
      return graphQLMap["phone"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "phone")
    }
  }

  public var realtimeMetrics: Swift.Optional<ticker_realtime_metrics_obj_rel_insert_input?> {
    get {
      return graphQLMap["realtime_metrics"] as? Swift.Optional<ticker_realtime_metrics_obj_rel_insert_input?> ?? Swift.Optional<ticker_realtime_metrics_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "realtime_metrics")
    }
  }

  public var sector: Swift.Optional<String?> {
    get {
      return graphQLMap["sector"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sector")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var tickerAnalystRatings: Swift.Optional<analyst_ratings_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker_analyst_ratings"] as? Swift.Optional<analyst_ratings_obj_rel_insert_input?> ?? Swift.Optional<analyst_ratings_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_analyst_ratings")
    }
  }

  public var tickerCategories: Swift.Optional<ticker_categories_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_categories"] as? Swift.Optional<ticker_categories_arr_rel_insert_input?> ?? Swift.Optional<ticker_categories_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_categories")
    }
  }

  public var tickerCollections: Swift.Optional<ticker_collections_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_collections"] as? Swift.Optional<ticker_collections_arr_rel_insert_input?> ?? Swift.Optional<ticker_collections_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_collections")
    }
  }

  public var tickerEvents: Swift.Optional<ticker_events_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_events"] as? Swift.Optional<ticker_events_arr_rel_insert_input?> ?? Swift.Optional<ticker_events_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_events")
    }
  }

  public var tickerFinancials: Swift.Optional<ticker_financials_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_financials"] as? Swift.Optional<ticker_financials_arr_rel_insert_input?> ?? Swift.Optional<ticker_financials_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_financials")
    }
  }

  public var tickerGrowthRate_1m: Swift.Optional<growth_rate_1m_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_growth_rate_1m"] as? Swift.Optional<growth_rate_1m_arr_rel_insert_input?> ?? Swift.Optional<growth_rate_1m_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_growth_rate_1m")
    }
  }

  public var tickerGrowthRate_1w: Swift.Optional<growth_rate_1w_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_growth_rate_1w"] as? Swift.Optional<growth_rate_1w_arr_rel_insert_input?> ?? Swift.Optional<growth_rate_1w_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_growth_rate_1w")
    }
  }

  public var tickerHighlights: Swift.Optional<ticker_highlights_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_highlights"] as? Swift.Optional<ticker_highlights_arr_rel_insert_input?> ?? Swift.Optional<ticker_highlights_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_highlights")
    }
  }

  public var tickerIndustries: Swift.Optional<ticker_industries_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_industries"] as? Swift.Optional<ticker_industries_arr_rel_insert_input?> ?? Swift.Optional<ticker_industries_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industries")
    }
  }

  public var tickerInterests: Swift.Optional<ticker_interests_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_interests"] as? Swift.Optional<ticker_interests_arr_rel_insert_input?> ?? Swift.Optional<ticker_interests_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_interests")
    }
  }

  public var tickerMetrics: Swift.Optional<ticker_metrics_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker_metrics"] as? Swift.Optional<ticker_metrics_obj_rel_insert_input?> ?? Swift.Optional<ticker_metrics_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_metrics")
    }
  }

  public var type: Swift.Optional<String?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }

  public var webUrl: Swift.Optional<String?> {
    get {
      return graphQLMap["web_url"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "web_url")
    }
  }
}

/// input type for inserting array relation for remote table "historical_growth_rate"
public struct historical_growth_rate_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [historical_growth_rate_insert_input], onConflict: Swift.Optional<historical_growth_rate_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [historical_growth_rate_insert_input] {
    get {
      return graphQLMap["data"] as! [historical_growth_rate_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<historical_growth_rate_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<historical_growth_rate_on_conflict?> ?? Swift.Optional<historical_growth_rate_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "historical_growth_rate"
public struct historical_growth_rate_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - growthRate_1d
  ///   - growthRate_1m
  ///   - growthRate_1w
  ///   - growthRate_1y
  ///   - growthRate_3m
  ///   - id
  ///   - symbol
  public init(date: Swift.Optional<date?> = nil, growthRate_1d: Swift.Optional<float8?> = nil, growthRate_1m: Swift.Optional<float8?> = nil, growthRate_1w: Swift.Optional<float8?> = nil, growthRate_1y: Swift.Optional<float8?> = nil, growthRate_3m: Swift.Optional<float8?> = nil, id: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["date": date, "growth_rate_1d": growthRate_1d, "growth_rate_1m": growthRate_1m, "growth_rate_1w": growthRate_1w, "growth_rate_1y": growthRate_1y, "growth_rate_3m": growthRate_3m, "id": id, "symbol": symbol]
  }

  public var date: Swift.Optional<date?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var growthRate_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["growth_rate_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_1d")
    }
  }

  public var growthRate_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["growth_rate_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_1m")
    }
  }

  public var growthRate_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["growth_rate_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_1w")
    }
  }

  public var growthRate_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["growth_rate_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_1y")
    }
  }

  public var growthRate_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["growth_rate_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate_3m")
    }
  }

  public var id: Swift.Optional<String?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// on conflict condition type for table "historical_growth_rate"
public struct historical_growth_rate_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: historical_growth_rate_constraint, updateColumns: [historical_growth_rate_update_column], `where`: Swift.Optional<historical_growth_rate_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: historical_growth_rate_constraint {
    get {
      return graphQLMap["constraint"] as! historical_growth_rate_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [historical_growth_rate_update_column] {
    get {
      return graphQLMap["update_columns"] as! [historical_growth_rate_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<historical_growth_rate_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<historical_growth_rate_bool_exp?> ?? Swift.Optional<historical_growth_rate_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "historical_growth_rate"
public enum historical_growth_rate_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case historicalGrowthRateUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "historical_growth_rate_unique_id": self = .historicalGrowthRateUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .historicalGrowthRateUniqueId: return "historical_growth_rate_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: historical_growth_rate_constraint, rhs: historical_growth_rate_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.historicalGrowthRateUniqueId, .historicalGrowthRateUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [historical_growth_rate_constraint] {
    return [
      .historicalGrowthRateUniqueId,
    ]
  }
}

/// update columns of table "historical_growth_rate"
public enum historical_growth_rate_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case date
  /// column name
  case growthRate_1d
  /// column name
  case growthRate_1m
  /// column name
  case growthRate_1w
  /// column name
  case growthRate_1y
  /// column name
  case growthRate_3m
  /// column name
  case id
  /// column name
  case symbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "date": self = .date
      case "growth_rate_1d": self = .growthRate_1d
      case "growth_rate_1m": self = .growthRate_1m
      case "growth_rate_1w": self = .growthRate_1w
      case "growth_rate_1y": self = .growthRate_1y
      case "growth_rate_3m": self = .growthRate_3m
      case "id": self = .id
      case "symbol": self = .symbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .date: return "date"
      case .growthRate_1d: return "growth_rate_1d"
      case .growthRate_1m: return "growth_rate_1m"
      case .growthRate_1w: return "growth_rate_1w"
      case .growthRate_1y: return "growth_rate_1y"
      case .growthRate_3m: return "growth_rate_3m"
      case .id: return "id"
      case .symbol: return "symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: historical_growth_rate_update_column, rhs: historical_growth_rate_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.date, .date): return true
      case (.growthRate_1d, .growthRate_1d): return true
      case (.growthRate_1m, .growthRate_1m): return true
      case (.growthRate_1w, .growthRate_1w): return true
      case (.growthRate_1y, .growthRate_1y): return true
      case (.growthRate_3m, .growthRate_3m): return true
      case (.id, .id): return true
      case (.symbol, .symbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [historical_growth_rate_update_column] {
    return [
      .date,
      .growthRate_1d,
      .growthRate_1m,
      .growthRate_1w,
      .growthRate_1y,
      .growthRate_3m,
      .id,
      .symbol,
    ]
  }
}

/// input type for inserting object relation for remote table "ticker_realtime_metrics"
public struct ticker_realtime_metrics_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: ticker_realtime_metrics_insert_input, onConflict: Swift.Optional<ticker_realtime_metrics_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: ticker_realtime_metrics_insert_input {
    get {
      return graphQLMap["data"] as! ticker_realtime_metrics_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<ticker_realtime_metrics_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<ticker_realtime_metrics_on_conflict?> ?? Swift.Optional<ticker_realtime_metrics_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "ticker_realtime_metrics"
public struct ticker_realtime_metrics_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - absoluteDailyChange
  ///   - actualPrice
  ///   - dailyVolume
  ///   - relativeDailyChange
  ///   - symbol
  ///   - time
  public init(absoluteDailyChange: Swift.Optional<float8?> = nil, actualPrice: Swift.Optional<float8?> = nil, dailyVolume: Swift.Optional<float8?> = nil, relativeDailyChange: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil, time: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "daily_volume": dailyVolume, "relative_daily_change": relativeDailyChange, "symbol": symbol, "time": time]
  }

  public var absoluteDailyChange: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_daily_change"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_daily_change")
    }
  }

  public var actualPrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["actual_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "actual_price")
    }
  }

  public var dailyVolume: Swift.Optional<float8?> {
    get {
      return graphQLMap["daily_volume"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "daily_volume")
    }
  }

  public var relativeDailyChange: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_daily_change"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_daily_change")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var time: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["time"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "time")
    }
  }
}

/// on conflict condition type for table "ticker_realtime_metrics"
public struct ticker_realtime_metrics_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: ticker_realtime_metrics_constraint, updateColumns: [ticker_realtime_metrics_update_column], `where`: Swift.Optional<ticker_realtime_metrics_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: ticker_realtime_metrics_constraint {
    get {
      return graphQLMap["constraint"] as! ticker_realtime_metrics_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [ticker_realtime_metrics_update_column] {
    get {
      return graphQLMap["update_columns"] as! [ticker_realtime_metrics_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<ticker_realtime_metrics_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<ticker_realtime_metrics_bool_exp?> ?? Swift.Optional<ticker_realtime_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "ticker_realtime_metrics"
public enum ticker_realtime_metrics_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case tickerRealtimeMetricsUniqueSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ticker_realtime_metrics_unique_symbol": self = .tickerRealtimeMetricsUniqueSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .tickerRealtimeMetricsUniqueSymbol: return "ticker_realtime_metrics_unique_symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_realtime_metrics_constraint, rhs: ticker_realtime_metrics_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.tickerRealtimeMetricsUniqueSymbol, .tickerRealtimeMetricsUniqueSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_realtime_metrics_constraint] {
    return [
      .tickerRealtimeMetricsUniqueSymbol,
    ]
  }
}

/// update columns of table "ticker_realtime_metrics"
public enum ticker_realtime_metrics_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case absoluteDailyChange
  /// column name
  case actualPrice
  /// column name
  case dailyVolume
  /// column name
  case relativeDailyChange
  /// column name
  case symbol
  /// column name
  case time
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "absolute_daily_change": self = .absoluteDailyChange
      case "actual_price": self = .actualPrice
      case "daily_volume": self = .dailyVolume
      case "relative_daily_change": self = .relativeDailyChange
      case "symbol": self = .symbol
      case "time": self = .time
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .absoluteDailyChange: return "absolute_daily_change"
      case .actualPrice: return "actual_price"
      case .dailyVolume: return "daily_volume"
      case .relativeDailyChange: return "relative_daily_change"
      case .symbol: return "symbol"
      case .time: return "time"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_realtime_metrics_update_column, rhs: ticker_realtime_metrics_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.absoluteDailyChange, .absoluteDailyChange): return true
      case (.actualPrice, .actualPrice): return true
      case (.dailyVolume, .dailyVolume): return true
      case (.relativeDailyChange, .relativeDailyChange): return true
      case (.symbol, .symbol): return true
      case (.time, .time): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_realtime_metrics_update_column] {
    return [
      .absoluteDailyChange,
      .actualPrice,
      .dailyVolume,
      .relativeDailyChange,
      .symbol,
      .time,
    ]
  }
}

/// input type for inserting object relation for remote table "analyst_ratings"
public struct analyst_ratings_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: analyst_ratings_insert_input, onConflict: Swift.Optional<analyst_ratings_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: analyst_ratings_insert_input {
    get {
      return graphQLMap["data"] as! analyst_ratings_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<analyst_ratings_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<analyst_ratings_on_conflict?> ?? Swift.Optional<analyst_ratings_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "analyst_ratings"
public struct analyst_ratings_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - buy
  ///   - hold
  ///   - rating
  ///   - sell
  ///   - strongBuy
  ///   - strongSell
  ///   - symbol
  ///   - targetPrice
  public init(buy: Swift.Optional<Int?> = nil, hold: Swift.Optional<Int?> = nil, rating: Swift.Optional<float8?> = nil, sell: Swift.Optional<Int?> = nil, strongBuy: Swift.Optional<Int?> = nil, strongSell: Swift.Optional<Int?> = nil, symbol: Swift.Optional<String?> = nil, targetPrice: Swift.Optional<float8?> = nil) {
    graphQLMap = ["buy": buy, "hold": hold, "rating": rating, "sell": sell, "strong_buy": strongBuy, "strong_sell": strongSell, "symbol": symbol, "target_price": targetPrice]
  }

  public var buy: Swift.Optional<Int?> {
    get {
      return graphQLMap["buy"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "buy")
    }
  }

  public var hold: Swift.Optional<Int?> {
    get {
      return graphQLMap["hold"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hold")
    }
  }

  public var rating: Swift.Optional<float8?> {
    get {
      return graphQLMap["rating"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "rating")
    }
  }

  public var sell: Swift.Optional<Int?> {
    get {
      return graphQLMap["sell"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sell")
    }
  }

  public var strongBuy: Swift.Optional<Int?> {
    get {
      return graphQLMap["strong_buy"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "strong_buy")
    }
  }

  public var strongSell: Swift.Optional<Int?> {
    get {
      return graphQLMap["strong_sell"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "strong_sell")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var targetPrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["target_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "target_price")
    }
  }
}

/// on conflict condition type for table "analyst_ratings"
public struct analyst_ratings_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: analyst_ratings_constraint, updateColumns: [analyst_ratings_update_column], `where`: Swift.Optional<analyst_ratings_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: analyst_ratings_constraint {
    get {
      return graphQLMap["constraint"] as! analyst_ratings_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [analyst_ratings_update_column] {
    get {
      return graphQLMap["update_columns"] as! [analyst_ratings_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<analyst_ratings_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<analyst_ratings_bool_exp?> ?? Swift.Optional<analyst_ratings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "analyst_ratings"
public enum analyst_ratings_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case analystRatingsUniqueSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "analyst_ratings_unique_symbol": self = .analystRatingsUniqueSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .analystRatingsUniqueSymbol: return "analyst_ratings_unique_symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: analyst_ratings_constraint, rhs: analyst_ratings_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.analystRatingsUniqueSymbol, .analystRatingsUniqueSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [analyst_ratings_constraint] {
    return [
      .analystRatingsUniqueSymbol,
    ]
  }
}

/// update columns of table "analyst_ratings"
public enum analyst_ratings_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case buy
  /// column name
  case hold
  /// column name
  case rating
  /// column name
  case sell
  /// column name
  case strongBuy
  /// column name
  case strongSell
  /// column name
  case symbol
  /// column name
  case targetPrice
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "buy": self = .buy
      case "hold": self = .hold
      case "rating": self = .rating
      case "sell": self = .sell
      case "strong_buy": self = .strongBuy
      case "strong_sell": self = .strongSell
      case "symbol": self = .symbol
      case "target_price": self = .targetPrice
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .buy: return "buy"
      case .hold: return "hold"
      case .rating: return "rating"
      case .sell: return "sell"
      case .strongBuy: return "strong_buy"
      case .strongSell: return "strong_sell"
      case .symbol: return "symbol"
      case .targetPrice: return "target_price"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: analyst_ratings_update_column, rhs: analyst_ratings_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.buy, .buy): return true
      case (.hold, .hold): return true
      case (.rating, .rating): return true
      case (.sell, .sell): return true
      case (.strongBuy, .strongBuy): return true
      case (.strongSell, .strongSell): return true
      case (.symbol, .symbol): return true
      case (.targetPrice, .targetPrice): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [analyst_ratings_update_column] {
    return [
      .buy,
      .hold,
      .rating,
      .sell,
      .strongBuy,
      .strongSell,
      .symbol,
      .targetPrice,
    ]
  }
}

/// input type for inserting array relation for remote table "ticker_categories"
public struct ticker_categories_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [ticker_categories_insert_input], onConflict: Swift.Optional<ticker_categories_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [ticker_categories_insert_input] {
    get {
      return graphQLMap["data"] as! [ticker_categories_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<ticker_categories_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<ticker_categories_on_conflict?> ?? Swift.Optional<ticker_categories_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "ticker_categories"
public struct ticker_categories_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categories
  ///   - categoryId
  ///   - symbol
  public init(categories: Swift.Optional<categories_obj_rel_insert_input?> = nil, categoryId: Swift.Optional<Int?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["categories": categories, "category_id": categoryId, "symbol": symbol]
  }

  public var categories: Swift.Optional<categories_obj_rel_insert_input?> {
    get {
      return graphQLMap["categories"] as? Swift.Optional<categories_obj_rel_insert_input?> ?? Swift.Optional<categories_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "categories")
    }
  }

  public var categoryId: Swift.Optional<Int?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// input type for inserting object relation for remote table "categories"
public struct categories_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: categories_insert_input, onConflict: Swift.Optional<categories_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: categories_insert_input {
    get {
      return graphQLMap["data"] as! categories_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<categories_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<categories_on_conflict?> ?? Swift.Optional<categories_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "categories"
public struct categories_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - iconUrl
  ///   - id
  ///   - name
  ///   - riskScore
  public init(iconUrl: Swift.Optional<String?> = nil, id: Swift.Optional<Int?> = nil, name: Swift.Optional<String?> = nil, riskScore: Swift.Optional<Int?> = nil) {
    graphQLMap = ["icon_url": iconUrl, "id": id, "name": name, "risk_score": riskScore]
  }

  public var iconUrl: Swift.Optional<String?> {
    get {
      return graphQLMap["icon_url"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "icon_url")
    }
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var riskScore: Swift.Optional<Int?> {
    get {
      return graphQLMap["risk_score"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_score")
    }
  }
}

/// on conflict condition type for table "categories"
public struct categories_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: categories_constraint, updateColumns: [categories_update_column], `where`: Swift.Optional<categories_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: categories_constraint {
    get {
      return graphQLMap["constraint"] as! categories_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [categories_update_column] {
    get {
      return graphQLMap["update_columns"] as! [categories_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<categories_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<categories_bool_exp?> ?? Swift.Optional<categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "categories"
public enum categories_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case categoriesUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "categories_unique_id": self = .categoriesUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .categoriesUniqueId: return "categories_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: categories_constraint, rhs: categories_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.categoriesUniqueId, .categoriesUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [categories_constraint] {
    return [
      .categoriesUniqueId,
    ]
  }
}

/// update columns of table "categories"
public enum categories_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case iconUrl
  /// column name
  case id
  /// column name
  case name
  /// column name
  case riskScore
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "icon_url": self = .iconUrl
      case "id": self = .id
      case "name": self = .name
      case "risk_score": self = .riskScore
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .iconUrl: return "icon_url"
      case .id: return "id"
      case .name: return "name"
      case .riskScore: return "risk_score"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: categories_update_column, rhs: categories_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.iconUrl, .iconUrl): return true
      case (.id, .id): return true
      case (.name, .name): return true
      case (.riskScore, .riskScore): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [categories_update_column] {
    return [
      .iconUrl,
      .id,
      .name,
      .riskScore,
    ]
  }
}

/// on conflict condition type for table "ticker_categories"
public struct ticker_categories_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: ticker_categories_constraint, updateColumns: [ticker_categories_update_column], `where`: Swift.Optional<ticker_categories_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: ticker_categories_constraint {
    get {
      return graphQLMap["constraint"] as! ticker_categories_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [ticker_categories_update_column] {
    get {
      return graphQLMap["update_columns"] as! [ticker_categories_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<ticker_categories_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<ticker_categories_bool_exp?> ?? Swift.Optional<ticker_categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "ticker_categories"
public enum ticker_categories_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case publicTickerCategoriesSymbolCategoryId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_ticker_categories_symbol__category_id": self = .publicTickerCategoriesSymbolCategoryId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicTickerCategoriesSymbolCategoryId: return "public_ticker_categories_symbol__category_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_categories_constraint, rhs: ticker_categories_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicTickerCategoriesSymbolCategoryId, .publicTickerCategoriesSymbolCategoryId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_categories_constraint] {
    return [
      .publicTickerCategoriesSymbolCategoryId,
    ]
  }
}

/// update columns of table "ticker_categories"
public enum ticker_categories_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case categoryId
  /// column name
  case symbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "category_id": self = .categoryId
      case "symbol": self = .symbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .categoryId: return "category_id"
      case .symbol: return "symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_categories_update_column, rhs: ticker_categories_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.categoryId, .categoryId): return true
      case (.symbol, .symbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_categories_update_column] {
    return [
      .categoryId,
      .symbol,
    ]
  }
}

/// input type for inserting array relation for remote table "profile_ticker_collections"
public struct ticker_collections_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [ticker_collections_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [ticker_collections_insert_input] {
    get {
      return graphQLMap["data"] as! [ticker_collections_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "profile_ticker_collections"
public struct ticker_collections_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profile
  ///   - profileId
  ///   - symbol
  ///   - ticker
  public init(collectionId: Swift.Optional<Int?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile": profile, "profile_id": profileId, "symbol": symbol, "ticker": ticker]
  }

  public var collectionId: Swift.Optional<Int?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_obj_rel_insert_input?> ?? Swift.Optional<tickers_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// input type for inserting array relation for remote table "ticker_events"
public struct ticker_events_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [ticker_events_insert_input], onConflict: Swift.Optional<ticker_events_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [ticker_events_insert_input] {
    get {
      return graphQLMap["data"] as! [ticker_events_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<ticker_events_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<ticker_events_on_conflict?> ?? Swift.Optional<ticker_events_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "ticker_events"
public struct ticker_events_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - date
  ///   - description
  ///   - symbol
  ///   - timestamp
  ///   - type
  public init(createdAt: Swift.Optional<timestamptz?> = nil, date: Swift.Optional<date?> = nil, description: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil, timestamp: Swift.Optional<timestamptz?> = nil, type: Swift.Optional<String?> = nil) {
    graphQLMap = ["created_at": createdAt, "date": date, "description": description, "symbol": symbol, "timestamp": timestamp, "type": type]
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var date: Swift.Optional<date?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var description: Swift.Optional<String?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var timestamp: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["timestamp"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "timestamp")
    }
  }

  public var type: Swift.Optional<String?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }
}

/// on conflict condition type for table "ticker_events"
public struct ticker_events_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: ticker_events_constraint, updateColumns: [ticker_events_update_column], `where`: Swift.Optional<ticker_events_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: ticker_events_constraint {
    get {
      return graphQLMap["constraint"] as! ticker_events_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [ticker_events_update_column] {
    get {
      return graphQLMap["update_columns"] as! [ticker_events_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<ticker_events_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<ticker_events_bool_exp?> ?? Swift.Optional<ticker_events_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "ticker_events"
public enum ticker_events_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case publicTickerEventsSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_ticker_events_symbol": self = .publicTickerEventsSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicTickerEventsSymbol: return "public_ticker_events_symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_events_constraint, rhs: ticker_events_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicTickerEventsSymbol, .publicTickerEventsSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_events_constraint] {
    return [
      .publicTickerEventsSymbol,
    ]
  }
}

/// update columns of table "ticker_events"
public enum ticker_events_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case createdAt
  /// column name
  case date
  /// column name
  case description
  /// column name
  case symbol
  /// column name
  case timestamp
  /// column name
  case type
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "created_at": self = .createdAt
      case "date": self = .date
      case "description": self = .description
      case "symbol": self = .symbol
      case "timestamp": self = .timestamp
      case "type": self = .type
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .createdAt: return "created_at"
      case .date: return "date"
      case .description: return "description"
      case .symbol: return "symbol"
      case .timestamp: return "timestamp"
      case .type: return "type"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_events_update_column, rhs: ticker_events_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.createdAt, .createdAt): return true
      case (.date, .date): return true
      case (.description, .description): return true
      case (.symbol, .symbol): return true
      case (.timestamp, .timestamp): return true
      case (.type, .type): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_events_update_column] {
    return [
      .createdAt,
      .date,
      .description,
      .symbol,
      .timestamp,
      .type,
    ]
  }
}

/// input type for inserting array relation for remote table "ticker_financials"
public struct ticker_financials_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [ticker_financials_insert_input], onConflict: Swift.Optional<ticker_financials_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [ticker_financials_insert_input] {
    get {
      return graphQLMap["data"] as! [ticker_financials_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<ticker_financials_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<ticker_financials_on_conflict?> ?? Swift.Optional<ticker_financials_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "ticker_financials"
public struct ticker_financials_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - dividendGrowth
  ///   - enterpriseValueToSales
  ///   - highlight
  ///   - marketCapitalization
  ///   - monthPricePerformance
  ///   - netProfitMargin
  ///   - peRatio
  ///   - quarterAgoClose
  ///   - quarterPricePerformance
  ///   - quarterlyRevenueGrowthYoy
  ///   - revenueTtm
  ///   - symbol
  public init(createdAt: Swift.Optional<timestamptz?> = nil, dividendGrowth: Swift.Optional<float8?> = nil, enterpriseValueToSales: Swift.Optional<Double?> = nil, highlight: Swift.Optional<String?> = nil, marketCapitalization: Swift.Optional<Double?> = nil, monthPricePerformance: Swift.Optional<Double?> = nil, netProfitMargin: Swift.Optional<Double?> = nil, peRatio: Swift.Optional<Double?> = nil, quarterAgoClose: Swift.Optional<Double?> = nil, quarterPricePerformance: Swift.Optional<Double?> = nil, quarterlyRevenueGrowthYoy: Swift.Optional<Double?> = nil, revenueTtm: Swift.Optional<Double?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["created_at": createdAt, "dividend_growth": dividendGrowth, "enterprise_value_to_sales": enterpriseValueToSales, "highlight": highlight, "market_capitalization": marketCapitalization, "month_price_performance": monthPricePerformance, "net_profit_margin": netProfitMargin, "pe_ratio": peRatio, "quarter_ago_close": quarterAgoClose, "quarter_price_performance": quarterPricePerformance, "quarterly_revenue_growth_yoy": quarterlyRevenueGrowthYoy, "revenue_ttm": revenueTtm, "symbol": symbol]
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var dividendGrowth: Swift.Optional<float8?> {
    get {
      return graphQLMap["dividend_growth"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_growth")
    }
  }

  public var enterpriseValueToSales: Swift.Optional<Double?> {
    get {
      return graphQLMap["enterprise_value_to_sales"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enterprise_value_to_sales")
    }
  }

  public var highlight: Swift.Optional<String?> {
    get {
      return graphQLMap["highlight"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "highlight")
    }
  }

  public var marketCapitalization: Swift.Optional<Double?> {
    get {
      return graphQLMap["market_capitalization"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capitalization")
    }
  }

  public var monthPricePerformance: Swift.Optional<Double?> {
    get {
      return graphQLMap["month_price_performance"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "month_price_performance")
    }
  }

  public var netProfitMargin: Swift.Optional<Double?> {
    get {
      return graphQLMap["net_profit_margin"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_profit_margin")
    }
  }

  public var peRatio: Swift.Optional<Double?> {
    get {
      return graphQLMap["pe_ratio"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "pe_ratio")
    }
  }

  public var quarterAgoClose: Swift.Optional<Double?> {
    get {
      return graphQLMap["quarter_ago_close"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quarter_ago_close")
    }
  }

  public var quarterPricePerformance: Swift.Optional<Double?> {
    get {
      return graphQLMap["quarter_price_performance"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quarter_price_performance")
    }
  }

  public var quarterlyRevenueGrowthYoy: Swift.Optional<Double?> {
    get {
      return graphQLMap["quarterly_revenue_growth_yoy"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quarterly_revenue_growth_yoy")
    }
  }

  public var revenueTtm: Swift.Optional<Double?> {
    get {
      return graphQLMap["revenue_ttm"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_ttm")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// on conflict condition type for table "ticker_financials"
public struct ticker_financials_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: ticker_financials_constraint, updateColumns: [ticker_financials_update_column], `where`: Swift.Optional<ticker_financials_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: ticker_financials_constraint {
    get {
      return graphQLMap["constraint"] as! ticker_financials_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [ticker_financials_update_column] {
    get {
      return graphQLMap["update_columns"] as! [ticker_financials_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<ticker_financials_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<ticker_financials_bool_exp?> ?? Swift.Optional<ticker_financials_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "ticker_financials"
public enum ticker_financials_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case tickerFinancialsUniqueSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ticker_financials_unique_symbol": self = .tickerFinancialsUniqueSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .tickerFinancialsUniqueSymbol: return "ticker_financials_unique_symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_financials_constraint, rhs: ticker_financials_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.tickerFinancialsUniqueSymbol, .tickerFinancialsUniqueSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_financials_constraint] {
    return [
      .tickerFinancialsUniqueSymbol,
    ]
  }
}

/// update columns of table "ticker_financials"
public enum ticker_financials_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case createdAt
  /// column name
  case dividendGrowth
  /// column name
  case enterpriseValueToSales
  /// column name
  case highlight
  /// column name
  case marketCapitalization
  /// column name
  case monthPricePerformance
  /// column name
  case netProfitMargin
  /// column name
  case peRatio
  /// column name
  case quarterAgoClose
  /// column name
  case quarterPricePerformance
  /// column name
  case quarterlyRevenueGrowthYoy
  /// column name
  case revenueTtm
  /// column name
  case symbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "created_at": self = .createdAt
      case "dividend_growth": self = .dividendGrowth
      case "enterprise_value_to_sales": self = .enterpriseValueToSales
      case "highlight": self = .highlight
      case "market_capitalization": self = .marketCapitalization
      case "month_price_performance": self = .monthPricePerformance
      case "net_profit_margin": self = .netProfitMargin
      case "pe_ratio": self = .peRatio
      case "quarter_ago_close": self = .quarterAgoClose
      case "quarter_price_performance": self = .quarterPricePerformance
      case "quarterly_revenue_growth_yoy": self = .quarterlyRevenueGrowthYoy
      case "revenue_ttm": self = .revenueTtm
      case "symbol": self = .symbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .createdAt: return "created_at"
      case .dividendGrowth: return "dividend_growth"
      case .enterpriseValueToSales: return "enterprise_value_to_sales"
      case .highlight: return "highlight"
      case .marketCapitalization: return "market_capitalization"
      case .monthPricePerformance: return "month_price_performance"
      case .netProfitMargin: return "net_profit_margin"
      case .peRatio: return "pe_ratio"
      case .quarterAgoClose: return "quarter_ago_close"
      case .quarterPricePerformance: return "quarter_price_performance"
      case .quarterlyRevenueGrowthYoy: return "quarterly_revenue_growth_yoy"
      case .revenueTtm: return "revenue_ttm"
      case .symbol: return "symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_financials_update_column, rhs: ticker_financials_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.createdAt, .createdAt): return true
      case (.dividendGrowth, .dividendGrowth): return true
      case (.enterpriseValueToSales, .enterpriseValueToSales): return true
      case (.highlight, .highlight): return true
      case (.marketCapitalization, .marketCapitalization): return true
      case (.monthPricePerformance, .monthPricePerformance): return true
      case (.netProfitMargin, .netProfitMargin): return true
      case (.peRatio, .peRatio): return true
      case (.quarterAgoClose, .quarterAgoClose): return true
      case (.quarterPricePerformance, .quarterPricePerformance): return true
      case (.quarterlyRevenueGrowthYoy, .quarterlyRevenueGrowthYoy): return true
      case (.revenueTtm, .revenueTtm): return true
      case (.symbol, .symbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_financials_update_column] {
    return [
      .createdAt,
      .dividendGrowth,
      .enterpriseValueToSales,
      .highlight,
      .marketCapitalization,
      .monthPricePerformance,
      .netProfitMargin,
      .peRatio,
      .quarterAgoClose,
      .quarterPricePerformance,
      .quarterlyRevenueGrowthYoy,
      .revenueTtm,
      .symbol,
    ]
  }
}

/// input type for inserting array relation for remote table "growth_rate_1m"
public struct growth_rate_1m_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [growth_rate_1m_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [growth_rate_1m_insert_input] {
    get {
      return graphQLMap["data"] as! [growth_rate_1m_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "growth_rate_1m"
public struct growth_rate_1m_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - growthRate
  ///   - symbol
  public init(date: Swift.Optional<timestamp?> = nil, growthRate: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["date": date, "growth_rate": growthRate, "symbol": symbol]
  }

  public var date: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var growthRate: Swift.Optional<float8?> {
    get {
      return graphQLMap["growth_rate"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// input type for inserting array relation for remote table "growth_rate_1w"
public struct growth_rate_1w_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [growth_rate_1w_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [growth_rate_1w_insert_input] {
    get {
      return graphQLMap["data"] as! [growth_rate_1w_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "growth_rate_1w"
public struct growth_rate_1w_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - growthRate
  ///   - symbol
  public init(date: Swift.Optional<timestamp?> = nil, growthRate: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["date": date, "growth_rate": growthRate, "symbol": symbol]
  }

  public var date: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var growthRate: Swift.Optional<float8?> {
    get {
      return graphQLMap["growth_rate"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "growth_rate")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// input type for inserting array relation for remote table "ticker_highlights"
public struct ticker_highlights_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [ticker_highlights_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [ticker_highlights_insert_input] {
    get {
      return graphQLMap["data"] as! [ticker_highlights_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "ticker_highlights"
public struct ticker_highlights_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - highlight
  ///   - symbol
  ///   - ticker
  public init(createdAt: Swift.Optional<timestamptz?> = nil, highlight: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil) {
    graphQLMap = ["created_at": createdAt, "highlight": highlight, "symbol": symbol, "ticker": ticker]
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var highlight: Swift.Optional<String?> {
    get {
      return graphQLMap["highlight"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "highlight")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_obj_rel_insert_input?> ?? Swift.Optional<tickers_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// input type for inserting array relation for remote table "ticker_industries"
public struct ticker_industries_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [ticker_industries_insert_input], onConflict: Swift.Optional<ticker_industries_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [ticker_industries_insert_input] {
    get {
      return graphQLMap["data"] as! [ticker_industries_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<ticker_industries_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<ticker_industries_on_conflict?> ?? Swift.Optional<ticker_industries_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "ticker_industries"
public struct ticker_industries_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - gainyIndustry
  ///   - industryId
  ///   - symbol
  ///   - ticker
  public init(gainyIndustry: Swift.Optional<gainy_industries_obj_rel_insert_input?> = nil, industryId: Swift.Optional<Int?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil) {
    graphQLMap = ["gainy_industry": gainyIndustry, "industry_id": industryId, "symbol": symbol, "ticker": ticker]
  }

  public var gainyIndustry: Swift.Optional<gainy_industries_obj_rel_insert_input?> {
    get {
      return graphQLMap["gainy_industry"] as? Swift.Optional<gainy_industries_obj_rel_insert_input?> ?? Swift.Optional<gainy_industries_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gainy_industry")
    }
  }

  public var industryId: Swift.Optional<Int?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_obj_rel_insert_input?> ?? Swift.Optional<tickers_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// input type for inserting object relation for remote table "gainy_industries"
public struct gainy_industries_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: gainy_industries_insert_input, onConflict: Swift.Optional<gainy_industries_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: gainy_industries_insert_input {
    get {
      return graphQLMap["data"] as! gainy_industries_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<gainy_industries_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<gainy_industries_on_conflict?> ?? Swift.Optional<gainy_industries_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "gainy_industries"
public struct gainy_industries_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - industryStatsDailies
  ///   - industryStatsQuarterlies
  ///   - name
  ///   - tickerIndustries
  ///   - tickerIndustryMedian_1m
  ///   - tickerIndustryMedian_1w
  public init(id: Swift.Optional<Int?> = nil, industryStatsDailies: Swift.Optional<industry_stats_daily_arr_rel_insert_input?> = nil, industryStatsQuarterlies: Swift.Optional<industry_stats_quarterly_arr_rel_insert_input?> = nil, name: Swift.Optional<String?> = nil, tickerIndustries: Swift.Optional<ticker_industries_arr_rel_insert_input?> = nil, tickerIndustryMedian_1m: Swift.Optional<industry_median_1m_arr_rel_insert_input?> = nil, tickerIndustryMedian_1w: Swift.Optional<industry_median_1w_arr_rel_insert_input?> = nil) {
    graphQLMap = ["id": id, "industry_stats_dailies": industryStatsDailies, "industry_stats_quarterlies": industryStatsQuarterlies, "name": name, "ticker_industries": tickerIndustries, "ticker_industry_median_1m": tickerIndustryMedian_1m, "ticker_industry_median_1w": tickerIndustryMedian_1w]
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var industryStatsDailies: Swift.Optional<industry_stats_daily_arr_rel_insert_input?> {
    get {
      return graphQLMap["industry_stats_dailies"] as? Swift.Optional<industry_stats_daily_arr_rel_insert_input?> ?? Swift.Optional<industry_stats_daily_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_stats_dailies")
    }
  }

  public var industryStatsQuarterlies: Swift.Optional<industry_stats_quarterly_arr_rel_insert_input?> {
    get {
      return graphQLMap["industry_stats_quarterlies"] as? Swift.Optional<industry_stats_quarterly_arr_rel_insert_input?> ?? Swift.Optional<industry_stats_quarterly_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_stats_quarterlies")
    }
  }

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var tickerIndustries: Swift.Optional<ticker_industries_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_industries"] as? Swift.Optional<ticker_industries_arr_rel_insert_input?> ?? Swift.Optional<ticker_industries_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industries")
    }
  }

  public var tickerIndustryMedian_1m: Swift.Optional<industry_median_1m_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_industry_median_1m"] as? Swift.Optional<industry_median_1m_arr_rel_insert_input?> ?? Swift.Optional<industry_median_1m_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industry_median_1m")
    }
  }

  public var tickerIndustryMedian_1w: Swift.Optional<industry_median_1w_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_industry_median_1w"] as? Swift.Optional<industry_median_1w_arr_rel_insert_input?> ?? Swift.Optional<industry_median_1w_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industry_median_1w")
    }
  }
}

/// input type for inserting array relation for remote table "industry_stats_daily"
public struct industry_stats_daily_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [industry_stats_daily_insert_input], onConflict: Swift.Optional<industry_stats_daily_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [industry_stats_daily_insert_input] {
    get {
      return graphQLMap["data"] as! [industry_stats_daily_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<industry_stats_daily_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<industry_stats_daily_on_conflict?> ?? Swift.Optional<industry_stats_daily_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "industry_stats_daily"
public struct industry_stats_daily_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - id
  ///   - industryId
  ///   - medianGrowthRate_1d
  ///   - medianGrowthRate_1m
  ///   - medianGrowthRate_1w
  ///   - medianGrowthRate_1y
  ///   - medianGrowthRate_3m
  ///   - medianPrice
  public init(date: Swift.Optional<timestamp?> = nil, id: Swift.Optional<String?> = nil, industryId: Swift.Optional<Int?> = nil, medianGrowthRate_1d: Swift.Optional<float8?> = nil, medianGrowthRate_1m: Swift.Optional<float8?> = nil, medianGrowthRate_1w: Swift.Optional<float8?> = nil, medianGrowthRate_1y: Swift.Optional<float8?> = nil, medianGrowthRate_3m: Swift.Optional<float8?> = nil, medianPrice: Swift.Optional<float8?> = nil) {
    graphQLMap = ["date": date, "id": id, "industry_id": industryId, "median_growth_rate_1d": medianGrowthRate_1d, "median_growth_rate_1m": medianGrowthRate_1m, "median_growth_rate_1w": medianGrowthRate_1w, "median_growth_rate_1y": medianGrowthRate_1y, "median_growth_rate_3m": medianGrowthRate_3m, "median_price": medianPrice]
  }

  public var date: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var id: Swift.Optional<String?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var industryId: Swift.Optional<Int?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var medianGrowthRate_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_growth_rate_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_1d")
    }
  }

  public var medianGrowthRate_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_growth_rate_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_1m")
    }
  }

  public var medianGrowthRate_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_growth_rate_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_1w")
    }
  }

  public var medianGrowthRate_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_growth_rate_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_1y")
    }
  }

  public var medianGrowthRate_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_growth_rate_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate_3m")
    }
  }

  public var medianPrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_price")
    }
  }
}

/// on conflict condition type for table "industry_stats_daily"
public struct industry_stats_daily_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: industry_stats_daily_constraint, updateColumns: [industry_stats_daily_update_column], `where`: Swift.Optional<industry_stats_daily_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: industry_stats_daily_constraint {
    get {
      return graphQLMap["constraint"] as! industry_stats_daily_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [industry_stats_daily_update_column] {
    get {
      return graphQLMap["update_columns"] as! [industry_stats_daily_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<industry_stats_daily_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<industry_stats_daily_bool_exp?> ?? Swift.Optional<industry_stats_daily_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "industry_stats_daily"
public enum industry_stats_daily_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case industryStatsDailyUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "industry_stats_daily_unique_id": self = .industryStatsDailyUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .industryStatsDailyUniqueId: return "industry_stats_daily_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: industry_stats_daily_constraint, rhs: industry_stats_daily_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.industryStatsDailyUniqueId, .industryStatsDailyUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [industry_stats_daily_constraint] {
    return [
      .industryStatsDailyUniqueId,
    ]
  }
}

/// update columns of table "industry_stats_daily"
public enum industry_stats_daily_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case date
  /// column name
  case id
  /// column name
  case industryId
  /// column name
  case medianGrowthRate_1d
  /// column name
  case medianGrowthRate_1m
  /// column name
  case medianGrowthRate_1w
  /// column name
  case medianGrowthRate_1y
  /// column name
  case medianGrowthRate_3m
  /// column name
  case medianPrice
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "date": self = .date
      case "id": self = .id
      case "industry_id": self = .industryId
      case "median_growth_rate_1d": self = .medianGrowthRate_1d
      case "median_growth_rate_1m": self = .medianGrowthRate_1m
      case "median_growth_rate_1w": self = .medianGrowthRate_1w
      case "median_growth_rate_1y": self = .medianGrowthRate_1y
      case "median_growth_rate_3m": self = .medianGrowthRate_3m
      case "median_price": self = .medianPrice
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .date: return "date"
      case .id: return "id"
      case .industryId: return "industry_id"
      case .medianGrowthRate_1d: return "median_growth_rate_1d"
      case .medianGrowthRate_1m: return "median_growth_rate_1m"
      case .medianGrowthRate_1w: return "median_growth_rate_1w"
      case .medianGrowthRate_1y: return "median_growth_rate_1y"
      case .medianGrowthRate_3m: return "median_growth_rate_3m"
      case .medianPrice: return "median_price"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: industry_stats_daily_update_column, rhs: industry_stats_daily_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.date, .date): return true
      case (.id, .id): return true
      case (.industryId, .industryId): return true
      case (.medianGrowthRate_1d, .medianGrowthRate_1d): return true
      case (.medianGrowthRate_1m, .medianGrowthRate_1m): return true
      case (.medianGrowthRate_1w, .medianGrowthRate_1w): return true
      case (.medianGrowthRate_1y, .medianGrowthRate_1y): return true
      case (.medianGrowthRate_3m, .medianGrowthRate_3m): return true
      case (.medianPrice, .medianPrice): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [industry_stats_daily_update_column] {
    return [
      .date,
      .id,
      .industryId,
      .medianGrowthRate_1d,
      .medianGrowthRate_1m,
      .medianGrowthRate_1w,
      .medianGrowthRate_1y,
      .medianGrowthRate_3m,
      .medianPrice,
    ]
  }
}

/// input type for inserting array relation for remote table "industry_stats_quarterly"
public struct industry_stats_quarterly_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [industry_stats_quarterly_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [industry_stats_quarterly_insert_input] {
    get {
      return graphQLMap["data"] as! [industry_stats_quarterly_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "industry_stats_quarterly"
public struct industry_stats_quarterly_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - industryId
  ///   - medianNetIncome
  ///   - medianRevenue
  public init(date: Swift.Optional<timestamp?> = nil, industryId: Swift.Optional<Int?> = nil, medianNetIncome: Swift.Optional<float8?> = nil, medianRevenue: Swift.Optional<float8?> = nil) {
    graphQLMap = ["date": date, "industry_id": industryId, "median_net_income": medianNetIncome, "median_revenue": medianRevenue]
  }

  public var date: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var industryId: Swift.Optional<Int?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var medianNetIncome: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_net_income"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_net_income")
    }
  }

  public var medianRevenue: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_revenue"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_revenue")
    }
  }
}

/// input type for inserting array relation for remote table "industry_median_1m"
public struct industry_median_1m_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [industry_median_1m_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [industry_median_1m_insert_input] {
    get {
      return graphQLMap["data"] as! [industry_median_1m_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "industry_median_1m"
public struct industry_median_1m_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - industryId
  ///   - medianGrowthRate
  ///   - medianPrice
  public init(date: Swift.Optional<timestamp?> = nil, industryId: Swift.Optional<Int?> = nil, medianGrowthRate: Swift.Optional<float8?> = nil, medianPrice: Swift.Optional<float8?> = nil) {
    graphQLMap = ["date": date, "industry_id": industryId, "median_growth_rate": medianGrowthRate, "median_price": medianPrice]
  }

  public var date: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var industryId: Swift.Optional<Int?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var medianGrowthRate: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_growth_rate"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate")
    }
  }

  public var medianPrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_price")
    }
  }
}

/// input type for inserting array relation for remote table "industry_median_1w"
public struct industry_median_1w_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [industry_median_1w_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [industry_median_1w_insert_input] {
    get {
      return graphQLMap["data"] as! [industry_median_1w_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "industry_median_1w"
public struct industry_median_1w_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - industryId
  ///   - medianGrowthRate
  ///   - medianPrice
  public init(date: Swift.Optional<timestamp?> = nil, industryId: Swift.Optional<Int?> = nil, medianGrowthRate: Swift.Optional<float8?> = nil, medianPrice: Swift.Optional<float8?> = nil) {
    graphQLMap = ["date": date, "industry_id": industryId, "median_growth_rate": medianGrowthRate, "median_price": medianPrice]
  }

  public var date: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var industryId: Swift.Optional<Int?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var medianGrowthRate: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_growth_rate"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_growth_rate")
    }
  }

  public var medianPrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_price")
    }
  }
}

/// on conflict condition type for table "gainy_industries"
public struct gainy_industries_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: gainy_industries_constraint, updateColumns: [gainy_industries_update_column], `where`: Swift.Optional<gainy_industries_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: gainy_industries_constraint {
    get {
      return graphQLMap["constraint"] as! gainy_industries_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [gainy_industries_update_column] {
    get {
      return graphQLMap["update_columns"] as! [gainy_industries_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<gainy_industries_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<gainy_industries_bool_exp?> ?? Swift.Optional<gainy_industries_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "gainy_industries"
public enum gainy_industries_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case gainyIndustriesUniqueId
  /// unique or primary key constraint
  case gainyIndustriesUniqueName
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "gainy_industries_unique_id": self = .gainyIndustriesUniqueId
      case "gainy_industries_unique_name": self = .gainyIndustriesUniqueName
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .gainyIndustriesUniqueId: return "gainy_industries_unique_id"
      case .gainyIndustriesUniqueName: return "gainy_industries_unique_name"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: gainy_industries_constraint, rhs: gainy_industries_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.gainyIndustriesUniqueId, .gainyIndustriesUniqueId): return true
      case (.gainyIndustriesUniqueName, .gainyIndustriesUniqueName): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [gainy_industries_constraint] {
    return [
      .gainyIndustriesUniqueId,
      .gainyIndustriesUniqueName,
    ]
  }
}

/// update columns of table "gainy_industries"
public enum gainy_industries_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case id
  /// column name
  case name
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "id": self = .id
      case "name": self = .name
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .id: return "id"
      case .name: return "name"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: gainy_industries_update_column, rhs: gainy_industries_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.id, .id): return true
      case (.name, .name): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [gainy_industries_update_column] {
    return [
      .id,
      .name,
    ]
  }
}

/// on conflict condition type for table "ticker_industries"
public struct ticker_industries_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: ticker_industries_constraint, updateColumns: [ticker_industries_update_column], `where`: Swift.Optional<ticker_industries_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: ticker_industries_constraint {
    get {
      return graphQLMap["constraint"] as! ticker_industries_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [ticker_industries_update_column] {
    get {
      return graphQLMap["update_columns"] as! [ticker_industries_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<ticker_industries_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<ticker_industries_bool_exp?> ?? Swift.Optional<ticker_industries_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "ticker_industries"
public enum ticker_industries_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case publicTickerIndustriesIndustryIdSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_ticker_industries_industry_id__symbol": self = .publicTickerIndustriesIndustryIdSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicTickerIndustriesIndustryIdSymbol: return "public_ticker_industries_industry_id__symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_industries_constraint, rhs: ticker_industries_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicTickerIndustriesIndustryIdSymbol, .publicTickerIndustriesIndustryIdSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_industries_constraint] {
    return [
      .publicTickerIndustriesIndustryIdSymbol,
    ]
  }
}

/// update columns of table "ticker_industries"
public enum ticker_industries_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case industryId
  /// column name
  case symbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "industry_id": self = .industryId
      case "symbol": self = .symbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .industryId: return "industry_id"
      case .symbol: return "symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_industries_update_column, rhs: ticker_industries_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.industryId, .industryId): return true
      case (.symbol, .symbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_industries_update_column] {
    return [
      .industryId,
      .symbol,
    ]
  }
}

/// input type for inserting array relation for remote table "ticker_interests"
public struct ticker_interests_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [ticker_interests_insert_input], onConflict: Swift.Optional<ticker_interests_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [ticker_interests_insert_input] {
    get {
      return graphQLMap["data"] as! [ticker_interests_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<ticker_interests_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<ticker_interests_on_conflict?> ?? Swift.Optional<ticker_interests_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "ticker_interests"
public struct ticker_interests_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interest
  ///   - interestId
  ///   - symbol
  ///   - ticker
  public init(interest: Swift.Optional<interests_obj_rel_insert_input?> = nil, interestId: Swift.Optional<Int?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil) {
    graphQLMap = ["interest": interest, "interest_id": interestId, "symbol": symbol, "ticker": ticker]
  }

  public var interest: Swift.Optional<interests_obj_rel_insert_input?> {
    get {
      return graphQLMap["interest"] as? Swift.Optional<interests_obj_rel_insert_input?> ?? Swift.Optional<interests_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest")
    }
  }

  public var interestId: Swift.Optional<Int?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_obj_rel_insert_input?> ?? Swift.Optional<tickers_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// input type for inserting object relation for remote table "interests"
public struct interests_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: interests_insert_input, onConflict: Swift.Optional<interests_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: interests_insert_input {
    get {
      return graphQLMap["data"] as! interests_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<interests_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<interests_on_conflict?> ?? Swift.Optional<interests_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "interests"
public struct interests_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - enabled
  ///   - iconUrl
  ///   - id
  ///   - name
  ///   - tickerInterests
  public init(enabled: Swift.Optional<String?> = nil, iconUrl: Swift.Optional<String?> = nil, id: Swift.Optional<Int?> = nil, name: Swift.Optional<String?> = nil, tickerInterests: Swift.Optional<ticker_interests_arr_rel_insert_input?> = nil) {
    graphQLMap = ["enabled": enabled, "icon_url": iconUrl, "id": id, "name": name, "ticker_interests": tickerInterests]
  }

  public var enabled: Swift.Optional<String?> {
    get {
      return graphQLMap["enabled"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enabled")
    }
  }

  public var iconUrl: Swift.Optional<String?> {
    get {
      return graphQLMap["icon_url"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "icon_url")
    }
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var tickerInterests: Swift.Optional<ticker_interests_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_interests"] as? Swift.Optional<ticker_interests_arr_rel_insert_input?> ?? Swift.Optional<ticker_interests_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_interests")
    }
  }
}

/// on conflict condition type for table "interests"
public struct interests_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: interests_constraint, updateColumns: [interests_update_column], `where`: Swift.Optional<interests_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: interests_constraint {
    get {
      return graphQLMap["constraint"] as! interests_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [interests_update_column] {
    get {
      return graphQLMap["update_columns"] as! [interests_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<interests_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<interests_bool_exp?> ?? Swift.Optional<interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "interests"
public enum interests_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case interestsUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "interests_unique_id": self = .interestsUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .interestsUniqueId: return "interests_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: interests_constraint, rhs: interests_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.interestsUniqueId, .interestsUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [interests_constraint] {
    return [
      .interestsUniqueId,
    ]
  }
}

/// update columns of table "interests"
public enum interests_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case enabled
  /// column name
  case iconUrl
  /// column name
  case id
  /// column name
  case name
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "enabled": self = .enabled
      case "icon_url": self = .iconUrl
      case "id": self = .id
      case "name": self = .name
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .enabled: return "enabled"
      case .iconUrl: return "icon_url"
      case .id: return "id"
      case .name: return "name"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: interests_update_column, rhs: interests_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.enabled, .enabled): return true
      case (.iconUrl, .iconUrl): return true
      case (.id, .id): return true
      case (.name, .name): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [interests_update_column] {
    return [
      .enabled,
      .iconUrl,
      .id,
      .name,
    ]
  }
}

/// on conflict condition type for table "ticker_interests"
public struct ticker_interests_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: ticker_interests_constraint, updateColumns: [ticker_interests_update_column], `where`: Swift.Optional<ticker_interests_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: ticker_interests_constraint {
    get {
      return graphQLMap["constraint"] as! ticker_interests_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [ticker_interests_update_column] {
    get {
      return graphQLMap["update_columns"] as! [ticker_interests_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<ticker_interests_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<ticker_interests_bool_exp?> ?? Swift.Optional<ticker_interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "ticker_interests"
public enum ticker_interests_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case publicTickerInterestsSymbolInterestId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_ticker_interests_symbol__interest_id": self = .publicTickerInterestsSymbolInterestId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicTickerInterestsSymbolInterestId: return "public_ticker_interests_symbol__interest_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_interests_constraint, rhs: ticker_interests_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicTickerInterestsSymbolInterestId, .publicTickerInterestsSymbolInterestId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_interests_constraint] {
    return [
      .publicTickerInterestsSymbolInterestId,
    ]
  }
}

/// update columns of table "ticker_interests"
public enum ticker_interests_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case interestId
  /// column name
  case symbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "interest_id": self = .interestId
      case "symbol": self = .symbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .interestId: return "interest_id"
      case .symbol: return "symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_interests_update_column, rhs: ticker_interests_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.interestId, .interestId): return true
      case (.symbol, .symbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_interests_update_column] {
    return [
      .interestId,
      .symbol,
    ]
  }
}

/// input type for inserting object relation for remote table "ticker_metrics"
public struct ticker_metrics_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: ticker_metrics_insert_input, onConflict: Swift.Optional<ticker_metrics_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: ticker_metrics_insert_input {
    get {
      return graphQLMap["data"] as! ticker_metrics_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<ticker_metrics_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<ticker_metrics_on_conflict?> ?? Swift.Optional<ticker_metrics_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "ticker_metrics"
public struct ticker_metrics_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - absoluteHistoricalVolatilityAdjustedCurrent
  ///   - absoluteHistoricalVolatilityAdjustedMax_1y
  ///   - absoluteHistoricalVolatilityAdjustedMin_1y
  ///   - addressCity
  ///   - addressCounty
  ///   - addressFull
  ///   - addressState
  ///   - assetCashAndEquivalents
  ///   - avgVolume_10d
  ///   - avgVolume_90d
  ///   - beatenQuarterlyEpsEstimationCountTtm
  ///   - beta
  ///   - dividendFrequency
  ///   - dividendPayoutRatio
  ///   - dividendYield
  ///   - dividendsPerShare
  ///   - ebitda
  ///   - ebitdaGrowthYoy
  ///   - ebitdaTtm
  ///   - enterpriseValueToEbitda
  ///   - enterpriseValueToSales
  ///   - epsActual
  ///   - epsDifference
  ///   - epsEstimate
  ///   - epsGrowthFwd
  ///   - epsGrowthYoy
  ///   - epsSurprise
  ///   - exchangeName
  ///   - impliedVolatility
  ///   - marketCapitalization
  ///   - netDebt
  ///   - netIncome
  ///   - netIncomeTtm
  ///   - priceChange_1m
  ///   - priceChange_1y
  ///   - priceChange_3m
  ///   - priceToBookValue
  ///   - priceToEarningsTtm
  ///   - priceToSalesTtm
  ///   - profitMargin
  ///   - relativeHistoricalVolatilityAdjustedCurrent
  ///   - relativeHistoricalVolatilityAdjustedMax_1y
  ///   - relativeHistoricalVolatilityAdjustedMin_1y
  ///   - revenueActual
  ///   - revenueEstimateAvg_0y
  ///   - revenueGrowthFwd
  ///   - revenueGrowthYoy
  ///   - revenuePerShareTtm
  ///   - revenueTtm
  ///   - roa
  ///   - roi
  ///   - sharesFloat
  ///   - sharesOutstanding
  ///   - shortPercentOutstanding
  ///   - shortRatio
  ///   - symbol
  ///   - ticker
  ///   - totalAssets
  ///   - yearsOfConsecutiveDividendGrowth
  public init(absoluteHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8?> = nil, absoluteHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8?> = nil, absoluteHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8?> = nil, addressCity: Swift.Optional<String?> = nil, addressCounty: Swift.Optional<String?> = nil, addressFull: Swift.Optional<String?> = nil, addressState: Swift.Optional<String?> = nil, assetCashAndEquivalents: Swift.Optional<float8?> = nil, avgVolume_10d: Swift.Optional<float8?> = nil, avgVolume_90d: Swift.Optional<float8?> = nil, beatenQuarterlyEpsEstimationCountTtm: Swift.Optional<Int?> = nil, beta: Swift.Optional<float8?> = nil, dividendFrequency: Swift.Optional<String?> = nil, dividendPayoutRatio: Swift.Optional<float8?> = nil, dividendYield: Swift.Optional<float8?> = nil, dividendsPerShare: Swift.Optional<float8?> = nil, ebitda: Swift.Optional<float8?> = nil, ebitdaGrowthYoy: Swift.Optional<float8?> = nil, ebitdaTtm: Swift.Optional<float8?> = nil, enterpriseValueToEbitda: Swift.Optional<float8?> = nil, enterpriseValueToSales: Swift.Optional<float8?> = nil, epsActual: Swift.Optional<float8?> = nil, epsDifference: Swift.Optional<float8?> = nil, epsEstimate: Swift.Optional<float8?> = nil, epsGrowthFwd: Swift.Optional<float8?> = nil, epsGrowthYoy: Swift.Optional<float8?> = nil, epsSurprise: Swift.Optional<float8?> = nil, exchangeName: Swift.Optional<String?> = nil, impliedVolatility: Swift.Optional<float8?> = nil, marketCapitalization: Swift.Optional<bigint?> = nil, netDebt: Swift.Optional<float8?> = nil, netIncome: Swift.Optional<float8?> = nil, netIncomeTtm: Swift.Optional<float8?> = nil, priceChange_1m: Swift.Optional<float8?> = nil, priceChange_1y: Swift.Optional<float8?> = nil, priceChange_3m: Swift.Optional<float8?> = nil, priceToBookValue: Swift.Optional<float8?> = nil, priceToEarningsTtm: Swift.Optional<float8?> = nil, priceToSalesTtm: Swift.Optional<float8?> = nil, profitMargin: Swift.Optional<float8?> = nil, relativeHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8?> = nil, relativeHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8?> = nil, relativeHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8?> = nil, revenueActual: Swift.Optional<float8?> = nil, revenueEstimateAvg_0y: Swift.Optional<float8?> = nil, revenueGrowthFwd: Swift.Optional<float8?> = nil, revenueGrowthYoy: Swift.Optional<float8?> = nil, revenuePerShareTtm: Swift.Optional<float8?> = nil, revenueTtm: Swift.Optional<float8?> = nil, roa: Swift.Optional<float8?> = nil, roi: Swift.Optional<float8?> = nil, sharesFloat: Swift.Optional<bigint?> = nil, sharesOutstanding: Swift.Optional<bigint?> = nil, shortPercentOutstanding: Swift.Optional<float8?> = nil, shortRatio: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil, totalAssets: Swift.Optional<float8?> = nil, yearsOfConsecutiveDividendGrowth: Swift.Optional<Int?> = nil) {
    graphQLMap = ["absolute_historical_volatility_adjusted_current": absoluteHistoricalVolatilityAdjustedCurrent, "absolute_historical_volatility_adjusted_max_1y": absoluteHistoricalVolatilityAdjustedMax_1y, "absolute_historical_volatility_adjusted_min_1y": absoluteHistoricalVolatilityAdjustedMin_1y, "address_city": addressCity, "address_county": addressCounty, "address_full": addressFull, "address_state": addressState, "asset_cash_and_equivalents": assetCashAndEquivalents, "avg_volume_10d": avgVolume_10d, "avg_volume_90d": avgVolume_90d, "beaten_quarterly_eps_estimation_count_ttm": beatenQuarterlyEpsEstimationCountTtm, "beta": beta, "dividend_frequency": dividendFrequency, "dividend_payout_ratio": dividendPayoutRatio, "dividend_yield": dividendYield, "dividends_per_share": dividendsPerShare, "ebitda": ebitda, "ebitda_growth_yoy": ebitdaGrowthYoy, "ebitda_ttm": ebitdaTtm, "enterprise_value_to_ebitda": enterpriseValueToEbitda, "enterprise_value_to_sales": enterpriseValueToSales, "eps_actual": epsActual, "eps_difference": epsDifference, "eps_estimate": epsEstimate, "eps_growth_fwd": epsGrowthFwd, "eps_growth_yoy": epsGrowthYoy, "eps_surprise": epsSurprise, "exchange_name": exchangeName, "implied_volatility": impliedVolatility, "market_capitalization": marketCapitalization, "net_debt": netDebt, "net_income": netIncome, "net_income_ttm": netIncomeTtm, "price_change_1m": priceChange_1m, "price_change_1y": priceChange_1y, "price_change_3m": priceChange_3m, "price_to_book_value": priceToBookValue, "price_to_earnings_ttm": priceToEarningsTtm, "price_to_sales_ttm": priceToSalesTtm, "profit_margin": profitMargin, "relative_historical_volatility_adjusted_current": relativeHistoricalVolatilityAdjustedCurrent, "relative_historical_volatility_adjusted_max_1y": relativeHistoricalVolatilityAdjustedMax_1y, "relative_historical_volatility_adjusted_min_1y": relativeHistoricalVolatilityAdjustedMin_1y, "revenue_actual": revenueActual, "revenue_estimate_avg_0y": revenueEstimateAvg_0y, "revenue_growth_fwd": revenueGrowthFwd, "revenue_growth_yoy": revenueGrowthYoy, "revenue_per_share_ttm": revenuePerShareTtm, "revenue_ttm": revenueTtm, "roa": roa, "roi": roi, "shares_float": sharesFloat, "shares_outstanding": sharesOutstanding, "short_percent_outstanding": shortPercentOutstanding, "short_ratio": shortRatio, "symbol": symbol, "ticker": ticker, "total_assets": totalAssets, "years_of_consecutive_dividend_growth": yearsOfConsecutiveDividendGrowth]
  }

  public var absoluteHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_current"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_current")
    }
  }

  public var absoluteHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_max_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_max_1y")
    }
  }

  public var absoluteHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_min_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_min_1y")
    }
  }

  public var addressCity: Swift.Optional<String?> {
    get {
      return graphQLMap["address_city"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_city")
    }
  }

  public var addressCounty: Swift.Optional<String?> {
    get {
      return graphQLMap["address_county"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_county")
    }
  }

  public var addressFull: Swift.Optional<String?> {
    get {
      return graphQLMap["address_full"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_full")
    }
  }

  public var addressState: Swift.Optional<String?> {
    get {
      return graphQLMap["address_state"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_state")
    }
  }

  public var assetCashAndEquivalents: Swift.Optional<float8?> {
    get {
      return graphQLMap["asset_cash_and_equivalents"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "asset_cash_and_equivalents")
    }
  }

  public var avgVolume_10d: Swift.Optional<float8?> {
    get {
      return graphQLMap["avg_volume_10d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg_volume_10d")
    }
  }

  public var avgVolume_90d: Swift.Optional<float8?> {
    get {
      return graphQLMap["avg_volume_90d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg_volume_90d")
    }
  }

  public var beatenQuarterlyEpsEstimationCountTtm: Swift.Optional<Int?> {
    get {
      return graphQLMap["beaten_quarterly_eps_estimation_count_ttm"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beaten_quarterly_eps_estimation_count_ttm")
    }
  }

  public var beta: Swift.Optional<float8?> {
    get {
      return graphQLMap["beta"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beta")
    }
  }

  public var dividendFrequency: Swift.Optional<String?> {
    get {
      return graphQLMap["dividend_frequency"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_frequency")
    }
  }

  public var dividendPayoutRatio: Swift.Optional<float8?> {
    get {
      return graphQLMap["dividend_payout_ratio"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_payout_ratio")
    }
  }

  public var dividendYield: Swift.Optional<float8?> {
    get {
      return graphQLMap["dividend_yield"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_yield")
    }
  }

  public var dividendsPerShare: Swift.Optional<float8?> {
    get {
      return graphQLMap["dividends_per_share"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividends_per_share")
    }
  }

  public var ebitda: Swift.Optional<float8?> {
    get {
      return graphQLMap["ebitda"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda")
    }
  }

  public var ebitdaGrowthYoy: Swift.Optional<float8?> {
    get {
      return graphQLMap["ebitda_growth_yoy"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda_growth_yoy")
    }
  }

  public var ebitdaTtm: Swift.Optional<float8?> {
    get {
      return graphQLMap["ebitda_ttm"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda_ttm")
    }
  }

  public var enterpriseValueToEbitda: Swift.Optional<float8?> {
    get {
      return graphQLMap["enterprise_value_to_ebitda"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enterprise_value_to_ebitda")
    }
  }

  public var enterpriseValueToSales: Swift.Optional<float8?> {
    get {
      return graphQLMap["enterprise_value_to_sales"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enterprise_value_to_sales")
    }
  }

  public var epsActual: Swift.Optional<float8?> {
    get {
      return graphQLMap["eps_actual"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_actual")
    }
  }

  public var epsDifference: Swift.Optional<float8?> {
    get {
      return graphQLMap["eps_difference"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_difference")
    }
  }

  public var epsEstimate: Swift.Optional<float8?> {
    get {
      return graphQLMap["eps_estimate"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_estimate")
    }
  }

  public var epsGrowthFwd: Swift.Optional<float8?> {
    get {
      return graphQLMap["eps_growth_fwd"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_growth_fwd")
    }
  }

  public var epsGrowthYoy: Swift.Optional<float8?> {
    get {
      return graphQLMap["eps_growth_yoy"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_growth_yoy")
    }
  }

  public var epsSurprise: Swift.Optional<float8?> {
    get {
      return graphQLMap["eps_surprise"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_surprise")
    }
  }

  public var exchangeName: Swift.Optional<String?> {
    get {
      return graphQLMap["exchange_name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange_name")
    }
  }

  public var impliedVolatility: Swift.Optional<float8?> {
    get {
      return graphQLMap["implied_volatility"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "implied_volatility")
    }
  }

  public var marketCapitalization: Swift.Optional<bigint?> {
    get {
      return graphQLMap["market_capitalization"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capitalization")
    }
  }

  public var netDebt: Swift.Optional<float8?> {
    get {
      return graphQLMap["net_debt"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_debt")
    }
  }

  public var netIncome: Swift.Optional<float8?> {
    get {
      return graphQLMap["net_income"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_income")
    }
  }

  public var netIncomeTtm: Swift.Optional<float8?> {
    get {
      return graphQLMap["net_income_ttm"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_income_ttm")
    }
  }

  public var priceChange_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1m")
    }
  }

  public var priceChange_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1y")
    }
  }

  public var priceChange_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_3m")
    }
  }

  public var priceToBookValue: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_to_book_value"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_book_value")
    }
  }

  public var priceToEarningsTtm: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_to_earnings_ttm"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_earnings_ttm")
    }
  }

  public var priceToSalesTtm: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_to_sales_ttm"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_sales_ttm")
    }
  }

  public var profitMargin: Swift.Optional<float8?> {
    get {
      return graphQLMap["profit_margin"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profit_margin")
    }
  }

  public var relativeHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_current"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_current")
    }
  }

  public var relativeHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_max_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_max_1y")
    }
  }

  public var relativeHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_min_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_min_1y")
    }
  }

  public var revenueActual: Swift.Optional<float8?> {
    get {
      return graphQLMap["revenue_actual"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_actual")
    }
  }

  public var revenueEstimateAvg_0y: Swift.Optional<float8?> {
    get {
      return graphQLMap["revenue_estimate_avg_0y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_estimate_avg_0y")
    }
  }

  public var revenueGrowthFwd: Swift.Optional<float8?> {
    get {
      return graphQLMap["revenue_growth_fwd"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_growth_fwd")
    }
  }

  public var revenueGrowthYoy: Swift.Optional<float8?> {
    get {
      return graphQLMap["revenue_growth_yoy"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_growth_yoy")
    }
  }

  public var revenuePerShareTtm: Swift.Optional<float8?> {
    get {
      return graphQLMap["revenue_per_share_ttm"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_per_share_ttm")
    }
  }

  public var revenueTtm: Swift.Optional<float8?> {
    get {
      return graphQLMap["revenue_ttm"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_ttm")
    }
  }

  public var roa: Swift.Optional<float8?> {
    get {
      return graphQLMap["roa"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "roa")
    }
  }

  public var roi: Swift.Optional<float8?> {
    get {
      return graphQLMap["roi"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "roi")
    }
  }

  public var sharesFloat: Swift.Optional<bigint?> {
    get {
      return graphQLMap["shares_float"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "shares_float")
    }
  }

  public var sharesOutstanding: Swift.Optional<bigint?> {
    get {
      return graphQLMap["shares_outstanding"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "shares_outstanding")
    }
  }

  public var shortPercentOutstanding: Swift.Optional<float8?> {
    get {
      return graphQLMap["short_percent_outstanding"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_percent_outstanding")
    }
  }

  public var shortRatio: Swift.Optional<float8?> {
    get {
      return graphQLMap["short_ratio"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_ratio")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_obj_rel_insert_input?> ?? Swift.Optional<tickers_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }

  public var totalAssets: Swift.Optional<float8?> {
    get {
      return graphQLMap["total_assets"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "total_assets")
    }
  }

  public var yearsOfConsecutiveDividendGrowth: Swift.Optional<Int?> {
    get {
      return graphQLMap["years_of_consecutive_dividend_growth"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "years_of_consecutive_dividend_growth")
    }
  }
}

/// on conflict condition type for table "ticker_metrics"
public struct ticker_metrics_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: ticker_metrics_constraint, updateColumns: [ticker_metrics_update_column], `where`: Swift.Optional<ticker_metrics_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: ticker_metrics_constraint {
    get {
      return graphQLMap["constraint"] as! ticker_metrics_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [ticker_metrics_update_column] {
    get {
      return graphQLMap["update_columns"] as! [ticker_metrics_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<ticker_metrics_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<ticker_metrics_bool_exp?> ?? Swift.Optional<ticker_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "ticker_metrics"
public enum ticker_metrics_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case tickerMetricsUniqueSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ticker_metrics_unique_symbol": self = .tickerMetricsUniqueSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .tickerMetricsUniqueSymbol: return "ticker_metrics_unique_symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_metrics_constraint, rhs: ticker_metrics_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.tickerMetricsUniqueSymbol, .tickerMetricsUniqueSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_metrics_constraint] {
    return [
      .tickerMetricsUniqueSymbol,
    ]
  }
}

/// update columns of table "ticker_metrics"
public enum ticker_metrics_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case absoluteHistoricalVolatilityAdjustedCurrent
  /// column name
  case absoluteHistoricalVolatilityAdjustedMax_1y
  /// column name
  case absoluteHistoricalVolatilityAdjustedMin_1y
  /// column name
  case addressCity
  /// column name
  case addressCounty
  /// column name
  case addressFull
  /// column name
  case addressState
  /// column name
  case assetCashAndEquivalents
  /// column name
  case avgVolume_10d
  /// column name
  case avgVolume_90d
  /// column name
  case beatenQuarterlyEpsEstimationCountTtm
  /// column name
  case beta
  /// column name
  case dividendFrequency
  /// column name
  case dividendPayoutRatio
  /// column name
  case dividendYield
  /// column name
  case dividendsPerShare
  /// column name
  case ebitda
  /// column name
  case ebitdaGrowthYoy
  /// column name
  case ebitdaTtm
  /// column name
  case enterpriseValueToEbitda
  /// column name
  case enterpriseValueToSales
  /// column name
  case epsActual
  /// column name
  case epsDifference
  /// column name
  case epsEstimate
  /// column name
  case epsGrowthFwd
  /// column name
  case epsGrowthYoy
  /// column name
  case epsSurprise
  /// column name
  case exchangeName
  /// column name
  case impliedVolatility
  /// column name
  case marketCapitalization
  /// column name
  case netDebt
  /// column name
  case netIncome
  /// column name
  case netIncomeTtm
  /// column name
  case priceChange_1m
  /// column name
  case priceChange_1y
  /// column name
  case priceChange_3m
  /// column name
  case priceToBookValue
  /// column name
  case priceToEarningsTtm
  /// column name
  case priceToSalesTtm
  /// column name
  case profitMargin
  /// column name
  case relativeHistoricalVolatilityAdjustedCurrent
  /// column name
  case relativeHistoricalVolatilityAdjustedMax_1y
  /// column name
  case relativeHistoricalVolatilityAdjustedMin_1y
  /// column name
  case revenueActual
  /// column name
  case revenueEstimateAvg_0y
  /// column name
  case revenueGrowthFwd
  /// column name
  case revenueGrowthYoy
  /// column name
  case revenuePerShareTtm
  /// column name
  case revenueTtm
  /// column name
  case roa
  /// column name
  case roi
  /// column name
  case sharesFloat
  /// column name
  case sharesOutstanding
  /// column name
  case shortPercentOutstanding
  /// column name
  case shortRatio
  /// column name
  case symbol
  /// column name
  case totalAssets
  /// column name
  case yearsOfConsecutiveDividendGrowth
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "absolute_historical_volatility_adjusted_current": self = .absoluteHistoricalVolatilityAdjustedCurrent
      case "absolute_historical_volatility_adjusted_max_1y": self = .absoluteHistoricalVolatilityAdjustedMax_1y
      case "absolute_historical_volatility_adjusted_min_1y": self = .absoluteHistoricalVolatilityAdjustedMin_1y
      case "address_city": self = .addressCity
      case "address_county": self = .addressCounty
      case "address_full": self = .addressFull
      case "address_state": self = .addressState
      case "asset_cash_and_equivalents": self = .assetCashAndEquivalents
      case "avg_volume_10d": self = .avgVolume_10d
      case "avg_volume_90d": self = .avgVolume_90d
      case "beaten_quarterly_eps_estimation_count_ttm": self = .beatenQuarterlyEpsEstimationCountTtm
      case "beta": self = .beta
      case "dividend_frequency": self = .dividendFrequency
      case "dividend_payout_ratio": self = .dividendPayoutRatio
      case "dividend_yield": self = .dividendYield
      case "dividends_per_share": self = .dividendsPerShare
      case "ebitda": self = .ebitda
      case "ebitda_growth_yoy": self = .ebitdaGrowthYoy
      case "ebitda_ttm": self = .ebitdaTtm
      case "enterprise_value_to_ebitda": self = .enterpriseValueToEbitda
      case "enterprise_value_to_sales": self = .enterpriseValueToSales
      case "eps_actual": self = .epsActual
      case "eps_difference": self = .epsDifference
      case "eps_estimate": self = .epsEstimate
      case "eps_growth_fwd": self = .epsGrowthFwd
      case "eps_growth_yoy": self = .epsGrowthYoy
      case "eps_surprise": self = .epsSurprise
      case "exchange_name": self = .exchangeName
      case "implied_volatility": self = .impliedVolatility
      case "market_capitalization": self = .marketCapitalization
      case "net_debt": self = .netDebt
      case "net_income": self = .netIncome
      case "net_income_ttm": self = .netIncomeTtm
      case "price_change_1m": self = .priceChange_1m
      case "price_change_1y": self = .priceChange_1y
      case "price_change_3m": self = .priceChange_3m
      case "price_to_book_value": self = .priceToBookValue
      case "price_to_earnings_ttm": self = .priceToEarningsTtm
      case "price_to_sales_ttm": self = .priceToSalesTtm
      case "profit_margin": self = .profitMargin
      case "relative_historical_volatility_adjusted_current": self = .relativeHistoricalVolatilityAdjustedCurrent
      case "relative_historical_volatility_adjusted_max_1y": self = .relativeHistoricalVolatilityAdjustedMax_1y
      case "relative_historical_volatility_adjusted_min_1y": self = .relativeHistoricalVolatilityAdjustedMin_1y
      case "revenue_actual": self = .revenueActual
      case "revenue_estimate_avg_0y": self = .revenueEstimateAvg_0y
      case "revenue_growth_fwd": self = .revenueGrowthFwd
      case "revenue_growth_yoy": self = .revenueGrowthYoy
      case "revenue_per_share_ttm": self = .revenuePerShareTtm
      case "revenue_ttm": self = .revenueTtm
      case "roa": self = .roa
      case "roi": self = .roi
      case "shares_float": self = .sharesFloat
      case "shares_outstanding": self = .sharesOutstanding
      case "short_percent_outstanding": self = .shortPercentOutstanding
      case "short_ratio": self = .shortRatio
      case "symbol": self = .symbol
      case "total_assets": self = .totalAssets
      case "years_of_consecutive_dividend_growth": self = .yearsOfConsecutiveDividendGrowth
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .absoluteHistoricalVolatilityAdjustedCurrent: return "absolute_historical_volatility_adjusted_current"
      case .absoluteHistoricalVolatilityAdjustedMax_1y: return "absolute_historical_volatility_adjusted_max_1y"
      case .absoluteHistoricalVolatilityAdjustedMin_1y: return "absolute_historical_volatility_adjusted_min_1y"
      case .addressCity: return "address_city"
      case .addressCounty: return "address_county"
      case .addressFull: return "address_full"
      case .addressState: return "address_state"
      case .assetCashAndEquivalents: return "asset_cash_and_equivalents"
      case .avgVolume_10d: return "avg_volume_10d"
      case .avgVolume_90d: return "avg_volume_90d"
      case .beatenQuarterlyEpsEstimationCountTtm: return "beaten_quarterly_eps_estimation_count_ttm"
      case .beta: return "beta"
      case .dividendFrequency: return "dividend_frequency"
      case .dividendPayoutRatio: return "dividend_payout_ratio"
      case .dividendYield: return "dividend_yield"
      case .dividendsPerShare: return "dividends_per_share"
      case .ebitda: return "ebitda"
      case .ebitdaGrowthYoy: return "ebitda_growth_yoy"
      case .ebitdaTtm: return "ebitda_ttm"
      case .enterpriseValueToEbitda: return "enterprise_value_to_ebitda"
      case .enterpriseValueToSales: return "enterprise_value_to_sales"
      case .epsActual: return "eps_actual"
      case .epsDifference: return "eps_difference"
      case .epsEstimate: return "eps_estimate"
      case .epsGrowthFwd: return "eps_growth_fwd"
      case .epsGrowthYoy: return "eps_growth_yoy"
      case .epsSurprise: return "eps_surprise"
      case .exchangeName: return "exchange_name"
      case .impliedVolatility: return "implied_volatility"
      case .marketCapitalization: return "market_capitalization"
      case .netDebt: return "net_debt"
      case .netIncome: return "net_income"
      case .netIncomeTtm: return "net_income_ttm"
      case .priceChange_1m: return "price_change_1m"
      case .priceChange_1y: return "price_change_1y"
      case .priceChange_3m: return "price_change_3m"
      case .priceToBookValue: return "price_to_book_value"
      case .priceToEarningsTtm: return "price_to_earnings_ttm"
      case .priceToSalesTtm: return "price_to_sales_ttm"
      case .profitMargin: return "profit_margin"
      case .relativeHistoricalVolatilityAdjustedCurrent: return "relative_historical_volatility_adjusted_current"
      case .relativeHistoricalVolatilityAdjustedMax_1y: return "relative_historical_volatility_adjusted_max_1y"
      case .relativeHistoricalVolatilityAdjustedMin_1y: return "relative_historical_volatility_adjusted_min_1y"
      case .revenueActual: return "revenue_actual"
      case .revenueEstimateAvg_0y: return "revenue_estimate_avg_0y"
      case .revenueGrowthFwd: return "revenue_growth_fwd"
      case .revenueGrowthYoy: return "revenue_growth_yoy"
      case .revenuePerShareTtm: return "revenue_per_share_ttm"
      case .revenueTtm: return "revenue_ttm"
      case .roa: return "roa"
      case .roi: return "roi"
      case .sharesFloat: return "shares_float"
      case .sharesOutstanding: return "shares_outstanding"
      case .shortPercentOutstanding: return "short_percent_outstanding"
      case .shortRatio: return "short_ratio"
      case .symbol: return "symbol"
      case .totalAssets: return "total_assets"
      case .yearsOfConsecutiveDividendGrowth: return "years_of_consecutive_dividend_growth"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_metrics_update_column, rhs: ticker_metrics_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.absoluteHistoricalVolatilityAdjustedCurrent, .absoluteHistoricalVolatilityAdjustedCurrent): return true
      case (.absoluteHistoricalVolatilityAdjustedMax_1y, .absoluteHistoricalVolatilityAdjustedMax_1y): return true
      case (.absoluteHistoricalVolatilityAdjustedMin_1y, .absoluteHistoricalVolatilityAdjustedMin_1y): return true
      case (.addressCity, .addressCity): return true
      case (.addressCounty, .addressCounty): return true
      case (.addressFull, .addressFull): return true
      case (.addressState, .addressState): return true
      case (.assetCashAndEquivalents, .assetCashAndEquivalents): return true
      case (.avgVolume_10d, .avgVolume_10d): return true
      case (.avgVolume_90d, .avgVolume_90d): return true
      case (.beatenQuarterlyEpsEstimationCountTtm, .beatenQuarterlyEpsEstimationCountTtm): return true
      case (.beta, .beta): return true
      case (.dividendFrequency, .dividendFrequency): return true
      case (.dividendPayoutRatio, .dividendPayoutRatio): return true
      case (.dividendYield, .dividendYield): return true
      case (.dividendsPerShare, .dividendsPerShare): return true
      case (.ebitda, .ebitda): return true
      case (.ebitdaGrowthYoy, .ebitdaGrowthYoy): return true
      case (.ebitdaTtm, .ebitdaTtm): return true
      case (.enterpriseValueToEbitda, .enterpriseValueToEbitda): return true
      case (.enterpriseValueToSales, .enterpriseValueToSales): return true
      case (.epsActual, .epsActual): return true
      case (.epsDifference, .epsDifference): return true
      case (.epsEstimate, .epsEstimate): return true
      case (.epsGrowthFwd, .epsGrowthFwd): return true
      case (.epsGrowthYoy, .epsGrowthYoy): return true
      case (.epsSurprise, .epsSurprise): return true
      case (.exchangeName, .exchangeName): return true
      case (.impliedVolatility, .impliedVolatility): return true
      case (.marketCapitalization, .marketCapitalization): return true
      case (.netDebt, .netDebt): return true
      case (.netIncome, .netIncome): return true
      case (.netIncomeTtm, .netIncomeTtm): return true
      case (.priceChange_1m, .priceChange_1m): return true
      case (.priceChange_1y, .priceChange_1y): return true
      case (.priceChange_3m, .priceChange_3m): return true
      case (.priceToBookValue, .priceToBookValue): return true
      case (.priceToEarningsTtm, .priceToEarningsTtm): return true
      case (.priceToSalesTtm, .priceToSalesTtm): return true
      case (.profitMargin, .profitMargin): return true
      case (.relativeHistoricalVolatilityAdjustedCurrent, .relativeHistoricalVolatilityAdjustedCurrent): return true
      case (.relativeHistoricalVolatilityAdjustedMax_1y, .relativeHistoricalVolatilityAdjustedMax_1y): return true
      case (.relativeHistoricalVolatilityAdjustedMin_1y, .relativeHistoricalVolatilityAdjustedMin_1y): return true
      case (.revenueActual, .revenueActual): return true
      case (.revenueEstimateAvg_0y, .revenueEstimateAvg_0y): return true
      case (.revenueGrowthFwd, .revenueGrowthFwd): return true
      case (.revenueGrowthYoy, .revenueGrowthYoy): return true
      case (.revenuePerShareTtm, .revenuePerShareTtm): return true
      case (.revenueTtm, .revenueTtm): return true
      case (.roa, .roa): return true
      case (.roi, .roi): return true
      case (.sharesFloat, .sharesFloat): return true
      case (.sharesOutstanding, .sharesOutstanding): return true
      case (.shortPercentOutstanding, .shortPercentOutstanding): return true
      case (.shortRatio, .shortRatio): return true
      case (.symbol, .symbol): return true
      case (.totalAssets, .totalAssets): return true
      case (.yearsOfConsecutiveDividendGrowth, .yearsOfConsecutiveDividendGrowth): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_metrics_update_column] {
    return [
      .absoluteHistoricalVolatilityAdjustedCurrent,
      .absoluteHistoricalVolatilityAdjustedMax_1y,
      .absoluteHistoricalVolatilityAdjustedMin_1y,
      .addressCity,
      .addressCounty,
      .addressFull,
      .addressState,
      .assetCashAndEquivalents,
      .avgVolume_10d,
      .avgVolume_90d,
      .beatenQuarterlyEpsEstimationCountTtm,
      .beta,
      .dividendFrequency,
      .dividendPayoutRatio,
      .dividendYield,
      .dividendsPerShare,
      .ebitda,
      .ebitdaGrowthYoy,
      .ebitdaTtm,
      .enterpriseValueToEbitda,
      .enterpriseValueToSales,
      .epsActual,
      .epsDifference,
      .epsEstimate,
      .epsGrowthFwd,
      .epsGrowthYoy,
      .epsSurprise,
      .exchangeName,
      .impliedVolatility,
      .marketCapitalization,
      .netDebt,
      .netIncome,
      .netIncomeTtm,
      .priceChange_1m,
      .priceChange_1y,
      .priceChange_3m,
      .priceToBookValue,
      .priceToEarningsTtm,
      .priceToSalesTtm,
      .profitMargin,
      .relativeHistoricalVolatilityAdjustedCurrent,
      .relativeHistoricalVolatilityAdjustedMax_1y,
      .relativeHistoricalVolatilityAdjustedMin_1y,
      .revenueActual,
      .revenueEstimateAvg_0y,
      .revenueGrowthFwd,
      .revenueGrowthYoy,
      .revenuePerShareTtm,
      .revenueTtm,
      .roa,
      .roi,
      .sharesFloat,
      .sharesOutstanding,
      .shortPercentOutstanding,
      .shortRatio,
      .symbol,
      .totalAssets,
      .yearsOfConsecutiveDividendGrowth,
    ]
  }
}

/// on conflict condition type for table "tickers"
public struct tickers_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: tickers_constraint, updateColumns: [tickers_update_column], `where`: Swift.Optional<tickers_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: tickers_constraint {
    get {
      return graphQLMap["constraint"] as! tickers_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [tickers_update_column] {
    get {
      return graphQLMap["update_columns"] as! [tickers_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "tickers"
public enum tickers_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case tickersUniqueSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "tickers_unique_symbol": self = .tickersUniqueSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .tickersUniqueSymbol: return "tickers_unique_symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: tickers_constraint, rhs: tickers_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.tickersUniqueSymbol, .tickersUniqueSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [tickers_constraint] {
    return [
      .tickersUniqueSymbol,
    ]
  }
}

/// update columns of table "tickers"
public enum tickers_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case countryName
  /// column name
  case description
  /// column name
  case gicGroup
  /// column name
  case gicIndustry
  /// column name
  case gicSector
  /// column name
  case gicSubIndustry
  /// column name
  case industry
  /// column name
  case ipoDate
  /// column name
  case logoUrl
  /// column name
  case name
  /// column name
  case phone
  /// column name
  case sector
  /// column name
  case symbol
  /// column name
  case type
  /// column name
  case updatedAt
  /// column name
  case webUrl
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "country_name": self = .countryName
      case "description": self = .description
      case "gic_group": self = .gicGroup
      case "gic_industry": self = .gicIndustry
      case "gic_sector": self = .gicSector
      case "gic_sub_industry": self = .gicSubIndustry
      case "industry": self = .industry
      case "ipo_date": self = .ipoDate
      case "logo_url": self = .logoUrl
      case "name": self = .name
      case "phone": self = .phone
      case "sector": self = .sector
      case "symbol": self = .symbol
      case "type": self = .type
      case "updated_at": self = .updatedAt
      case "web_url": self = .webUrl
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .countryName: return "country_name"
      case .description: return "description"
      case .gicGroup: return "gic_group"
      case .gicIndustry: return "gic_industry"
      case .gicSector: return "gic_sector"
      case .gicSubIndustry: return "gic_sub_industry"
      case .industry: return "industry"
      case .ipoDate: return "ipo_date"
      case .logoUrl: return "logo_url"
      case .name: return "name"
      case .phone: return "phone"
      case .sector: return "sector"
      case .symbol: return "symbol"
      case .type: return "type"
      case .updatedAt: return "updated_at"
      case .webUrl: return "web_url"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: tickers_update_column, rhs: tickers_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.countryName, .countryName): return true
      case (.description, .description): return true
      case (.gicGroup, .gicGroup): return true
      case (.gicIndustry, .gicIndustry): return true
      case (.gicSector, .gicSector): return true
      case (.gicSubIndustry, .gicSubIndustry): return true
      case (.industry, .industry): return true
      case (.ipoDate, .ipoDate): return true
      case (.logoUrl, .logoUrl): return true
      case (.name, .name): return true
      case (.phone, .phone): return true
      case (.sector, .sector): return true
      case (.symbol, .symbol): return true
      case (.type, .type): return true
      case (.updatedAt, .updatedAt): return true
      case (.webUrl, .webUrl): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [tickers_update_column] {
    return [
      .countryName,
      .description,
      .gicGroup,
      .gicIndustry,
      .gicSector,
      .gicSubIndustry,
      .industry,
      .ipoDate,
      .logoUrl,
      .name,
      .phone,
      .sector,
      .symbol,
      .type,
      .updatedAt,
      .webUrl,
    ]
  }
}

/// on conflict condition type for table "portfolio_holding_details"
public struct portfolio_holding_details_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: portfolio_holding_details_constraint, updateColumns: [portfolio_holding_details_update_column], `where`: Swift.Optional<portfolio_holding_details_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: portfolio_holding_details_constraint {
    get {
      return graphQLMap["constraint"] as! portfolio_holding_details_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [portfolio_holding_details_update_column] {
    get {
      return graphQLMap["update_columns"] as! [portfolio_holding_details_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<portfolio_holding_details_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<portfolio_holding_details_bool_exp?> ?? Swift.Optional<portfolio_holding_details_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "portfolio_holding_details"
public enum portfolio_holding_details_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case portfolioHoldingDetailsUniqueHoldingId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "portfolio_holding_details_unique_holding_id": self = .portfolioHoldingDetailsUniqueHoldingId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .portfolioHoldingDetailsUniqueHoldingId: return "portfolio_holding_details_unique_holding_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: portfolio_holding_details_constraint, rhs: portfolio_holding_details_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.portfolioHoldingDetailsUniqueHoldingId, .portfolioHoldingDetailsUniqueHoldingId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [portfolio_holding_details_constraint] {
    return [
      .portfolioHoldingDetailsUniqueHoldingId,
    ]
  }
}

/// update columns of table "portfolio_holding_details"
public enum portfolio_holding_details_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case accountId
  /// column name
  case holdingId
  /// column name
  case lttQuantityTotal
  /// column name
  case marketCapitalization
  /// column name
  case nextEarningsDate
  /// column name
  case purchaseDate
  /// column name
  case relativeGain_1d
  /// column name
  case relativeGainTotal
  /// column name
  case securityType
  /// column name
  case tickerName
  /// column name
  case tickerSymbol
  /// column name
  case valueToPortfolioValue
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "account_id": self = .accountId
      case "holding_id": self = .holdingId
      case "ltt_quantity_total": self = .lttQuantityTotal
      case "market_capitalization": self = .marketCapitalization
      case "next_earnings_date": self = .nextEarningsDate
      case "purchase_date": self = .purchaseDate
      case "relative_gain_1d": self = .relativeGain_1d
      case "relative_gain_total": self = .relativeGainTotal
      case "security_type": self = .securityType
      case "ticker_name": self = .tickerName
      case "ticker_symbol": self = .tickerSymbol
      case "value_to_portfolio_value": self = .valueToPortfolioValue
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .accountId: return "account_id"
      case .holdingId: return "holding_id"
      case .lttQuantityTotal: return "ltt_quantity_total"
      case .marketCapitalization: return "market_capitalization"
      case .nextEarningsDate: return "next_earnings_date"
      case .purchaseDate: return "purchase_date"
      case .relativeGain_1d: return "relative_gain_1d"
      case .relativeGainTotal: return "relative_gain_total"
      case .securityType: return "security_type"
      case .tickerName: return "ticker_name"
      case .tickerSymbol: return "ticker_symbol"
      case .valueToPortfolioValue: return "value_to_portfolio_value"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: portfolio_holding_details_update_column, rhs: portfolio_holding_details_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.accountId, .accountId): return true
      case (.holdingId, .holdingId): return true
      case (.lttQuantityTotal, .lttQuantityTotal): return true
      case (.marketCapitalization, .marketCapitalization): return true
      case (.nextEarningsDate, .nextEarningsDate): return true
      case (.purchaseDate, .purchaseDate): return true
      case (.relativeGain_1d, .relativeGain_1d): return true
      case (.relativeGainTotal, .relativeGainTotal): return true
      case (.securityType, .securityType): return true
      case (.tickerName, .tickerName): return true
      case (.tickerSymbol, .tickerSymbol): return true
      case (.valueToPortfolioValue, .valueToPortfolioValue): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [portfolio_holding_details_update_column] {
    return [
      .accountId,
      .holdingId,
      .lttQuantityTotal,
      .marketCapitalization,
      .nextEarningsDate,
      .purchaseDate,
      .relativeGain_1d,
      .relativeGainTotal,
      .securityType,
      .tickerName,
      .tickerSymbol,
      .valueToPortfolioValue,
    ]
  }
}

/// input type for inserting array relation for remote table "app.profile_portfolio_transactions"
public struct app_profile_portfolio_transactions_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [app_profile_portfolio_transactions_insert_input], onConflict: Swift.Optional<app_profile_portfolio_transactions_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [app_profile_portfolio_transactions_insert_input] {
    get {
      return graphQLMap["data"] as! [app_profile_portfolio_transactions_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_portfolio_transactions_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_portfolio_transactions_on_conflict?> ?? Swift.Optional<app_profile_portfolio_transactions_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_portfolio_transactions"
public struct app_profile_portfolio_transactions_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - account
  ///   - accountId
  ///   - amount
  ///   - createdAt
  ///   - date
  ///   - fees
  ///   - id
  ///   - isoCurrencyCode
  ///   - name
  ///   - plaidAccessTokenId
  ///   - portfolioTransactionGains
  ///   - price
  ///   - profile
  ///   - profileId
  ///   - quantity
  ///   - refId
  ///   - security
  ///   - securityId
  ///   - subtype
  ///   - type
  ///   - updatedAt
  public init(account: Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> = nil, accountId: Swift.Optional<Int?> = nil, amount: Swift.Optional<float8?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, date: Swift.Optional<date?> = nil, fees: Swift.Optional<float8?> = nil, id: Swift.Optional<Int?> = nil, isoCurrencyCode: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, plaidAccessTokenId: Swift.Optional<Int?> = nil, portfolioTransactionGains: Swift.Optional<portfolio_transaction_gains_obj_rel_insert_input?> = nil, price: Swift.Optional<float8?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, quantity: Swift.Optional<float8?> = nil, refId: Swift.Optional<String?> = nil, security: Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> = nil, securityId: Swift.Optional<Int?> = nil, subtype: Swift.Optional<String?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["account": account, "account_id": accountId, "amount": amount, "created_at": createdAt, "date": date, "fees": fees, "id": id, "iso_currency_code": isoCurrencyCode, "name": name, "plaid_access_token_id": plaidAccessTokenId, "portfolio_transaction_gains": portfolioTransactionGains, "price": price, "profile": profile, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "subtype": subtype, "type": type, "updated_at": updatedAt]
  }

  public var account: Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> {
    get {
      return graphQLMap["account"] as? Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> ?? Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account")
    }
  }

  public var accountId: Swift.Optional<Int?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var amount: Swift.Optional<float8?> {
    get {
      return graphQLMap["amount"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "amount")
    }
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var date: Swift.Optional<date?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var fees: Swift.Optional<float8?> {
    get {
      return graphQLMap["fees"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fees")
    }
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var isoCurrencyCode: Swift.Optional<String?> {
    get {
      return graphQLMap["iso_currency_code"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "iso_currency_code")
    }
  }

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<Int?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var portfolioTransactionGains: Swift.Optional<portfolio_transaction_gains_obj_rel_insert_input?> {
    get {
      return graphQLMap["portfolio_transaction_gains"] as? Swift.Optional<portfolio_transaction_gains_obj_rel_insert_input?> ?? Swift.Optional<portfolio_transaction_gains_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_transaction_gains")
    }
  }

  public var price: Swift.Optional<float8?> {
    get {
      return graphQLMap["price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<float8?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var refId: Swift.Optional<String?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var security: Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> {
    get {
      return graphQLMap["security"] as? Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> ?? Swift.Optional<app_portfolio_securities_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security")
    }
  }

  public var securityId: Swift.Optional<Int?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }

  public var subtype: Swift.Optional<String?> {
    get {
      return graphQLMap["subtype"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "subtype")
    }
  }

  public var type: Swift.Optional<String?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// input type for inserting object relation for remote table "portfolio_transaction_gains"
public struct portfolio_transaction_gains_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: portfolio_transaction_gains_insert_input, onConflict: Swift.Optional<portfolio_transaction_gains_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: portfolio_transaction_gains_insert_input {
    get {
      return graphQLMap["data"] as! portfolio_transaction_gains_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<portfolio_transaction_gains_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<portfolio_transaction_gains_on_conflict?> ?? Swift.Optional<portfolio_transaction_gains_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "portfolio_transaction_gains"
public struct portfolio_transaction_gains_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - absoluteGain_1d
  ///   - absoluteGain_1m
  ///   - absoluteGain_1w
  ///   - absoluteGain_1y
  ///   - absoluteGain_3m
  ///   - absoluteGain_5y
  ///   - absoluteGainTotal
  ///   - relativeGain_1d
  ///   - relativeGain_1m
  ///   - relativeGain_1w
  ///   - relativeGain_1y
  ///   - relativeGain_3m
  ///   - relativeGain_5y
  ///   - relativeGainTotal
  ///   - transaction
  ///   - transactionId
  ///   - updatedAt
  public init(absoluteGain_1d: Swift.Optional<float8?> = nil, absoluteGain_1m: Swift.Optional<float8?> = nil, absoluteGain_1w: Swift.Optional<float8?> = nil, absoluteGain_1y: Swift.Optional<float8?> = nil, absoluteGain_3m: Swift.Optional<float8?> = nil, absoluteGain_5y: Swift.Optional<float8?> = nil, absoluteGainTotal: Swift.Optional<float8?> = nil, relativeGain_1d: Swift.Optional<float8?> = nil, relativeGain_1m: Swift.Optional<float8?> = nil, relativeGain_1w: Swift.Optional<float8?> = nil, relativeGain_1y: Swift.Optional<float8?> = nil, relativeGain_3m: Swift.Optional<float8?> = nil, relativeGain_5y: Swift.Optional<float8?> = nil, relativeGainTotal: Swift.Optional<float8?> = nil, transaction: Swift.Optional<app_profile_portfolio_transactions_obj_rel_insert_input?> = nil, transactionId: Swift.Optional<Int?> = nil, updatedAt: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "transaction": transaction, "transaction_id": transactionId, "updated_at": updatedAt]
  }

  public var absoluteGain_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1d")
    }
  }

  public var absoluteGain_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1m")
    }
  }

  public var absoluteGain_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1w")
    }
  }

  public var absoluteGain_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1y")
    }
  }

  public var absoluteGain_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_3m")
    }
  }

  public var absoluteGain_5y: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_5y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_5y")
    }
  }

  public var absoluteGainTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_total")
    }
  }

  public var relativeGain_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGain_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1m")
    }
  }

  public var relativeGain_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1w")
    }
  }

  public var relativeGain_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1y")
    }
  }

  public var relativeGain_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_3m")
    }
  }

  public var relativeGain_5y: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_5y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_5y")
    }
  }

  public var relativeGainTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var transaction: Swift.Optional<app_profile_portfolio_transactions_obj_rel_insert_input?> {
    get {
      return graphQLMap["transaction"] as? Swift.Optional<app_profile_portfolio_transactions_obj_rel_insert_input?> ?? Swift.Optional<app_profile_portfolio_transactions_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "transaction")
    }
  }

  public var transactionId: Swift.Optional<Int?> {
    get {
      return graphQLMap["transaction_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "transaction_id")
    }
  }

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// input type for inserting object relation for remote table "app.profile_portfolio_transactions"
public struct app_profile_portfolio_transactions_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_profile_portfolio_transactions_insert_input, onConflict: Swift.Optional<app_profile_portfolio_transactions_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_profile_portfolio_transactions_insert_input {
    get {
      return graphQLMap["data"] as! app_profile_portfolio_transactions_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_portfolio_transactions_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_portfolio_transactions_on_conflict?> ?? Swift.Optional<app_profile_portfolio_transactions_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// on conflict condition type for table "app.profile_portfolio_transactions"
public struct app_profile_portfolio_transactions_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_portfolio_transactions_constraint, updateColumns: [app_profile_portfolio_transactions_update_column], `where`: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_portfolio_transactions_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_portfolio_transactions_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_portfolio_transactions_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_portfolio_transactions_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_portfolio_transactions_bool_exp?> ?? Swift.Optional<app_profile_portfolio_transactions_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_portfolio_transactions"
public enum app_profile_portfolio_transactions_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profilePortfolioTransactionsPkey
  /// unique or primary key constraint
  case profilePortfolioTransactionsRefIdKey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_portfolio_transactions_pkey": self = .profilePortfolioTransactionsPkey
      case "profile_portfolio_transactions_ref_id_key": self = .profilePortfolioTransactionsRefIdKey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profilePortfolioTransactionsPkey: return "profile_portfolio_transactions_pkey"
      case .profilePortfolioTransactionsRefIdKey: return "profile_portfolio_transactions_ref_id_key"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_portfolio_transactions_constraint, rhs: app_profile_portfolio_transactions_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profilePortfolioTransactionsPkey, .profilePortfolioTransactionsPkey): return true
      case (.profilePortfolioTransactionsRefIdKey, .profilePortfolioTransactionsRefIdKey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_portfolio_transactions_constraint] {
    return [
      .profilePortfolioTransactionsPkey,
      .profilePortfolioTransactionsRefIdKey,
    ]
  }
}

/// update columns of table "app.profile_portfolio_transactions"
public enum app_profile_portfolio_transactions_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case accountId
  /// column name
  case amount
  /// column name
  case createdAt
  /// column name
  case date
  /// column name
  case fees
  /// column name
  case id
  /// column name
  case isoCurrencyCode
  /// column name
  case name
  /// column name
  case plaidAccessTokenId
  /// column name
  case price
  /// column name
  case profileId
  /// column name
  case quantity
  /// column name
  case refId
  /// column name
  case securityId
  /// column name
  case subtype
  /// column name
  case type
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "account_id": self = .accountId
      case "amount": self = .amount
      case "created_at": self = .createdAt
      case "date": self = .date
      case "fees": self = .fees
      case "id": self = .id
      case "iso_currency_code": self = .isoCurrencyCode
      case "name": self = .name
      case "plaid_access_token_id": self = .plaidAccessTokenId
      case "price": self = .price
      case "profile_id": self = .profileId
      case "quantity": self = .quantity
      case "ref_id": self = .refId
      case "security_id": self = .securityId
      case "subtype": self = .subtype
      case "type": self = .type
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .accountId: return "account_id"
      case .amount: return "amount"
      case .createdAt: return "created_at"
      case .date: return "date"
      case .fees: return "fees"
      case .id: return "id"
      case .isoCurrencyCode: return "iso_currency_code"
      case .name: return "name"
      case .plaidAccessTokenId: return "plaid_access_token_id"
      case .price: return "price"
      case .profileId: return "profile_id"
      case .quantity: return "quantity"
      case .refId: return "ref_id"
      case .securityId: return "security_id"
      case .subtype: return "subtype"
      case .type: return "type"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_portfolio_transactions_update_column, rhs: app_profile_portfolio_transactions_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.accountId, .accountId): return true
      case (.amount, .amount): return true
      case (.createdAt, .createdAt): return true
      case (.date, .date): return true
      case (.fees, .fees): return true
      case (.id, .id): return true
      case (.isoCurrencyCode, .isoCurrencyCode): return true
      case (.name, .name): return true
      case (.plaidAccessTokenId, .plaidAccessTokenId): return true
      case (.price, .price): return true
      case (.profileId, .profileId): return true
      case (.quantity, .quantity): return true
      case (.refId, .refId): return true
      case (.securityId, .securityId): return true
      case (.subtype, .subtype): return true
      case (.type, .type): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_portfolio_transactions_update_column] {
    return [
      .accountId,
      .amount,
      .createdAt,
      .date,
      .fees,
      .id,
      .isoCurrencyCode,
      .name,
      .plaidAccessTokenId,
      .price,
      .profileId,
      .quantity,
      .refId,
      .securityId,
      .subtype,
      .type,
      .updatedAt,
    ]
  }
}

/// on conflict condition type for table "portfolio_transaction_gains"
public struct portfolio_transaction_gains_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: portfolio_transaction_gains_constraint, updateColumns: [portfolio_transaction_gains_update_column], `where`: Swift.Optional<portfolio_transaction_gains_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: portfolio_transaction_gains_constraint {
    get {
      return graphQLMap["constraint"] as! portfolio_transaction_gains_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [portfolio_transaction_gains_update_column] {
    get {
      return graphQLMap["update_columns"] as! [portfolio_transaction_gains_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<portfolio_transaction_gains_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<portfolio_transaction_gains_bool_exp?> ?? Swift.Optional<portfolio_transaction_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "portfolio_transaction_gains"
public enum portfolio_transaction_gains_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case portfolioTransactionGainsUniqueTransactionId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "portfolio_transaction_gains_unique_transaction_id": self = .portfolioTransactionGainsUniqueTransactionId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .portfolioTransactionGainsUniqueTransactionId: return "portfolio_transaction_gains_unique_transaction_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: portfolio_transaction_gains_constraint, rhs: portfolio_transaction_gains_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.portfolioTransactionGainsUniqueTransactionId, .portfolioTransactionGainsUniqueTransactionId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [portfolio_transaction_gains_constraint] {
    return [
      .portfolioTransactionGainsUniqueTransactionId,
    ]
  }
}

/// update columns of table "portfolio_transaction_gains"
public enum portfolio_transaction_gains_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case absoluteGain_1d
  /// column name
  case absoluteGain_1m
  /// column name
  case absoluteGain_1w
  /// column name
  case absoluteGain_1y
  /// column name
  case absoluteGain_3m
  /// column name
  case absoluteGain_5y
  /// column name
  case absoluteGainTotal
  /// column name
  case relativeGain_1d
  /// column name
  case relativeGain_1m
  /// column name
  case relativeGain_1w
  /// column name
  case relativeGain_1y
  /// column name
  case relativeGain_3m
  /// column name
  case relativeGain_5y
  /// column name
  case relativeGainTotal
  /// column name
  case transactionId
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "absolute_gain_1d": self = .absoluteGain_1d
      case "absolute_gain_1m": self = .absoluteGain_1m
      case "absolute_gain_1w": self = .absoluteGain_1w
      case "absolute_gain_1y": self = .absoluteGain_1y
      case "absolute_gain_3m": self = .absoluteGain_3m
      case "absolute_gain_5y": self = .absoluteGain_5y
      case "absolute_gain_total": self = .absoluteGainTotal
      case "relative_gain_1d": self = .relativeGain_1d
      case "relative_gain_1m": self = .relativeGain_1m
      case "relative_gain_1w": self = .relativeGain_1w
      case "relative_gain_1y": self = .relativeGain_1y
      case "relative_gain_3m": self = .relativeGain_3m
      case "relative_gain_5y": self = .relativeGain_5y
      case "relative_gain_total": self = .relativeGainTotal
      case "transaction_id": self = .transactionId
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .absoluteGain_1d: return "absolute_gain_1d"
      case .absoluteGain_1m: return "absolute_gain_1m"
      case .absoluteGain_1w: return "absolute_gain_1w"
      case .absoluteGain_1y: return "absolute_gain_1y"
      case .absoluteGain_3m: return "absolute_gain_3m"
      case .absoluteGain_5y: return "absolute_gain_5y"
      case .absoluteGainTotal: return "absolute_gain_total"
      case .relativeGain_1d: return "relative_gain_1d"
      case .relativeGain_1m: return "relative_gain_1m"
      case .relativeGain_1w: return "relative_gain_1w"
      case .relativeGain_1y: return "relative_gain_1y"
      case .relativeGain_3m: return "relative_gain_3m"
      case .relativeGain_5y: return "relative_gain_5y"
      case .relativeGainTotal: return "relative_gain_total"
      case .transactionId: return "transaction_id"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: portfolio_transaction_gains_update_column, rhs: portfolio_transaction_gains_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.absoluteGain_1d, .absoluteGain_1d): return true
      case (.absoluteGain_1m, .absoluteGain_1m): return true
      case (.absoluteGain_1w, .absoluteGain_1w): return true
      case (.absoluteGain_1y, .absoluteGain_1y): return true
      case (.absoluteGain_3m, .absoluteGain_3m): return true
      case (.absoluteGain_5y, .absoluteGain_5y): return true
      case (.absoluteGainTotal, .absoluteGainTotal): return true
      case (.relativeGain_1d, .relativeGain_1d): return true
      case (.relativeGain_1m, .relativeGain_1m): return true
      case (.relativeGain_1w, .relativeGain_1w): return true
      case (.relativeGain_1y, .relativeGain_1y): return true
      case (.relativeGain_3m, .relativeGain_3m): return true
      case (.relativeGain_5y, .relativeGain_5y): return true
      case (.relativeGainTotal, .relativeGainTotal): return true
      case (.transactionId, .transactionId): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [portfolio_transaction_gains_update_column] {
    return [
      .absoluteGain_1d,
      .absoluteGain_1m,
      .absoluteGain_1w,
      .absoluteGain_1y,
      .absoluteGain_3m,
      .absoluteGain_5y,
      .absoluteGainTotal,
      .relativeGain_1d,
      .relativeGain_1m,
      .relativeGain_1w,
      .relativeGain_1y,
      .relativeGain_3m,
      .relativeGain_5y,
      .relativeGainTotal,
      .transactionId,
      .updatedAt,
    ]
  }
}

/// input type for inserting object relation for remote table "app.portfolio_securities"
public struct app_portfolio_securities_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_portfolio_securities_insert_input, onConflict: Swift.Optional<app_portfolio_securities_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_portfolio_securities_insert_input {
    get {
      return graphQLMap["data"] as! app_portfolio_securities_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_portfolio_securities_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_portfolio_securities_on_conflict?> ?? Swift.Optional<app_portfolio_securities_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.portfolio_securities"
public struct app_portfolio_securities_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - closePrice
  ///   - closePriceAsOf
  ///   - createdAt
  ///   - id
  ///   - isoCurrencyCode
  ///   - name
  ///   - profileHoldings
  ///   - refId
  ///   - tickerSymbol
  ///   - tickers
  ///   - type
  ///   - updatedAt
  public init(closePrice: Swift.Optional<float8?> = nil, closePriceAsOf: Swift.Optional<timestamp?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, id: Swift.Optional<Int?> = nil, isoCurrencyCode: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> = nil, refId: Swift.Optional<String?> = nil, tickerSymbol: Swift.Optional<String?> = nil, tickers: Swift.Optional<tickers_obj_rel_insert_input?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["close_price": closePrice, "close_price_as_of": closePriceAsOf, "created_at": createdAt, "id": id, "iso_currency_code": isoCurrencyCode, "name": name, "profile_holdings": profileHoldings, "ref_id": refId, "ticker_symbol": tickerSymbol, "tickers": tickers, "type": type, "updated_at": updatedAt]
  }

  public var closePrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["close_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close_price")
    }
  }

  public var closePriceAsOf: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["close_price_as_of"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close_price_as_of")
    }
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var isoCurrencyCode: Swift.Optional<String?> {
    get {
      return graphQLMap["iso_currency_code"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "iso_currency_code")
    }
  }

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> {
    get {
      return graphQLMap["profile_holdings"] as? Swift.Optional<app_profile_holdings_arr_rel_insert_input?> ?? Swift.Optional<app_profile_holdings_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_holdings")
    }
  }

  public var refId: Swift.Optional<String?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var tickerSymbol: Swift.Optional<String?> {
    get {
      return graphQLMap["ticker_symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_symbol")
    }
  }

  public var tickers: Swift.Optional<tickers_obj_rel_insert_input?> {
    get {
      return graphQLMap["tickers"] as? Swift.Optional<tickers_obj_rel_insert_input?> ?? Swift.Optional<tickers_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "tickers")
    }
  }

  public var type: Swift.Optional<String?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// on conflict condition type for table "app.portfolio_securities"
public struct app_portfolio_securities_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_portfolio_securities_constraint, updateColumns: [app_portfolio_securities_update_column], `where`: Swift.Optional<app_portfolio_securities_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_portfolio_securities_constraint {
    get {
      return graphQLMap["constraint"] as! app_portfolio_securities_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_portfolio_securities_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_portfolio_securities_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_portfolio_securities_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_portfolio_securities_bool_exp?> ?? Swift.Optional<app_portfolio_securities_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.portfolio_securities"
public enum app_portfolio_securities_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case portfolioSecuritiesPkey
  /// unique or primary key constraint
  case portfolioSecuritiesRefIdKey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "portfolio_securities_pkey": self = .portfolioSecuritiesPkey
      case "portfolio_securities_ref_id_key": self = .portfolioSecuritiesRefIdKey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .portfolioSecuritiesPkey: return "portfolio_securities_pkey"
      case .portfolioSecuritiesRefIdKey: return "portfolio_securities_ref_id_key"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_portfolio_securities_constraint, rhs: app_portfolio_securities_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.portfolioSecuritiesPkey, .portfolioSecuritiesPkey): return true
      case (.portfolioSecuritiesRefIdKey, .portfolioSecuritiesRefIdKey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_portfolio_securities_constraint] {
    return [
      .portfolioSecuritiesPkey,
      .portfolioSecuritiesRefIdKey,
    ]
  }
}

/// update columns of table "app.portfolio_securities"
public enum app_portfolio_securities_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case closePrice
  /// column name
  case closePriceAsOf
  /// column name
  case createdAt
  /// column name
  case id
  /// column name
  case isoCurrencyCode
  /// column name
  case name
  /// column name
  case refId
  /// column name
  case tickerSymbol
  /// column name
  case type
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "close_price": self = .closePrice
      case "close_price_as_of": self = .closePriceAsOf
      case "created_at": self = .createdAt
      case "id": self = .id
      case "iso_currency_code": self = .isoCurrencyCode
      case "name": self = .name
      case "ref_id": self = .refId
      case "ticker_symbol": self = .tickerSymbol
      case "type": self = .type
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .closePrice: return "close_price"
      case .closePriceAsOf: return "close_price_as_of"
      case .createdAt: return "created_at"
      case .id: return "id"
      case .isoCurrencyCode: return "iso_currency_code"
      case .name: return "name"
      case .refId: return "ref_id"
      case .tickerSymbol: return "ticker_symbol"
      case .type: return "type"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_portfolio_securities_update_column, rhs: app_portfolio_securities_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.closePrice, .closePrice): return true
      case (.closePriceAsOf, .closePriceAsOf): return true
      case (.createdAt, .createdAt): return true
      case (.id, .id): return true
      case (.isoCurrencyCode, .isoCurrencyCode): return true
      case (.name, .name): return true
      case (.refId, .refId): return true
      case (.tickerSymbol, .tickerSymbol): return true
      case (.type, .type): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_portfolio_securities_update_column] {
    return [
      .closePrice,
      .closePriceAsOf,
      .createdAt,
      .id,
      .isoCurrencyCode,
      .name,
      .refId,
      .tickerSymbol,
      .type,
      .updatedAt,
    ]
  }
}

/// input type for inserting object relation for remote table "portfolio_holding_gains"
public struct portfolio_holding_gains_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: portfolio_holding_gains_insert_input, onConflict: Swift.Optional<portfolio_holding_gains_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: portfolio_holding_gains_insert_input {
    get {
      return graphQLMap["data"] as! portfolio_holding_gains_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<portfolio_holding_gains_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<portfolio_holding_gains_on_conflict?> ?? Swift.Optional<portfolio_holding_gains_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "portfolio_holding_gains"
public struct portfolio_holding_gains_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - absoluteGain_1d
  ///   - absoluteGain_1m
  ///   - absoluteGain_1w
  ///   - absoluteGain_1y
  ///   - absoluteGain_3m
  ///   - absoluteGain_5y
  ///   - absoluteGainTotal
  ///   - actualValue
  ///   - holding
  ///   - holdingId
  ///   - lttQuantityTotal
  ///   - relativeGain_1d
  ///   - relativeGain_1m
  ///   - relativeGain_1w
  ///   - relativeGain_1y
  ///   - relativeGain_3m
  ///   - relativeGain_5y
  ///   - relativeGainTotal
  ///   - updatedAt
  ///   - valueToPortfolioValue
  public init(absoluteGain_1d: Swift.Optional<float8?> = nil, absoluteGain_1m: Swift.Optional<float8?> = nil, absoluteGain_1w: Swift.Optional<float8?> = nil, absoluteGain_1y: Swift.Optional<float8?> = nil, absoluteGain_3m: Swift.Optional<float8?> = nil, absoluteGain_5y: Swift.Optional<float8?> = nil, absoluteGainTotal: Swift.Optional<float8?> = nil, actualValue: Swift.Optional<float8?> = nil, holding: Swift.Optional<app_profile_holdings_obj_rel_insert_input?> = nil, holdingId: Swift.Optional<Int?> = nil, lttQuantityTotal: Swift.Optional<float8?> = nil, relativeGain_1d: Swift.Optional<float8?> = nil, relativeGain_1m: Swift.Optional<float8?> = nil, relativeGain_1w: Swift.Optional<float8?> = nil, relativeGain_1y: Swift.Optional<float8?> = nil, relativeGain_3m: Swift.Optional<float8?> = nil, relativeGain_5y: Swift.Optional<float8?> = nil, relativeGainTotal: Swift.Optional<float8?> = nil, updatedAt: Swift.Optional<timestamp?> = nil, valueToPortfolioValue: Swift.Optional<float8?> = nil) {
    graphQLMap = ["absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "holding": holding, "holding_id": holdingId, "ltt_quantity_total": lttQuantityTotal, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "updated_at": updatedAt, "value_to_portfolio_value": valueToPortfolioValue]
  }

  public var absoluteGain_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1d")
    }
  }

  public var absoluteGain_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1m")
    }
  }

  public var absoluteGain_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1w")
    }
  }

  public var absoluteGain_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1y")
    }
  }

  public var absoluteGain_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_3m")
    }
  }

  public var absoluteGain_5y: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_5y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_5y")
    }
  }

  public var absoluteGainTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["absolute_gain_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_total")
    }
  }

  public var actualValue: Swift.Optional<float8?> {
    get {
      return graphQLMap["actual_value"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "actual_value")
    }
  }

  public var holding: Swift.Optional<app_profile_holdings_obj_rel_insert_input?> {
    get {
      return graphQLMap["holding"] as? Swift.Optional<app_profile_holdings_obj_rel_insert_input?> ?? Swift.Optional<app_profile_holdings_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding")
    }
  }

  public var holdingId: Swift.Optional<Int?> {
    get {
      return graphQLMap["holding_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "holding_id")
    }
  }

  public var lttQuantityTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["ltt_quantity_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ltt_quantity_total")
    }
  }

  public var relativeGain_1d: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGain_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1m")
    }
  }

  public var relativeGain_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1w")
    }
  }

  public var relativeGain_1y: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_1y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1y")
    }
  }

  public var relativeGain_3m: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_3m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_3m")
    }
  }

  public var relativeGain_5y: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_5y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_5y")
    }
  }

  public var relativeGainTotal: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }

  public var valueToPortfolioValue: Swift.Optional<float8?> {
    get {
      return graphQLMap["value_to_portfolio_value"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "value_to_portfolio_value")
    }
  }
}

/// on conflict condition type for table "portfolio_holding_gains"
public struct portfolio_holding_gains_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: portfolio_holding_gains_constraint, updateColumns: [portfolio_holding_gains_update_column], `where`: Swift.Optional<portfolio_holding_gains_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: portfolio_holding_gains_constraint {
    get {
      return graphQLMap["constraint"] as! portfolio_holding_gains_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [portfolio_holding_gains_update_column] {
    get {
      return graphQLMap["update_columns"] as! [portfolio_holding_gains_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<portfolio_holding_gains_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<portfolio_holding_gains_bool_exp?> ?? Swift.Optional<portfolio_holding_gains_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "portfolio_holding_gains"
public enum portfolio_holding_gains_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case portfolioHoldingGainsUniqueHoldingId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "portfolio_holding_gains_unique_holding_id": self = .portfolioHoldingGainsUniqueHoldingId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .portfolioHoldingGainsUniqueHoldingId: return "portfolio_holding_gains_unique_holding_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: portfolio_holding_gains_constraint, rhs: portfolio_holding_gains_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.portfolioHoldingGainsUniqueHoldingId, .portfolioHoldingGainsUniqueHoldingId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [portfolio_holding_gains_constraint] {
    return [
      .portfolioHoldingGainsUniqueHoldingId,
    ]
  }
}

/// update columns of table "portfolio_holding_gains"
public enum portfolio_holding_gains_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case absoluteGain_1d
  /// column name
  case absoluteGain_1m
  /// column name
  case absoluteGain_1w
  /// column name
  case absoluteGain_1y
  /// column name
  case absoluteGain_3m
  /// column name
  case absoluteGain_5y
  /// column name
  case absoluteGainTotal
  /// column name
  case actualValue
  /// column name
  case holdingId
  /// column name
  case lttQuantityTotal
  /// column name
  case relativeGain_1d
  /// column name
  case relativeGain_1m
  /// column name
  case relativeGain_1w
  /// column name
  case relativeGain_1y
  /// column name
  case relativeGain_3m
  /// column name
  case relativeGain_5y
  /// column name
  case relativeGainTotal
  /// column name
  case updatedAt
  /// column name
  case valueToPortfolioValue
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "absolute_gain_1d": self = .absoluteGain_1d
      case "absolute_gain_1m": self = .absoluteGain_1m
      case "absolute_gain_1w": self = .absoluteGain_1w
      case "absolute_gain_1y": self = .absoluteGain_1y
      case "absolute_gain_3m": self = .absoluteGain_3m
      case "absolute_gain_5y": self = .absoluteGain_5y
      case "absolute_gain_total": self = .absoluteGainTotal
      case "actual_value": self = .actualValue
      case "holding_id": self = .holdingId
      case "ltt_quantity_total": self = .lttQuantityTotal
      case "relative_gain_1d": self = .relativeGain_1d
      case "relative_gain_1m": self = .relativeGain_1m
      case "relative_gain_1w": self = .relativeGain_1w
      case "relative_gain_1y": self = .relativeGain_1y
      case "relative_gain_3m": self = .relativeGain_3m
      case "relative_gain_5y": self = .relativeGain_5y
      case "relative_gain_total": self = .relativeGainTotal
      case "updated_at": self = .updatedAt
      case "value_to_portfolio_value": self = .valueToPortfolioValue
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .absoluteGain_1d: return "absolute_gain_1d"
      case .absoluteGain_1m: return "absolute_gain_1m"
      case .absoluteGain_1w: return "absolute_gain_1w"
      case .absoluteGain_1y: return "absolute_gain_1y"
      case .absoluteGain_3m: return "absolute_gain_3m"
      case .absoluteGain_5y: return "absolute_gain_5y"
      case .absoluteGainTotal: return "absolute_gain_total"
      case .actualValue: return "actual_value"
      case .holdingId: return "holding_id"
      case .lttQuantityTotal: return "ltt_quantity_total"
      case .relativeGain_1d: return "relative_gain_1d"
      case .relativeGain_1m: return "relative_gain_1m"
      case .relativeGain_1w: return "relative_gain_1w"
      case .relativeGain_1y: return "relative_gain_1y"
      case .relativeGain_3m: return "relative_gain_3m"
      case .relativeGain_5y: return "relative_gain_5y"
      case .relativeGainTotal: return "relative_gain_total"
      case .updatedAt: return "updated_at"
      case .valueToPortfolioValue: return "value_to_portfolio_value"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: portfolio_holding_gains_update_column, rhs: portfolio_holding_gains_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.absoluteGain_1d, .absoluteGain_1d): return true
      case (.absoluteGain_1m, .absoluteGain_1m): return true
      case (.absoluteGain_1w, .absoluteGain_1w): return true
      case (.absoluteGain_1y, .absoluteGain_1y): return true
      case (.absoluteGain_3m, .absoluteGain_3m): return true
      case (.absoluteGain_5y, .absoluteGain_5y): return true
      case (.absoluteGainTotal, .absoluteGainTotal): return true
      case (.actualValue, .actualValue): return true
      case (.holdingId, .holdingId): return true
      case (.lttQuantityTotal, .lttQuantityTotal): return true
      case (.relativeGain_1d, .relativeGain_1d): return true
      case (.relativeGain_1m, .relativeGain_1m): return true
      case (.relativeGain_1w, .relativeGain_1w): return true
      case (.relativeGain_1y, .relativeGain_1y): return true
      case (.relativeGain_3m, .relativeGain_3m): return true
      case (.relativeGain_5y, .relativeGain_5y): return true
      case (.relativeGainTotal, .relativeGainTotal): return true
      case (.updatedAt, .updatedAt): return true
      case (.valueToPortfolioValue, .valueToPortfolioValue): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [portfolio_holding_gains_update_column] {
    return [
      .absoluteGain_1d,
      .absoluteGain_1m,
      .absoluteGain_1w,
      .absoluteGain_1y,
      .absoluteGain_3m,
      .absoluteGain_5y,
      .absoluteGainTotal,
      .actualValue,
      .holdingId,
      .lttQuantityTotal,
      .relativeGain_1d,
      .relativeGain_1m,
      .relativeGain_1w,
      .relativeGain_1y,
      .relativeGain_3m,
      .relativeGain_5y,
      .relativeGainTotal,
      .updatedAt,
      .valueToPortfolioValue,
    ]
  }
}

/// input type for inserting array relation for remote table "app.profile_interests"
public struct app_profile_interests_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [app_profile_interests_insert_input], onConflict: Swift.Optional<app_profile_interests_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [app_profile_interests_insert_input] {
    get {
      return graphQLMap["data"] as! [app_profile_interests_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_interests_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_interests_on_conflict?> ?? Swift.Optional<app_profile_interests_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// on conflict condition type for table "app.profile_interests"
public struct app_profile_interests_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_interests_constraint, updateColumns: [app_profile_interests_update_column], `where`: Swift.Optional<app_profile_interests_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_interests_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_interests_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_interests_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_interests_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_interests_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_interests_bool_exp?> ?? Swift.Optional<app_profile_interests_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_interests"
public enum app_profile_interests_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profileInterestsPkey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_interests_pkey": self = .profileInterestsPkey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileInterestsPkey: return "profile_interests_pkey"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_interests_constraint, rhs: app_profile_interests_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profileInterestsPkey, .profileInterestsPkey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_interests_constraint] {
    return [
      .profileInterestsPkey,
    ]
  }
}

/// update columns of table "app.profile_interests"
public enum app_profile_interests_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case interestId
  /// column name
  case profileId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "interest_id": self = .interestId
      case "profile_id": self = .profileId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .interestId: return "interest_id"
      case .profileId: return "profile_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_interests_update_column, rhs: app_profile_interests_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.interestId, .interestId): return true
      case (.profileId, .profileId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_interests_update_column] {
    return [
      .interestId,
      .profileId,
    ]
  }
}

/// input type for inserting array relation for remote table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [app_profile_plaid_access_tokens_insert_input], onConflict: Swift.Optional<app_profile_plaid_access_tokens_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [app_profile_plaid_access_tokens_insert_input] {
    get {
      return graphQLMap["data"] as! [app_profile_plaid_access_tokens_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_plaid_access_tokens_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_plaid_access_tokens_on_conflict?> ?? Swift.Optional<app_profile_plaid_access_tokens_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accessToken
  ///   - createdAt
  ///   - id
  ///   - itemId
  ///   - profile
  ///   - profileId
  public init(accessToken: Swift.Optional<String?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, id: Swift.Optional<Int?> = nil, itemId: Swift.Optional<String?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil) {
    graphQLMap = ["access_token": accessToken, "created_at": createdAt, "id": id, "item_id": itemId, "profile": profile, "profile_id": profileId]
  }

  public var accessToken: Swift.Optional<String?> {
    get {
      return graphQLMap["access_token"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "access_token")
    }
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<Int?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var itemId: Swift.Optional<String?> {
    get {
      return graphQLMap["item_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "item_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// on conflict condition type for table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_plaid_access_tokens_constraint, updateColumns: [app_profile_plaid_access_tokens_update_column], `where`: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_plaid_access_tokens_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_plaid_access_tokens_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_plaid_access_tokens_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_plaid_access_tokens_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> ?? Swift.Optional<app_profile_plaid_access_tokens_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_plaid_access_tokens"
public enum app_profile_plaid_access_tokens_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profilePlaidAccessTokensPkey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_plaid_access_tokens_pkey": self = .profilePlaidAccessTokensPkey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profilePlaidAccessTokensPkey: return "profile_plaid_access_tokens_pkey"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_plaid_access_tokens_constraint, rhs: app_profile_plaid_access_tokens_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profilePlaidAccessTokensPkey, .profilePlaidAccessTokensPkey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_plaid_access_tokens_constraint] {
    return [
      .profilePlaidAccessTokensPkey,
    ]
  }
}

/// update columns of table "app.profile_plaid_access_tokens"
public enum app_profile_plaid_access_tokens_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case accessToken
  /// column name
  case createdAt
  /// column name
  case id
  /// column name
  case itemId
  /// column name
  case profileId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "access_token": self = .accessToken
      case "created_at": self = .createdAt
      case "id": self = .id
      case "item_id": self = .itemId
      case "profile_id": self = .profileId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .accessToken: return "access_token"
      case .createdAt: return "created_at"
      case .id: return "id"
      case .itemId: return "item_id"
      case .profileId: return "profile_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_plaid_access_tokens_update_column, rhs: app_profile_plaid_access_tokens_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.accessToken, .accessToken): return true
      case (.createdAt, .createdAt): return true
      case (.id, .id): return true
      case (.itemId, .itemId): return true
      case (.profileId, .profileId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_plaid_access_tokens_update_column] {
    return [
      .accessToken,
      .createdAt,
      .id,
      .itemId,
      .profileId,
    ]
  }
}

/// input type for inserting object relation for remote table "app.profile_scoring_settings"
public struct app_profile_scoring_settings_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_profile_scoring_settings_insert_input, onConflict: Swift.Optional<app_profile_scoring_settings_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_profile_scoring_settings_insert_input {
    get {
      return graphQLMap["data"] as! app_profile_scoring_settings_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_scoring_settings_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_scoring_settings_on_conflict?> ?? Swift.Optional<app_profile_scoring_settings_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_scoring_settings"
public struct app_profile_scoring_settings_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - averageMarketReturn
  ///   - createdAt
  ///   - damageOfFailure
  ///   - ifMarketDrops_20IWillBuy
  ///   - ifMarketDrops_40IWillBuy
  ///   - investmentHorizon
  ///   - profile
  ///   - profileId
  ///   - riskLevel
  ///   - stockMarketRiskLevel
  ///   - tradingExperience
  ///   - unexpectedPurchasesSource
  public init(averageMarketReturn: Swift.Optional<Int?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, damageOfFailure: Swift.Optional<Double?> = nil, ifMarketDrops_20IWillBuy: Swift.Optional<Double?> = nil, ifMarketDrops_40IWillBuy: Swift.Optional<Double?> = nil, investmentHorizon: Swift.Optional<Double?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, riskLevel: Swift.Optional<Double?> = nil, stockMarketRiskLevel: Swift.Optional<String?> = nil, tradingExperience: Swift.Optional<String?> = nil, unexpectedPurchasesSource: Swift.Optional<String?> = nil) {
    graphQLMap = ["average_market_return": averageMarketReturn, "created_at": createdAt, "damage_of_failure": damageOfFailure, "if_market_drops_20_i_will_buy": ifMarketDrops_20IWillBuy, "if_market_drops_40_i_will_buy": ifMarketDrops_40IWillBuy, "investment_horizon": investmentHorizon, "profile": profile, "profile_id": profileId, "risk_level": riskLevel, "stock_market_risk_level": stockMarketRiskLevel, "trading_experience": tradingExperience, "unexpected_purchases_source": unexpectedPurchasesSource]
  }

  public var averageMarketReturn: Swift.Optional<Int?> {
    get {
      return graphQLMap["average_market_return"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "average_market_return")
    }
  }

  public var createdAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var damageOfFailure: Swift.Optional<Double?> {
    get {
      return graphQLMap["damage_of_failure"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "damage_of_failure")
    }
  }

  public var ifMarketDrops_20IWillBuy: Swift.Optional<Double?> {
    get {
      return graphQLMap["if_market_drops_20_i_will_buy"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "if_market_drops_20_i_will_buy")
    }
  }

  public var ifMarketDrops_40IWillBuy: Swift.Optional<Double?> {
    get {
      return graphQLMap["if_market_drops_40_i_will_buy"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "if_market_drops_40_i_will_buy")
    }
  }

  public var investmentHorizon: Swift.Optional<Double?> {
    get {
      return graphQLMap["investment_horizon"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "investment_horizon")
    }
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var riskLevel: Swift.Optional<Double?> {
    get {
      return graphQLMap["risk_level"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_level")
    }
  }

  public var stockMarketRiskLevel: Swift.Optional<String?> {
    get {
      return graphQLMap["stock_market_risk_level"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stock_market_risk_level")
    }
  }

  public var tradingExperience: Swift.Optional<String?> {
    get {
      return graphQLMap["trading_experience"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "trading_experience")
    }
  }

  public var unexpectedPurchasesSource: Swift.Optional<String?> {
    get {
      return graphQLMap["unexpected_purchases_source"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "unexpected_purchases_source")
    }
  }
}

/// on conflict condition type for table "app.profile_scoring_settings"
public struct app_profile_scoring_settings_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_scoring_settings_constraint, updateColumns: [app_profile_scoring_settings_update_column], `where`: Swift.Optional<app_profile_scoring_settings_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_scoring_settings_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_scoring_settings_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_scoring_settings_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_scoring_settings_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_scoring_settings_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_scoring_settings_bool_exp?> ?? Swift.Optional<app_profile_scoring_settings_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_scoring_settings"
public enum app_profile_scoring_settings_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profileScoringSettingsPkey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_scoring_settings_pkey": self = .profileScoringSettingsPkey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileScoringSettingsPkey: return "profile_scoring_settings_pkey"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_scoring_settings_constraint, rhs: app_profile_scoring_settings_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profileScoringSettingsPkey, .profileScoringSettingsPkey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_scoring_settings_constraint] {
    return [
      .profileScoringSettingsPkey,
    ]
  }
}

/// update columns of table "app.profile_scoring_settings"
public enum app_profile_scoring_settings_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case averageMarketReturn
  /// column name
  case createdAt
  /// column name
  case damageOfFailure
  /// column name
  case ifMarketDrops_20IWillBuy
  /// column name
  case ifMarketDrops_40IWillBuy
  /// column name
  case investmentHorizon
  /// column name
  case profileId
  /// column name
  case riskLevel
  /// column name
  case stockMarketRiskLevel
  /// column name
  case tradingExperience
  /// column name
  case unexpectedPurchasesSource
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "average_market_return": self = .averageMarketReturn
      case "created_at": self = .createdAt
      case "damage_of_failure": self = .damageOfFailure
      case "if_market_drops_20_i_will_buy": self = .ifMarketDrops_20IWillBuy
      case "if_market_drops_40_i_will_buy": self = .ifMarketDrops_40IWillBuy
      case "investment_horizon": self = .investmentHorizon
      case "profile_id": self = .profileId
      case "risk_level": self = .riskLevel
      case "stock_market_risk_level": self = .stockMarketRiskLevel
      case "trading_experience": self = .tradingExperience
      case "unexpected_purchases_source": self = .unexpectedPurchasesSource
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .averageMarketReturn: return "average_market_return"
      case .createdAt: return "created_at"
      case .damageOfFailure: return "damage_of_failure"
      case .ifMarketDrops_20IWillBuy: return "if_market_drops_20_i_will_buy"
      case .ifMarketDrops_40IWillBuy: return "if_market_drops_40_i_will_buy"
      case .investmentHorizon: return "investment_horizon"
      case .profileId: return "profile_id"
      case .riskLevel: return "risk_level"
      case .stockMarketRiskLevel: return "stock_market_risk_level"
      case .tradingExperience: return "trading_experience"
      case .unexpectedPurchasesSource: return "unexpected_purchases_source"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_scoring_settings_update_column, rhs: app_profile_scoring_settings_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.averageMarketReturn, .averageMarketReturn): return true
      case (.createdAt, .createdAt): return true
      case (.damageOfFailure, .damageOfFailure): return true
      case (.ifMarketDrops_20IWillBuy, .ifMarketDrops_20IWillBuy): return true
      case (.ifMarketDrops_40IWillBuy, .ifMarketDrops_40IWillBuy): return true
      case (.investmentHorizon, .investmentHorizon): return true
      case (.profileId, .profileId): return true
      case (.riskLevel, .riskLevel): return true
      case (.stockMarketRiskLevel, .stockMarketRiskLevel): return true
      case (.tradingExperience, .tradingExperience): return true
      case (.unexpectedPurchasesSource, .unexpectedPurchasesSource): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_scoring_settings_update_column] {
    return [
      .averageMarketReturn,
      .createdAt,
      .damageOfFailure,
      .ifMarketDrops_20IWillBuy,
      .ifMarketDrops_40IWillBuy,
      .investmentHorizon,
      .profileId,
      .riskLevel,
      .stockMarketRiskLevel,
      .tradingExperience,
      .unexpectedPurchasesSource,
    ]
  }
}

/// input type for inserting array relation for remote table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [app_profile_watchlist_tickers_insert_input], onConflict: Swift.Optional<app_profile_watchlist_tickers_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [app_profile_watchlist_tickers_insert_input] {
    get {
      return graphQLMap["data"] as! [app_profile_watchlist_tickers_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_watchlist_tickers_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_watchlist_tickers_on_conflict?> ?? Swift.Optional<app_profile_watchlist_tickers_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profile
  ///   - profileId
  ///   - symbol
  public init(profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["profile": profile, "profile_id": profileId, "symbol": symbol]
  }

  public var profile: Swift.Optional<app_profiles_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_obj_rel_insert_input?> ?? Swift.Optional<app_profiles_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<Int?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// on conflict condition type for table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_watchlist_tickers_constraint, updateColumns: [app_profile_watchlist_tickers_update_column], `where`: Swift.Optional<app_profile_watchlist_tickers_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_watchlist_tickers_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_watchlist_tickers_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_watchlist_tickers_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_watchlist_tickers_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_watchlist_tickers_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_watchlist_tickers_bool_exp?> ?? Swift.Optional<app_profile_watchlist_tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_watchlist_tickers"
public enum app_profile_watchlist_tickers_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profileWatchlistTickersPkey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_watchlist_tickers_pkey": self = .profileWatchlistTickersPkey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileWatchlistTickersPkey: return "profile_watchlist_tickers_pkey"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_watchlist_tickers_constraint, rhs: app_profile_watchlist_tickers_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profileWatchlistTickersPkey, .profileWatchlistTickersPkey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_watchlist_tickers_constraint] {
    return [
      .profileWatchlistTickersPkey,
    ]
  }
}

/// update columns of table "app.profile_watchlist_tickers"
public enum app_profile_watchlist_tickers_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case profileId
  /// column name
  case symbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_id": self = .profileId
      case "symbol": self = .symbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileId: return "profile_id"
      case .symbol: return "symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_watchlist_tickers_update_column, rhs: app_profile_watchlist_tickers_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.profileId, .profileId): return true
      case (.symbol, .symbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_watchlist_tickers_update_column] {
    return [
      .profileId,
      .symbol,
    ]
  }
}

/// on conflict condition type for table "app.profiles"
public struct app_profiles_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profiles_constraint, updateColumns: [app_profiles_update_column], `where`: Swift.Optional<app_profiles_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profiles_constraint {
    get {
      return graphQLMap["constraint"] as! app_profiles_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profiles_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profiles_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profiles_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profiles_bool_exp?> ?? Swift.Optional<app_profiles_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profiles"
public enum app_profiles_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profileEmailKey
  /// unique or primary key constraint
  case profilePkey
  /// unique or primary key constraint
  case profilesUserIdKey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_email_key": self = .profileEmailKey
      case "profile_pkey": self = .profilePkey
      case "profiles_user_id_key": self = .profilesUserIdKey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileEmailKey: return "profile_email_key"
      case .profilePkey: return "profile_pkey"
      case .profilesUserIdKey: return "profiles_user_id_key"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profiles_constraint, rhs: app_profiles_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profileEmailKey, .profileEmailKey): return true
      case (.profilePkey, .profilePkey): return true
      case (.profilesUserIdKey, .profilesUserIdKey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profiles_constraint] {
    return [
      .profileEmailKey,
      .profilePkey,
      .profilesUserIdKey,
    ]
  }
}

/// update columns of table "app.profiles"
public enum app_profiles_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case avatarUrl
  /// column name
  case createdAt
  /// column name
  case email
  /// column name
  case firstName
  /// column name
  case gender
  /// column name
  case id
  /// column name
  case lastName
  /// column name
  case legalAddress
  /// column name
  case userId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "avatar_url": self = .avatarUrl
      case "created_at": self = .createdAt
      case "email": self = .email
      case "first_name": self = .firstName
      case "gender": self = .gender
      case "id": self = .id
      case "last_name": self = .lastName
      case "legal_address": self = .legalAddress
      case "user_id": self = .userId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .avatarUrl: return "avatar_url"
      case .createdAt: return "created_at"
      case .email: return "email"
      case .firstName: return "first_name"
      case .gender: return "gender"
      case .id: return "id"
      case .lastName: return "last_name"
      case .legalAddress: return "legal_address"
      case .userId: return "user_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profiles_update_column, rhs: app_profiles_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.avatarUrl, .avatarUrl): return true
      case (.createdAt, .createdAt): return true
      case (.email, .email): return true
      case (.firstName, .firstName): return true
      case (.gender, .gender): return true
      case (.id, .id): return true
      case (.lastName, .lastName): return true
      case (.legalAddress, .legalAddress): return true
      case (.userId, .userId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profiles_update_column] {
    return [
      .avatarUrl,
      .createdAt,
      .email,
      .firstName,
      .gender,
      .id,
      .lastName,
      .legalAddress,
      .userId,
    ]
  }
}
