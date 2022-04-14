// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// column ordering options
public enum order_by: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// in ascending order, nulls last
  case asc
  /// in ascending order, nulls first
  case ascNullsFirst
  /// in ascending order, nulls last
  case ascNullsLast
  /// in descending order, nulls first
  case desc
  /// in descending order, nulls first
  case descNullsFirst
  /// in descending order, nulls last
  case descNullsLast
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "asc": self = .asc
      case "asc_nulls_first": self = .ascNullsFirst
      case "asc_nulls_last": self = .ascNullsLast
      case "desc": self = .desc
      case "desc_nulls_first": self = .descNullsFirst
      case "desc_nulls_last": self = .descNullsLast
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .asc: return "asc"
      case .ascNullsFirst: return "asc_nulls_first"
      case .ascNullsLast: return "asc_nulls_last"
      case .desc: return "desc"
      case .descNullsFirst: return "desc_nulls_first"
      case .descNullsLast: return "desc_nulls_last"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: order_by, rhs: order_by) -> Bool {
    switch (lhs, rhs) {
      case (.asc, .asc): return true
      case (.ascNullsFirst, .ascNullsFirst): return true
      case (.ascNullsLast, .ascNullsLast): return true
      case (.desc, .desc): return true
      case (.descNullsFirst, .descNullsFirst): return true
      case (.descNullsLast, .descNullsLast): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [order_by] {
    return [
      .asc,
      .ascNullsFirst,
      .ascNullsLast,
      .desc,
      .descNullsFirst,
      .descNullsLast,
    ]
  }
}

/// Ordering options when selecting data from "public_220413044555.profile_ticker_collections".
public struct ticker_collections_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profile
  ///   - profileId
  ///   - symbol
  ///   - ticker
  public init(collectionId: Swift.Optional<order_by?> = nil, profile: Swift.Optional<app_profiles_order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, ticker: Swift.Optional<tickers_order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile": profile, "profile_id": profileId, "symbol": symbol, "ticker": ticker]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profile: Swift.Optional<app_profiles_order_by?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_order_by?> ?? Swift.Optional<app_profiles_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_order_by?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_order_by?> ?? Swift.Optional<tickers_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// Ordering options when selecting data from "app.profiles".
public struct app_profiles_order_by: GraphQLMapConvertible {
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
  ///   - profileCategoriesAggregate
  ///   - profileFavoriteCollectionsAggregate
  ///   - profileHoldingsAggregate
  ///   - profileInterestsAggregate
  ///   - profilePlaidAccessTokensAggregate
  ///   - profileScoringSetting
  ///   - profileWatchlistTickersAggregate
  ///   - userId
  public init(avatarUrl: Swift.Optional<order_by?> = nil, createdAt: Swift.Optional<order_by?> = nil, email: Swift.Optional<order_by?> = nil, firstName: Swift.Optional<order_by?> = nil, gender: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, lastName: Swift.Optional<order_by?> = nil, legalAddress: Swift.Optional<order_by?> = nil, portfolioGains: Swift.Optional<portfolio_gains_order_by?> = nil, profileCategoriesAggregate: Swift.Optional<app_profile_categories_aggregate_order_by?> = nil, profileFavoriteCollectionsAggregate: Swift.Optional<app_profile_favorite_collections_aggregate_order_by?> = nil, profileHoldingsAggregate: Swift.Optional<app_profile_holdings_aggregate_order_by?> = nil, profileInterestsAggregate: Swift.Optional<app_profile_interests_aggregate_order_by?> = nil, profilePlaidAccessTokensAggregate: Swift.Optional<app_profile_plaid_access_tokens_aggregate_order_by?> = nil, profileScoringSetting: Swift.Optional<app_profile_scoring_settings_order_by?> = nil, profileWatchlistTickersAggregate: Swift.Optional<app_profile_watchlist_tickers_aggregate_order_by?> = nil, userId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["avatar_url": avatarUrl, "created_at": createdAt, "email": email, "first_name": firstName, "gender": gender, "id": id, "last_name": lastName, "legal_address": legalAddress, "portfolio_gains": portfolioGains, "profile_categories_aggregate": profileCategoriesAggregate, "profile_favorite_collections_aggregate": profileFavoriteCollectionsAggregate, "profile_holdings_aggregate": profileHoldingsAggregate, "profile_interests_aggregate": profileInterestsAggregate, "profile_plaid_access_tokens_aggregate": profilePlaidAccessTokensAggregate, "profile_scoring_setting": profileScoringSetting, "profile_watchlist_tickers_aggregate": profileWatchlistTickersAggregate, "user_id": userId]
  }

  public var avatarUrl: Swift.Optional<order_by?> {
    get {
      return graphQLMap["avatar_url"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avatar_url")
    }
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var email: Swift.Optional<order_by?> {
    get {
      return graphQLMap["email"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var firstName: Swift.Optional<order_by?> {
    get {
      return graphQLMap["first_name"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "first_name")
    }
  }

  public var gender: Swift.Optional<order_by?> {
    get {
      return graphQLMap["gender"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gender")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var lastName: Swift.Optional<order_by?> {
    get {
      return graphQLMap["last_name"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_name")
    }
  }

  public var legalAddress: Swift.Optional<order_by?> {
    get {
      return graphQLMap["legal_address"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "legal_address")
    }
  }

  public var portfolioGains: Swift.Optional<portfolio_gains_order_by?> {
    get {
      return graphQLMap["portfolio_gains"] as? Swift.Optional<portfolio_gains_order_by?> ?? Swift.Optional<portfolio_gains_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_gains")
    }
  }

  public var profileCategoriesAggregate: Swift.Optional<app_profile_categories_aggregate_order_by?> {
    get {
      return graphQLMap["profile_categories_aggregate"] as? Swift.Optional<app_profile_categories_aggregate_order_by?> ?? Swift.Optional<app_profile_categories_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_categories_aggregate")
    }
  }

  public var profileFavoriteCollectionsAggregate: Swift.Optional<app_profile_favorite_collections_aggregate_order_by?> {
    get {
      return graphQLMap["profile_favorite_collections_aggregate"] as? Swift.Optional<app_profile_favorite_collections_aggregate_order_by?> ?? Swift.Optional<app_profile_favorite_collections_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_favorite_collections_aggregate")
    }
  }

  public var profileHoldingsAggregate: Swift.Optional<app_profile_holdings_aggregate_order_by?> {
    get {
      return graphQLMap["profile_holdings_aggregate"] as? Swift.Optional<app_profile_holdings_aggregate_order_by?> ?? Swift.Optional<app_profile_holdings_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_holdings_aggregate")
    }
  }

  public var profileInterestsAggregate: Swift.Optional<app_profile_interests_aggregate_order_by?> {
    get {
      return graphQLMap["profile_interests_aggregate"] as? Swift.Optional<app_profile_interests_aggregate_order_by?> ?? Swift.Optional<app_profile_interests_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_interests_aggregate")
    }
  }

  public var profilePlaidAccessTokensAggregate: Swift.Optional<app_profile_plaid_access_tokens_aggregate_order_by?> {
    get {
      return graphQLMap["profile_plaid_access_tokens_aggregate"] as? Swift.Optional<app_profile_plaid_access_tokens_aggregate_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_plaid_access_tokens_aggregate")
    }
  }

  public var profileScoringSetting: Swift.Optional<app_profile_scoring_settings_order_by?> {
    get {
      return graphQLMap["profile_scoring_setting"] as? Swift.Optional<app_profile_scoring_settings_order_by?> ?? Swift.Optional<app_profile_scoring_settings_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_scoring_setting")
    }
  }

  public var profileWatchlistTickersAggregate: Swift.Optional<app_profile_watchlist_tickers_aggregate_order_by?> {
    get {
      return graphQLMap["profile_watchlist_tickers_aggregate"] as? Swift.Optional<app_profile_watchlist_tickers_aggregate_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_watchlist_tickers_aggregate")
    }
  }

  public var userId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["user_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "user_id")
    }
  }
}

/// Ordering options when selecting data from "public_220413044555.portfolio_gains".
public struct portfolio_gains_order_by: GraphQLMapConvertible {
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
  public init(absoluteGain_1d: Swift.Optional<order_by?> = nil, absoluteGain_1m: Swift.Optional<order_by?> = nil, absoluteGain_1w: Swift.Optional<order_by?> = nil, absoluteGain_1y: Swift.Optional<order_by?> = nil, absoluteGain_3m: Swift.Optional<order_by?> = nil, absoluteGain_5y: Swift.Optional<order_by?> = nil, absoluteGainTotal: Swift.Optional<order_by?> = nil, actualValue: Swift.Optional<order_by?> = nil, profile: Swift.Optional<app_profiles_order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, relativeGain_1d: Swift.Optional<order_by?> = nil, relativeGain_1m: Swift.Optional<order_by?> = nil, relativeGain_1w: Swift.Optional<order_by?> = nil, relativeGain_1y: Swift.Optional<order_by?> = nil, relativeGain_3m: Swift.Optional<order_by?> = nil, relativeGain_5y: Swift.Optional<order_by?> = nil, relativeGainTotal: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["absolute_gain_1d": absoluteGain_1d, "absolute_gain_1m": absoluteGain_1m, "absolute_gain_1w": absoluteGain_1w, "absolute_gain_1y": absoluteGain_1y, "absolute_gain_3m": absoluteGain_3m, "absolute_gain_5y": absoluteGain_5y, "absolute_gain_total": absoluteGainTotal, "actual_value": actualValue, "profile": profile, "profile_id": profileId, "relative_gain_1d": relativeGain_1d, "relative_gain_1m": relativeGain_1m, "relative_gain_1w": relativeGain_1w, "relative_gain_1y": relativeGain_1y, "relative_gain_3m": relativeGain_3m, "relative_gain_5y": relativeGain_5y, "relative_gain_total": relativeGainTotal, "updated_at": updatedAt]
  }

  public var absoluteGain_1d: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_gain_1d"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1d")
    }
  }

  public var absoluteGain_1m: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_gain_1m"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1m")
    }
  }

  public var absoluteGain_1w: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_gain_1w"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1w")
    }
  }

  public var absoluteGain_1y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_gain_1y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_1y")
    }
  }

  public var absoluteGain_3m: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_gain_3m"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_3m")
    }
  }

  public var absoluteGain_5y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_gain_5y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_5y")
    }
  }

  public var absoluteGainTotal: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_gain_total"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_gain_total")
    }
  }

  public var actualValue: Swift.Optional<order_by?> {
    get {
      return graphQLMap["actual_value"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "actual_value")
    }
  }

  public var profile: Swift.Optional<app_profiles_order_by?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_order_by?> ?? Swift.Optional<app_profiles_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var relativeGain_1d: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_gain_1d"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1d")
    }
  }

  public var relativeGain_1m: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_gain_1m"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1m")
    }
  }

  public var relativeGain_1w: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_gain_1w"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1w")
    }
  }

  public var relativeGain_1y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_gain_1y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_1y")
    }
  }

  public var relativeGain_3m: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_gain_3m"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_3m")
    }
  }

  public var relativeGain_5y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_gain_5y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_5y")
    }
  }

  public var relativeGainTotal: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_gain_total"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_gain_total")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by aggregate values of table "app.profile_categories"
public struct app_profile_categories_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<app_profile_categories_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<app_profile_categories_max_order_by?> = nil, min: Swift.Optional<app_profile_categories_min_order_by?> = nil, stddev: Swift.Optional<app_profile_categories_stddev_order_by?> = nil, stddevPop: Swift.Optional<app_profile_categories_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<app_profile_categories_stddev_samp_order_by?> = nil, sum: Swift.Optional<app_profile_categories_sum_order_by?> = nil, varPop: Swift.Optional<app_profile_categories_var_pop_order_by?> = nil, varSamp: Swift.Optional<app_profile_categories_var_samp_order_by?> = nil, variance: Swift.Optional<app_profile_categories_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<app_profile_categories_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<app_profile_categories_avg_order_by?> ?? Swift.Optional<app_profile_categories_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<app_profile_categories_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<app_profile_categories_max_order_by?> ?? Swift.Optional<app_profile_categories_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<app_profile_categories_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<app_profile_categories_min_order_by?> ?? Swift.Optional<app_profile_categories_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<app_profile_categories_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<app_profile_categories_stddev_order_by?> ?? Swift.Optional<app_profile_categories_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<app_profile_categories_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<app_profile_categories_stddev_pop_order_by?> ?? Swift.Optional<app_profile_categories_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<app_profile_categories_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<app_profile_categories_stddev_samp_order_by?> ?? Swift.Optional<app_profile_categories_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<app_profile_categories_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<app_profile_categories_sum_order_by?> ?? Swift.Optional<app_profile_categories_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<app_profile_categories_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<app_profile_categories_var_pop_order_by?> ?? Swift.Optional<app_profile_categories_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<app_profile_categories_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<app_profile_categories_var_samp_order_by?> ?? Swift.Optional<app_profile_categories_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<app_profile_categories_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<app_profile_categories_variance_order_by?> ?? Swift.Optional<app_profile_categories_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "app.profile_categories"
public struct app_profile_categories_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by max() on columns of table "app.profile_categories"
public struct app_profile_categories_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by min() on columns of table "app.profile_categories"
public struct app_profile_categories_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev() on columns of table "app.profile_categories"
public struct app_profile_categories_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_pop() on columns of table "app.profile_categories"
public struct app_profile_categories_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_samp() on columns of table "app.profile_categories"
public struct app_profile_categories_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by sum() on columns of table "app.profile_categories"
public struct app_profile_categories_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_pop() on columns of table "app.profile_categories"
public struct app_profile_categories_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_samp() on columns of table "app.profile_categories"
public struct app_profile_categories_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by variance() on columns of table "app.profile_categories"
public struct app_profile_categories_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - profileId
  public init(categoryId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "profile_id": profileId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by aggregate values of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<app_profile_favorite_collections_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<app_profile_favorite_collections_max_order_by?> = nil, min: Swift.Optional<app_profile_favorite_collections_min_order_by?> = nil, stddev: Swift.Optional<app_profile_favorite_collections_stddev_order_by?> = nil, stddevPop: Swift.Optional<app_profile_favorite_collections_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<app_profile_favorite_collections_stddev_samp_order_by?> = nil, sum: Swift.Optional<app_profile_favorite_collections_sum_order_by?> = nil, varPop: Swift.Optional<app_profile_favorite_collections_var_pop_order_by?> = nil, varSamp: Swift.Optional<app_profile_favorite_collections_var_samp_order_by?> = nil, variance: Swift.Optional<app_profile_favorite_collections_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<app_profile_favorite_collections_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<app_profile_favorite_collections_avg_order_by?> ?? Swift.Optional<app_profile_favorite_collections_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<app_profile_favorite_collections_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<app_profile_favorite_collections_max_order_by?> ?? Swift.Optional<app_profile_favorite_collections_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<app_profile_favorite_collections_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<app_profile_favorite_collections_min_order_by?> ?? Swift.Optional<app_profile_favorite_collections_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<app_profile_favorite_collections_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<app_profile_favorite_collections_stddev_order_by?> ?? Swift.Optional<app_profile_favorite_collections_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<app_profile_favorite_collections_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<app_profile_favorite_collections_stddev_pop_order_by?> ?? Swift.Optional<app_profile_favorite_collections_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<app_profile_favorite_collections_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<app_profile_favorite_collections_stddev_samp_order_by?> ?? Swift.Optional<app_profile_favorite_collections_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<app_profile_favorite_collections_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<app_profile_favorite_collections_sum_order_by?> ?? Swift.Optional<app_profile_favorite_collections_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<app_profile_favorite_collections_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<app_profile_favorite_collections_var_pop_order_by?> ?? Swift.Optional<app_profile_favorite_collections_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<app_profile_favorite_collections_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<app_profile_favorite_collections_var_samp_order_by?> ?? Swift.Optional<app_profile_favorite_collections_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<app_profile_favorite_collections_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<app_profile_favorite_collections_variance_order_by?> ?? Swift.Optional<app_profile_favorite_collections_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by max() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by min() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_pop() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_samp() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by sum() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_pop() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_samp() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by variance() on columns of table "app.profile_favorite_collections"
public struct app_profile_favorite_collections_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by aggregate values of table "app.profile_holdings"
public struct app_profile_holdings_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<app_profile_holdings_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<app_profile_holdings_max_order_by?> = nil, min: Swift.Optional<app_profile_holdings_min_order_by?> = nil, stddev: Swift.Optional<app_profile_holdings_stddev_order_by?> = nil, stddevPop: Swift.Optional<app_profile_holdings_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<app_profile_holdings_stddev_samp_order_by?> = nil, sum: Swift.Optional<app_profile_holdings_sum_order_by?> = nil, varPop: Swift.Optional<app_profile_holdings_var_pop_order_by?> = nil, varSamp: Swift.Optional<app_profile_holdings_var_samp_order_by?> = nil, variance: Swift.Optional<app_profile_holdings_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<app_profile_holdings_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<app_profile_holdings_avg_order_by?> ?? Swift.Optional<app_profile_holdings_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<app_profile_holdings_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<app_profile_holdings_max_order_by?> ?? Swift.Optional<app_profile_holdings_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<app_profile_holdings_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<app_profile_holdings_min_order_by?> ?? Swift.Optional<app_profile_holdings_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<app_profile_holdings_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<app_profile_holdings_stddev_order_by?> ?? Swift.Optional<app_profile_holdings_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<app_profile_holdings_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<app_profile_holdings_stddev_pop_order_by?> ?? Swift.Optional<app_profile_holdings_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<app_profile_holdings_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<app_profile_holdings_stddev_samp_order_by?> ?? Swift.Optional<app_profile_holdings_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<app_profile_holdings_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<app_profile_holdings_sum_order_by?> ?? Swift.Optional<app_profile_holdings_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<app_profile_holdings_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<app_profile_holdings_var_pop_order_by?> ?? Swift.Optional<app_profile_holdings_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<app_profile_holdings_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<app_profile_holdings_var_samp_order_by?> ?? Swift.Optional<app_profile_holdings_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<app_profile_holdings_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<app_profile_holdings_variance_order_by?> ?? Swift.Optional<app_profile_holdings_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "app.profile_holdings"
public struct app_profile_holdings_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - id
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - securityId
  public init(accountId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "id": id, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "security_id": securityId]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }
}

/// order by max() on columns of table "app.profile_holdings"
public struct app_profile_holdings_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - createdAt
  ///   - id
  ///   - isoCurrencyCode
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - refId
  ///   - securityId
  ///   - updatedAt
  public init(accountId: Swift.Optional<order_by?> = nil, createdAt: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, isoCurrencyCode: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, refId: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "created_at": createdAt, "id": id, "iso_currency_code": isoCurrencyCode, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security_id": securityId, "updated_at": updatedAt]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var isoCurrencyCode: Swift.Optional<order_by?> {
    get {
      return graphQLMap["iso_currency_code"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "iso_currency_code")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var refId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by min() on columns of table "app.profile_holdings"
public struct app_profile_holdings_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - createdAt
  ///   - id
  ///   - isoCurrencyCode
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - refId
  ///   - securityId
  ///   - updatedAt
  public init(accountId: Swift.Optional<order_by?> = nil, createdAt: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, isoCurrencyCode: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, refId: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "created_at": createdAt, "id": id, "iso_currency_code": isoCurrencyCode, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security_id": securityId, "updated_at": updatedAt]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var isoCurrencyCode: Swift.Optional<order_by?> {
    get {
      return graphQLMap["iso_currency_code"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "iso_currency_code")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var refId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by stddev() on columns of table "app.profile_holdings"
public struct app_profile_holdings_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - id
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - securityId
  public init(accountId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "id": id, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "security_id": securityId]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }
}

/// order by stddev_pop() on columns of table "app.profile_holdings"
public struct app_profile_holdings_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - id
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - securityId
  public init(accountId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "id": id, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "security_id": securityId]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }
}

/// order by stddev_samp() on columns of table "app.profile_holdings"
public struct app_profile_holdings_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - id
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - securityId
  public init(accountId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "id": id, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "security_id": securityId]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }
}

/// order by sum() on columns of table "app.profile_holdings"
public struct app_profile_holdings_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - id
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - securityId
  public init(accountId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "id": id, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "security_id": securityId]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }
}

/// order by var_pop() on columns of table "app.profile_holdings"
public struct app_profile_holdings_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - id
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - securityId
  public init(accountId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "id": id, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "security_id": securityId]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }
}

/// order by var_samp() on columns of table "app.profile_holdings"
public struct app_profile_holdings_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - id
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - securityId
  public init(accountId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "id": id, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "security_id": securityId]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }
}

/// order by variance() on columns of table "app.profile_holdings"
public struct app_profile_holdings_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - id
  ///   - plaidAccessTokenId
  ///   - profileId
  ///   - quantity
  ///   - securityId
  public init(accountId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, plaidAccessTokenId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, quantity: Swift.Optional<order_by?> = nil, securityId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["account_id": accountId, "id": id, "plaid_access_token_id": plaidAccessTokenId, "profile_id": profileId, "quantity": quantity, "security_id": securityId]
  }

  public var accountId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var plaidAccessTokenId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["plaid_access_token_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plaid_access_token_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var quantity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
    }
  }

  public var securityId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["security_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "security_id")
    }
  }
}

/// order by aggregate values of table "app.profile_interests"
public struct app_profile_interests_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<app_profile_interests_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<app_profile_interests_max_order_by?> = nil, min: Swift.Optional<app_profile_interests_min_order_by?> = nil, stddev: Swift.Optional<app_profile_interests_stddev_order_by?> = nil, stddevPop: Swift.Optional<app_profile_interests_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<app_profile_interests_stddev_samp_order_by?> = nil, sum: Swift.Optional<app_profile_interests_sum_order_by?> = nil, varPop: Swift.Optional<app_profile_interests_var_pop_order_by?> = nil, varSamp: Swift.Optional<app_profile_interests_var_samp_order_by?> = nil, variance: Swift.Optional<app_profile_interests_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<app_profile_interests_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<app_profile_interests_avg_order_by?> ?? Swift.Optional<app_profile_interests_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<app_profile_interests_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<app_profile_interests_max_order_by?> ?? Swift.Optional<app_profile_interests_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<app_profile_interests_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<app_profile_interests_min_order_by?> ?? Swift.Optional<app_profile_interests_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<app_profile_interests_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<app_profile_interests_stddev_order_by?> ?? Swift.Optional<app_profile_interests_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<app_profile_interests_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<app_profile_interests_stddev_pop_order_by?> ?? Swift.Optional<app_profile_interests_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<app_profile_interests_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<app_profile_interests_stddev_samp_order_by?> ?? Swift.Optional<app_profile_interests_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<app_profile_interests_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<app_profile_interests_sum_order_by?> ?? Swift.Optional<app_profile_interests_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<app_profile_interests_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<app_profile_interests_var_pop_order_by?> ?? Swift.Optional<app_profile_interests_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<app_profile_interests_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<app_profile_interests_var_samp_order_by?> ?? Swift.Optional<app_profile_interests_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<app_profile_interests_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<app_profile_interests_variance_order_by?> ?? Swift.Optional<app_profile_interests_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "app.profile_interests"
public struct app_profile_interests_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by max() on columns of table "app.profile_interests"
public struct app_profile_interests_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by min() on columns of table "app.profile_interests"
public struct app_profile_interests_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev() on columns of table "app.profile_interests"
public struct app_profile_interests_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_pop() on columns of table "app.profile_interests"
public struct app_profile_interests_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_samp() on columns of table "app.profile_interests"
public struct app_profile_interests_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by sum() on columns of table "app.profile_interests"
public struct app_profile_interests_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_pop() on columns of table "app.profile_interests"
public struct app_profile_interests_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_samp() on columns of table "app.profile_interests"
public struct app_profile_interests_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by variance() on columns of table "app.profile_interests"
public struct app_profile_interests_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - profileId
  public init(interestId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "profile_id": profileId]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by aggregate values of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<app_profile_plaid_access_tokens_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<app_profile_plaid_access_tokens_max_order_by?> = nil, min: Swift.Optional<app_profile_plaid_access_tokens_min_order_by?> = nil, stddev: Swift.Optional<app_profile_plaid_access_tokens_stddev_order_by?> = nil, stddevPop: Swift.Optional<app_profile_plaid_access_tokens_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<app_profile_plaid_access_tokens_stddev_samp_order_by?> = nil, sum: Swift.Optional<app_profile_plaid_access_tokens_sum_order_by?> = nil, varPop: Swift.Optional<app_profile_plaid_access_tokens_var_pop_order_by?> = nil, varSamp: Swift.Optional<app_profile_plaid_access_tokens_var_samp_order_by?> = nil, variance: Swift.Optional<app_profile_plaid_access_tokens_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<app_profile_plaid_access_tokens_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<app_profile_plaid_access_tokens_avg_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<app_profile_plaid_access_tokens_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<app_profile_plaid_access_tokens_max_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<app_profile_plaid_access_tokens_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<app_profile_plaid_access_tokens_min_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<app_profile_plaid_access_tokens_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<app_profile_plaid_access_tokens_stddev_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<app_profile_plaid_access_tokens_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<app_profile_plaid_access_tokens_stddev_pop_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<app_profile_plaid_access_tokens_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<app_profile_plaid_access_tokens_stddev_samp_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<app_profile_plaid_access_tokens_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<app_profile_plaid_access_tokens_sum_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<app_profile_plaid_access_tokens_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<app_profile_plaid_access_tokens_var_pop_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<app_profile_plaid_access_tokens_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<app_profile_plaid_access_tokens_var_samp_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<app_profile_plaid_access_tokens_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<app_profile_plaid_access_tokens_variance_order_by?> ?? Swift.Optional<app_profile_plaid_access_tokens_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - institutionId
  ///   - profileId
  public init(id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "institution_id": institutionId, "profile_id": profileId]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by max() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accessToken
  ///   - createdAt
  ///   - id
  ///   - institutionId
  ///   - itemId
  ///   - needsReauthSince
  ///   - profileId
  public init(accessToken: Swift.Optional<order_by?> = nil, createdAt: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, itemId: Swift.Optional<order_by?> = nil, needsReauthSince: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["access_token": accessToken, "created_at": createdAt, "id": id, "institution_id": institutionId, "item_id": itemId, "needs_reauth_since": needsReauthSince, "profile_id": profileId]
  }

  public var accessToken: Swift.Optional<order_by?> {
    get {
      return graphQLMap["access_token"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "access_token")
    }
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var itemId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["item_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "item_id")
    }
  }

  public var needsReauthSince: Swift.Optional<order_by?> {
    get {
      return graphQLMap["needs_reauth_since"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "needs_reauth_since")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by min() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accessToken
  ///   - createdAt
  ///   - id
  ///   - institutionId
  ///   - itemId
  ///   - needsReauthSince
  ///   - profileId
  public init(accessToken: Swift.Optional<order_by?> = nil, createdAt: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, itemId: Swift.Optional<order_by?> = nil, needsReauthSince: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["access_token": accessToken, "created_at": createdAt, "id": id, "institution_id": institutionId, "item_id": itemId, "needs_reauth_since": needsReauthSince, "profile_id": profileId]
  }

  public var accessToken: Swift.Optional<order_by?> {
    get {
      return graphQLMap["access_token"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "access_token")
    }
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var itemId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["item_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "item_id")
    }
  }

  public var needsReauthSince: Swift.Optional<order_by?> {
    get {
      return graphQLMap["needs_reauth_since"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "needs_reauth_since")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - institutionId
  ///   - profileId
  public init(id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "institution_id": institutionId, "profile_id": profileId]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_pop() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - institutionId
  ///   - profileId
  public init(id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "institution_id": institutionId, "profile_id": profileId]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_samp() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - institutionId
  ///   - profileId
  public init(id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "institution_id": institutionId, "profile_id": profileId]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by sum() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - institutionId
  ///   - profileId
  public init(id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "institution_id": institutionId, "profile_id": profileId]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_pop() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - institutionId
  ///   - profileId
  public init(id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "institution_id": institutionId, "profile_id": profileId]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_samp() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - institutionId
  ///   - profileId
  public init(id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "institution_id": institutionId, "profile_id": profileId]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by variance() on columns of table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - institutionId
  ///   - profileId
  public init(id: Swift.Optional<order_by?> = nil, institutionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "institution_id": institutionId, "profile_id": profileId]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var institutionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// Ordering options when selecting data from "app.profile_scoring_settings".
public struct app_profile_scoring_settings_order_by: GraphQLMapConvertible {
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
  ///   - riskScore
  ///   - stockMarketRiskLevel
  ///   - tradingExperience
  ///   - unexpectedPurchasesSource
  public init(averageMarketReturn: Swift.Optional<order_by?> = nil, createdAt: Swift.Optional<order_by?> = nil, damageOfFailure: Swift.Optional<order_by?> = nil, ifMarketDrops_20IWillBuy: Swift.Optional<order_by?> = nil, ifMarketDrops_40IWillBuy: Swift.Optional<order_by?> = nil, investmentHorizon: Swift.Optional<order_by?> = nil, profile: Swift.Optional<app_profiles_order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, riskLevel: Swift.Optional<order_by?> = nil, riskScore: Swift.Optional<order_by?> = nil, stockMarketRiskLevel: Swift.Optional<order_by?> = nil, tradingExperience: Swift.Optional<order_by?> = nil, unexpectedPurchasesSource: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["average_market_return": averageMarketReturn, "created_at": createdAt, "damage_of_failure": damageOfFailure, "if_market_drops_20_i_will_buy": ifMarketDrops_20IWillBuy, "if_market_drops_40_i_will_buy": ifMarketDrops_40IWillBuy, "investment_horizon": investmentHorizon, "profile": profile, "profile_id": profileId, "risk_level": riskLevel, "risk_score": riskScore, "stock_market_risk_level": stockMarketRiskLevel, "trading_experience": tradingExperience, "unexpected_purchases_source": unexpectedPurchasesSource]
  }

  public var averageMarketReturn: Swift.Optional<order_by?> {
    get {
      return graphQLMap["average_market_return"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "average_market_return")
    }
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var damageOfFailure: Swift.Optional<order_by?> {
    get {
      return graphQLMap["damage_of_failure"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "damage_of_failure")
    }
  }

  public var ifMarketDrops_20IWillBuy: Swift.Optional<order_by?> {
    get {
      return graphQLMap["if_market_drops_20_i_will_buy"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "if_market_drops_20_i_will_buy")
    }
  }

  public var ifMarketDrops_40IWillBuy: Swift.Optional<order_by?> {
    get {
      return graphQLMap["if_market_drops_40_i_will_buy"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "if_market_drops_40_i_will_buy")
    }
  }

  public var investmentHorizon: Swift.Optional<order_by?> {
    get {
      return graphQLMap["investment_horizon"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "investment_horizon")
    }
  }

  public var profile: Swift.Optional<app_profiles_order_by?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_order_by?> ?? Swift.Optional<app_profiles_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var riskLevel: Swift.Optional<order_by?> {
    get {
      return graphQLMap["risk_level"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_level")
    }
  }

  public var riskScore: Swift.Optional<order_by?> {
    get {
      return graphQLMap["risk_score"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_score")
    }
  }

  public var stockMarketRiskLevel: Swift.Optional<order_by?> {
    get {
      return graphQLMap["stock_market_risk_level"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stock_market_risk_level")
    }
  }

  public var tradingExperience: Swift.Optional<order_by?> {
    get {
      return graphQLMap["trading_experience"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "trading_experience")
    }
  }

  public var unexpectedPurchasesSource: Swift.Optional<order_by?> {
    get {
      return graphQLMap["unexpected_purchases_source"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "unexpected_purchases_source")
    }
  }
}

/// order by aggregate values of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<app_profile_watchlist_tickers_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<app_profile_watchlist_tickers_max_order_by?> = nil, min: Swift.Optional<app_profile_watchlist_tickers_min_order_by?> = nil, stddev: Swift.Optional<app_profile_watchlist_tickers_stddev_order_by?> = nil, stddevPop: Swift.Optional<app_profile_watchlist_tickers_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<app_profile_watchlist_tickers_stddev_samp_order_by?> = nil, sum: Swift.Optional<app_profile_watchlist_tickers_sum_order_by?> = nil, varPop: Swift.Optional<app_profile_watchlist_tickers_var_pop_order_by?> = nil, varSamp: Swift.Optional<app_profile_watchlist_tickers_var_samp_order_by?> = nil, variance: Swift.Optional<app_profile_watchlist_tickers_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<app_profile_watchlist_tickers_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<app_profile_watchlist_tickers_avg_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<app_profile_watchlist_tickers_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<app_profile_watchlist_tickers_max_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<app_profile_watchlist_tickers_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<app_profile_watchlist_tickers_min_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<app_profile_watchlist_tickers_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<app_profile_watchlist_tickers_stddev_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<app_profile_watchlist_tickers_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<app_profile_watchlist_tickers_stddev_pop_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<app_profile_watchlist_tickers_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<app_profile_watchlist_tickers_stddev_samp_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<app_profile_watchlist_tickers_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<app_profile_watchlist_tickers_sum_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<app_profile_watchlist_tickers_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<app_profile_watchlist_tickers_var_pop_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<app_profile_watchlist_tickers_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<app_profile_watchlist_tickers_var_samp_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<app_profile_watchlist_tickers_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<app_profile_watchlist_tickers_variance_order_by?> ?? Swift.Optional<app_profile_watchlist_tickers_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  public init(profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by max() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  ///   - symbol
  public init(profileId: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId, "symbol": symbol]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// order by min() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  ///   - symbol
  public init(profileId: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId, "symbol": symbol]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// order by stddev() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  public init(profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_pop() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  public init(profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_samp() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  public init(profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by sum() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  public init(profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_pop() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  public init(profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_samp() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  public init(profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by variance() on columns of table "app.profile_watchlist_tickers"
public struct app_profile_watchlist_tickers_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - profileId
  public init(profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["profile_id": profileId]
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// Ordering options when selecting data from "public_220413044555.tickers".
public struct tickers_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - countryName
  ///   - cryptoMetrics
  ///   - cryptoRealtimeMetrics
  ///   - description
  ///   - exchange
  ///   - exchangeCanonical
  ///   - gicGroup
  ///   - gicIndustry
  ///   - gicSector
  ///   - gicSubIndustry
  ///   - industry
  ///   - ipoDate
  ///   - logoUrl
  ///   - matchScore
  ///   - name
  ///   - phone
  ///   - realtimeMetrics
  ///   - sector
  ///   - symbol
  ///   - tickerAnalystRatings
  ///   - tickerCategoriesAggregate
  ///   - tickerCollectionsAggregate
  ///   - tickerEventsAggregate
  ///   - tickerHighlightsAggregate
  ///   - tickerIndustriesAggregate
  ///   - tickerInterestsAggregate
  ///   - tickerMetrics
  ///   - type
  ///   - updatedAt
  ///   - webUrl
  public init(countryName: Swift.Optional<order_by?> = nil, cryptoMetrics: Swift.Optional<crypto_metrics_order_by?> = nil, cryptoRealtimeMetrics: Swift.Optional<crypto_realtime_metrics_order_by?> = nil, description: Swift.Optional<order_by?> = nil, exchange: Swift.Optional<order_by?> = nil, exchangeCanonical: Swift.Optional<order_by?> = nil, gicGroup: Swift.Optional<order_by?> = nil, gicIndustry: Swift.Optional<order_by?> = nil, gicSector: Swift.Optional<order_by?> = nil, gicSubIndustry: Swift.Optional<order_by?> = nil, industry: Swift.Optional<order_by?> = nil, ipoDate: Swift.Optional<order_by?> = nil, logoUrl: Swift.Optional<order_by?> = nil, matchScore: Swift.Optional<app_profile_ticker_match_score_order_by?> = nil, name: Swift.Optional<order_by?> = nil, phone: Swift.Optional<order_by?> = nil, realtimeMetrics: Swift.Optional<ticker_realtime_metrics_order_by?> = nil, sector: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, tickerAnalystRatings: Swift.Optional<analyst_ratings_order_by?> = nil, tickerCategoriesAggregate: Swift.Optional<ticker_categories_aggregate_order_by?> = nil, tickerCollectionsAggregate: Swift.Optional<ticker_collections_aggregate_order_by?> = nil, tickerEventsAggregate: Swift.Optional<ticker_events_aggregate_order_by?> = nil, tickerHighlightsAggregate: Swift.Optional<ticker_highlights_aggregate_order_by?> = nil, tickerIndustriesAggregate: Swift.Optional<ticker_industries_aggregate_order_by?> = nil, tickerInterestsAggregate: Swift.Optional<ticker_interests_aggregate_order_by?> = nil, tickerMetrics: Swift.Optional<ticker_metrics_order_by?> = nil, type: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil, webUrl: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["country_name": countryName, "crypto_metrics": cryptoMetrics, "crypto_realtime_metrics": cryptoRealtimeMetrics, "description": description, "exchange": exchange, "exchange_canonical": exchangeCanonical, "gic_group": gicGroup, "gic_industry": gicIndustry, "gic_sector": gicSector, "gic_sub_industry": gicSubIndustry, "industry": industry, "ipo_date": ipoDate, "logo_url": logoUrl, "match_score": matchScore, "name": name, "phone": phone, "realtime_metrics": realtimeMetrics, "sector": sector, "symbol": symbol, "ticker_analyst_ratings": tickerAnalystRatings, "ticker_categories_aggregate": tickerCategoriesAggregate, "ticker_collections_aggregate": tickerCollectionsAggregate, "ticker_events_aggregate": tickerEventsAggregate, "ticker_highlights_aggregate": tickerHighlightsAggregate, "ticker_industries_aggregate": tickerIndustriesAggregate, "ticker_interests_aggregate": tickerInterestsAggregate, "ticker_metrics": tickerMetrics, "type": type, "updated_at": updatedAt, "web_url": webUrl]
  }

  public var countryName: Swift.Optional<order_by?> {
    get {
      return graphQLMap["country_name"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country_name")
    }
  }

  public var cryptoMetrics: Swift.Optional<crypto_metrics_order_by?> {
    get {
      return graphQLMap["crypto_metrics"] as? Swift.Optional<crypto_metrics_order_by?> ?? Swift.Optional<crypto_metrics_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "crypto_metrics")
    }
  }

  public var cryptoRealtimeMetrics: Swift.Optional<crypto_realtime_metrics_order_by?> {
    get {
      return graphQLMap["crypto_realtime_metrics"] as? Swift.Optional<crypto_realtime_metrics_order_by?> ?? Swift.Optional<crypto_realtime_metrics_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "crypto_realtime_metrics")
    }
  }

  public var description: Swift.Optional<order_by?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var exchange: Swift.Optional<order_by?> {
    get {
      return graphQLMap["exchange"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange")
    }
  }

  public var exchangeCanonical: Swift.Optional<order_by?> {
    get {
      return graphQLMap["exchange_canonical"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange_canonical")
    }
  }

  public var gicGroup: Swift.Optional<order_by?> {
    get {
      return graphQLMap["gic_group"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_group")
    }
  }

  public var gicIndustry: Swift.Optional<order_by?> {
    get {
      return graphQLMap["gic_industry"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_industry")
    }
  }

  public var gicSector: Swift.Optional<order_by?> {
    get {
      return graphQLMap["gic_sector"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_sector")
    }
  }

  public var gicSubIndustry: Swift.Optional<order_by?> {
    get {
      return graphQLMap["gic_sub_industry"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gic_sub_industry")
    }
  }

  public var industry: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry")
    }
  }

  public var ipoDate: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ipo_date"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ipo_date")
    }
  }

  public var logoUrl: Swift.Optional<order_by?> {
    get {
      return graphQLMap["logo_url"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "logo_url")
    }
  }

  public var matchScore: Swift.Optional<app_profile_ticker_match_score_order_by?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<app_profile_ticker_match_score_order_by?> ?? Swift.Optional<app_profile_ticker_match_score_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
    }
  }

  public var name: Swift.Optional<order_by?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var phone: Swift.Optional<order_by?> {
    get {
      return graphQLMap["phone"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "phone")
    }
  }

  public var realtimeMetrics: Swift.Optional<ticker_realtime_metrics_order_by?> {
    get {
      return graphQLMap["realtime_metrics"] as? Swift.Optional<ticker_realtime_metrics_order_by?> ?? Swift.Optional<ticker_realtime_metrics_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "realtime_metrics")
    }
  }

  public var sector: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sector"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sector")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var tickerAnalystRatings: Swift.Optional<analyst_ratings_order_by?> {
    get {
      return graphQLMap["ticker_analyst_ratings"] as? Swift.Optional<analyst_ratings_order_by?> ?? Swift.Optional<analyst_ratings_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_analyst_ratings")
    }
  }

  public var tickerCategoriesAggregate: Swift.Optional<ticker_categories_aggregate_order_by?> {
    get {
      return graphQLMap["ticker_categories_aggregate"] as? Swift.Optional<ticker_categories_aggregate_order_by?> ?? Swift.Optional<ticker_categories_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_categories_aggregate")
    }
  }

  public var tickerCollectionsAggregate: Swift.Optional<ticker_collections_aggregate_order_by?> {
    get {
      return graphQLMap["ticker_collections_aggregate"] as? Swift.Optional<ticker_collections_aggregate_order_by?> ?? Swift.Optional<ticker_collections_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_collections_aggregate")
    }
  }

  public var tickerEventsAggregate: Swift.Optional<ticker_events_aggregate_order_by?> {
    get {
      return graphQLMap["ticker_events_aggregate"] as? Swift.Optional<ticker_events_aggregate_order_by?> ?? Swift.Optional<ticker_events_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_events_aggregate")
    }
  }

  public var tickerHighlightsAggregate: Swift.Optional<ticker_highlights_aggregate_order_by?> {
    get {
      return graphQLMap["ticker_highlights_aggregate"] as? Swift.Optional<ticker_highlights_aggregate_order_by?> ?? Swift.Optional<ticker_highlights_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_highlights_aggregate")
    }
  }

  public var tickerIndustriesAggregate: Swift.Optional<ticker_industries_aggregate_order_by?> {
    get {
      return graphQLMap["ticker_industries_aggregate"] as? Swift.Optional<ticker_industries_aggregate_order_by?> ?? Swift.Optional<ticker_industries_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_industries_aggregate")
    }
  }

  public var tickerInterestsAggregate: Swift.Optional<ticker_interests_aggregate_order_by?> {
    get {
      return graphQLMap["ticker_interests_aggregate"] as? Swift.Optional<ticker_interests_aggregate_order_by?> ?? Swift.Optional<ticker_interests_aggregate_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_interests_aggregate")
    }
  }

  public var tickerMetrics: Swift.Optional<ticker_metrics_order_by?> {
    get {
      return graphQLMap["ticker_metrics"] as? Swift.Optional<ticker_metrics_order_by?> ?? Swift.Optional<ticker_metrics_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_metrics")
    }
  }

  public var type: Swift.Optional<order_by?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }

  public var webUrl: Swift.Optional<order_by?> {
    get {
      return graphQLMap["web_url"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "web_url")
    }
  }
}

/// Ordering options when selecting data from "public_220413044555.crypto_metrics".
public struct crypto_metrics_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - alexaRank
  ///   - assetPlatformId
  ///   - bingMatches
  ///   - categories
  ///   - coingeckoRank
  ///   - coingeckoScore
  ///   - communityFacebookLikes
  ///   - communityRedditAccountsActive_48h
  ///   - communityRedditAverageComments_48h
  ///   - communityRedditAveragePosts_48h
  ///   - communityRedditSubscribers
  ///   - communityScore
  ///   - communityTelegramChannelUserCount
  ///   - communityTwitterFollowers
  ///   - countryOrigin
  ///   - description
  ///   - developmentClosedIssues
  ///   - developmentCodeAdditionsDeletions_4WeeksAdditions
  ///   - developmentCodeAdditionsDeletions_4WeeksDeletions
  ///   - developmentCommitCount_4Weeks
  ///   - developmentForks
  ///   - developmentPullRequestContributors
  ///   - developmentPullRequestsMerged
  ///   - developmentScore
  ///   - developmentStars
  ///   - developmentSubscribers
  ///   - developmentTotalIssues
  ///   - hashingAlgorithm
  ///   - icoEndDate
  ///   - icoStartDate
  ///   - imageLarge
  ///   - imageSmall
  ///   - imageThumb
  ///   - links
  ///   - liquidityScore
  ///   - marketCapRank
  ///   - marketFdvToTvlRatio
  ///   - marketMcapToTvlRatio
  ///   - marketTotalValueLocked
  ///   - name
  ///   - priceChange_1m
  ///   - priceChange_1w
  ///   - priceChange_1y
  ///   - priceChange_3m
  ///   - priceChange_5y
  ///   - priceChangeAll
  ///   - publicInterestScore
  ///   - sentimentVotesDownPercentage
  ///   - sentimentVotesUpPercentage
  ///   - symbol
  public init(alexaRank: Swift.Optional<order_by?> = nil, assetPlatformId: Swift.Optional<order_by?> = nil, bingMatches: Swift.Optional<order_by?> = nil, categories: Swift.Optional<order_by?> = nil, coingeckoRank: Swift.Optional<order_by?> = nil, coingeckoScore: Swift.Optional<order_by?> = nil, communityFacebookLikes: Swift.Optional<order_by?> = nil, communityRedditAccountsActive_48h: Swift.Optional<order_by?> = nil, communityRedditAverageComments_48h: Swift.Optional<order_by?> = nil, communityRedditAveragePosts_48h: Swift.Optional<order_by?> = nil, communityRedditSubscribers: Swift.Optional<order_by?> = nil, communityScore: Swift.Optional<order_by?> = nil, communityTelegramChannelUserCount: Swift.Optional<order_by?> = nil, communityTwitterFollowers: Swift.Optional<order_by?> = nil, countryOrigin: Swift.Optional<order_by?> = nil, description: Swift.Optional<order_by?> = nil, developmentClosedIssues: Swift.Optional<order_by?> = nil, developmentCodeAdditionsDeletions_4WeeksAdditions: Swift.Optional<order_by?> = nil, developmentCodeAdditionsDeletions_4WeeksDeletions: Swift.Optional<order_by?> = nil, developmentCommitCount_4Weeks: Swift.Optional<order_by?> = nil, developmentForks: Swift.Optional<order_by?> = nil, developmentPullRequestContributors: Swift.Optional<order_by?> = nil, developmentPullRequestsMerged: Swift.Optional<order_by?> = nil, developmentScore: Swift.Optional<order_by?> = nil, developmentStars: Swift.Optional<order_by?> = nil, developmentSubscribers: Swift.Optional<order_by?> = nil, developmentTotalIssues: Swift.Optional<order_by?> = nil, hashingAlgorithm: Swift.Optional<order_by?> = nil, icoEndDate: Swift.Optional<order_by?> = nil, icoStartDate: Swift.Optional<order_by?> = nil, imageLarge: Swift.Optional<order_by?> = nil, imageSmall: Swift.Optional<order_by?> = nil, imageThumb: Swift.Optional<order_by?> = nil, links: Swift.Optional<order_by?> = nil, liquidityScore: Swift.Optional<order_by?> = nil, marketCapRank: Swift.Optional<order_by?> = nil, marketFdvToTvlRatio: Swift.Optional<order_by?> = nil, marketMcapToTvlRatio: Swift.Optional<order_by?> = nil, marketTotalValueLocked: Swift.Optional<order_by?> = nil, name: Swift.Optional<order_by?> = nil, priceChange_1m: Swift.Optional<order_by?> = nil, priceChange_1w: Swift.Optional<order_by?> = nil, priceChange_1y: Swift.Optional<order_by?> = nil, priceChange_3m: Swift.Optional<order_by?> = nil, priceChange_5y: Swift.Optional<order_by?> = nil, priceChangeAll: Swift.Optional<order_by?> = nil, publicInterestScore: Swift.Optional<order_by?> = nil, sentimentVotesDownPercentage: Swift.Optional<order_by?> = nil, sentimentVotesUpPercentage: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["alexa_rank": alexaRank, "asset_platform_id": assetPlatformId, "bing_matches": bingMatches, "categories": categories, "coingecko_rank": coingeckoRank, "coingecko_score": coingeckoScore, "community_facebook_likes": communityFacebookLikes, "community_reddit_accounts_active_48h": communityRedditAccountsActive_48h, "community_reddit_average_comments_48h": communityRedditAverageComments_48h, "community_reddit_average_posts_48h": communityRedditAveragePosts_48h, "community_reddit_subscribers": communityRedditSubscribers, "community_score": communityScore, "community_telegram_channel_user_count": communityTelegramChannelUserCount, "community_twitter_followers": communityTwitterFollowers, "country_origin": countryOrigin, "description": description, "development_closed_issues": developmentClosedIssues, "development_code_additions_deletions_4_weeks_additions": developmentCodeAdditionsDeletions_4WeeksAdditions, "development_code_additions_deletions_4_weeks_deletions": developmentCodeAdditionsDeletions_4WeeksDeletions, "development_commit_count_4_weeks": developmentCommitCount_4Weeks, "development_forks": developmentForks, "development_pull_request_contributors": developmentPullRequestContributors, "development_pull_requests_merged": developmentPullRequestsMerged, "development_score": developmentScore, "development_stars": developmentStars, "development_subscribers": developmentSubscribers, "development_total_issues": developmentTotalIssues, "hashing_algorithm": hashingAlgorithm, "ico_end_date": icoEndDate, "ico_start_date": icoStartDate, "image_large": imageLarge, "image_small": imageSmall, "image_thumb": imageThumb, "links": links, "liquidity_score": liquidityScore, "market_cap_rank": marketCapRank, "market_fdv_to_tvl_ratio": marketFdvToTvlRatio, "market_mcap_to_tvl_ratio": marketMcapToTvlRatio, "market_total_value_locked": marketTotalValueLocked, "name": name, "price_change_1m": priceChange_1m, "price_change_1w": priceChange_1w, "price_change_1y": priceChange_1y, "price_change_3m": priceChange_3m, "price_change_5y": priceChange_5y, "price_change_all": priceChangeAll, "public_interest_score": publicInterestScore, "sentiment_votes_down_percentage": sentimentVotesDownPercentage, "sentiment_votes_up_percentage": sentimentVotesUpPercentage, "symbol": symbol]
  }

  public var alexaRank: Swift.Optional<order_by?> {
    get {
      return graphQLMap["alexa_rank"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "alexa_rank")
    }
  }

  public var assetPlatformId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["asset_platform_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "asset_platform_id")
    }
  }

  public var bingMatches: Swift.Optional<order_by?> {
    get {
      return graphQLMap["bing_matches"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "bing_matches")
    }
  }

  public var categories: Swift.Optional<order_by?> {
    get {
      return graphQLMap["categories"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "categories")
    }
  }

  public var coingeckoRank: Swift.Optional<order_by?> {
    get {
      return graphQLMap["coingecko_rank"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "coingecko_rank")
    }
  }

  public var coingeckoScore: Swift.Optional<order_by?> {
    get {
      return graphQLMap["coingecko_score"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "coingecko_score")
    }
  }

  public var communityFacebookLikes: Swift.Optional<order_by?> {
    get {
      return graphQLMap["community_facebook_likes"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_facebook_likes")
    }
  }

  public var communityRedditAccountsActive_48h: Swift.Optional<order_by?> {
    get {
      return graphQLMap["community_reddit_accounts_active_48h"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_accounts_active_48h")
    }
  }

  public var communityRedditAverageComments_48h: Swift.Optional<order_by?> {
    get {
      return graphQLMap["community_reddit_average_comments_48h"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_average_comments_48h")
    }
  }

  public var communityRedditAveragePosts_48h: Swift.Optional<order_by?> {
    get {
      return graphQLMap["community_reddit_average_posts_48h"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_average_posts_48h")
    }
  }

  public var communityRedditSubscribers: Swift.Optional<order_by?> {
    get {
      return graphQLMap["community_reddit_subscribers"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_subscribers")
    }
  }

  public var communityScore: Swift.Optional<order_by?> {
    get {
      return graphQLMap["community_score"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_score")
    }
  }

  public var communityTelegramChannelUserCount: Swift.Optional<order_by?> {
    get {
      return graphQLMap["community_telegram_channel_user_count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_telegram_channel_user_count")
    }
  }

  public var communityTwitterFollowers: Swift.Optional<order_by?> {
    get {
      return graphQLMap["community_twitter_followers"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_twitter_followers")
    }
  }

  public var countryOrigin: Swift.Optional<order_by?> {
    get {
      return graphQLMap["country_origin"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country_origin")
    }
  }

  public var description: Swift.Optional<order_by?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var developmentClosedIssues: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_closed_issues"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_closed_issues")
    }
  }

  public var developmentCodeAdditionsDeletions_4WeeksAdditions: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_code_additions_deletions_4_weeks_additions"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_code_additions_deletions_4_weeks_additions")
    }
  }

  public var developmentCodeAdditionsDeletions_4WeeksDeletions: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_code_additions_deletions_4_weeks_deletions"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_code_additions_deletions_4_weeks_deletions")
    }
  }

  public var developmentCommitCount_4Weeks: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_commit_count_4_weeks"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_commit_count_4_weeks")
    }
  }

  public var developmentForks: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_forks"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_forks")
    }
  }

  public var developmentPullRequestContributors: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_pull_request_contributors"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_pull_request_contributors")
    }
  }

  public var developmentPullRequestsMerged: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_pull_requests_merged"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_pull_requests_merged")
    }
  }

  public var developmentScore: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_score"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_score")
    }
  }

  public var developmentStars: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_stars"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_stars")
    }
  }

  public var developmentSubscribers: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_subscribers"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_subscribers")
    }
  }

  public var developmentTotalIssues: Swift.Optional<order_by?> {
    get {
      return graphQLMap["development_total_issues"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_total_issues")
    }
  }

  public var hashingAlgorithm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["hashing_algorithm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hashing_algorithm")
    }
  }

  public var icoEndDate: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ico_end_date"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ico_end_date")
    }
  }

  public var icoStartDate: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ico_start_date"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ico_start_date")
    }
  }

  public var imageLarge: Swift.Optional<order_by?> {
    get {
      return graphQLMap["image_large"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_large")
    }
  }

  public var imageSmall: Swift.Optional<order_by?> {
    get {
      return graphQLMap["image_small"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_small")
    }
  }

  public var imageThumb: Swift.Optional<order_by?> {
    get {
      return graphQLMap["image_thumb"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_thumb")
    }
  }

  public var links: Swift.Optional<order_by?> {
    get {
      return graphQLMap["links"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "links")
    }
  }

  public var liquidityScore: Swift.Optional<order_by?> {
    get {
      return graphQLMap["liquidity_score"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "liquidity_score")
    }
  }

  public var marketCapRank: Swift.Optional<order_by?> {
    get {
      return graphQLMap["market_cap_rank"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_cap_rank")
    }
  }

  public var marketFdvToTvlRatio: Swift.Optional<order_by?> {
    get {
      return graphQLMap["market_fdv_to_tvl_ratio"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_fdv_to_tvl_ratio")
    }
  }

  public var marketMcapToTvlRatio: Swift.Optional<order_by?> {
    get {
      return graphQLMap["market_mcap_to_tvl_ratio"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_mcap_to_tvl_ratio")
    }
  }

  public var marketTotalValueLocked: Swift.Optional<order_by?> {
    get {
      return graphQLMap["market_total_value_locked"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_total_value_locked")
    }
  }

  public var name: Swift.Optional<order_by?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var priceChange_1m: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_1m"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1m")
    }
  }

  public var priceChange_1w: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_1w"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1w")
    }
  }

  public var priceChange_1y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_1y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1y")
    }
  }

  public var priceChange_3m: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_3m"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_3m")
    }
  }

  public var priceChange_5y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_5y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_5y")
    }
  }

  public var priceChangeAll: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_all"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_all")
    }
  }

  public var publicInterestScore: Swift.Optional<order_by?> {
    get {
      return graphQLMap["public_interest_score"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "public_interest_score")
    }
  }

  public var sentimentVotesDownPercentage: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sentiment_votes_down_percentage"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sentiment_votes_down_percentage")
    }
  }

  public var sentimentVotesUpPercentage: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sentiment_votes_up_percentage"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sentiment_votes_up_percentage")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// Ordering options when selecting data from "public_220413044555.crypto_realtime_metrics".
public struct crypto_realtime_metrics_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - ath
  ///   - atl
  ///   - circulatingSupply
  ///   - high_24h
  ///   - low_24h
  ///   - marketCapiptalization
  ///   - maxSupply
  ///   - symbol
  ///   - totalSupply
  ///   - volume_24h
  public init(ath: Swift.Optional<order_by?> = nil, atl: Swift.Optional<order_by?> = nil, circulatingSupply: Swift.Optional<order_by?> = nil, high_24h: Swift.Optional<order_by?> = nil, low_24h: Swift.Optional<order_by?> = nil, marketCapiptalization: Swift.Optional<order_by?> = nil, maxSupply: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, totalSupply: Swift.Optional<order_by?> = nil, volume_24h: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["ath": ath, "atl": atl, "circulating_supply": circulatingSupply, "high_24h": high_24h, "low_24h": low_24h, "market_capiptalization": marketCapiptalization, "max_supply": maxSupply, "symbol": symbol, "total_supply": totalSupply, "volume_24h": volume_24h]
  }

  public var ath: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ath"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ath")
    }
  }

  public var atl: Swift.Optional<order_by?> {
    get {
      return graphQLMap["atl"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "atl")
    }
  }

  public var circulatingSupply: Swift.Optional<order_by?> {
    get {
      return graphQLMap["circulating_supply"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "circulating_supply")
    }
  }

  public var high_24h: Swift.Optional<order_by?> {
    get {
      return graphQLMap["high_24h"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "high_24h")
    }
  }

  public var low_24h: Swift.Optional<order_by?> {
    get {
      return graphQLMap["low_24h"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "low_24h")
    }
  }

  public var marketCapiptalization: Swift.Optional<order_by?> {
    get {
      return graphQLMap["market_capiptalization"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capiptalization")
    }
  }

  public var maxSupply: Swift.Optional<order_by?> {
    get {
      return graphQLMap["max_supply"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max_supply")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var totalSupply: Swift.Optional<order_by?> {
    get {
      return graphQLMap["total_supply"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "total_supply")
    }
  }

  public var volume_24h: Swift.Optional<order_by?> {
    get {
      return graphQLMap["volume_24h"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "volume_24h")
    }
  }
}

/// Ordering options when selecting data from "app.profile_ticker_match_score".
public struct app_profile_ticker_match_score_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryMatches
  ///   - categorySimilarity
  ///   - fitsCategories
  ///   - fitsInterests
  ///   - fitsRisk
  ///   - interestMatches
  ///   - interestSimilarity
  ///   - matchScore
  ///   - matchesPortfolio
  ///   - profile
  ///   - profileId
  ///   - riskSimilarity
  ///   - symbol
  ///   - updatedAt
  public init(categoryMatches: Swift.Optional<order_by?> = nil, categorySimilarity: Swift.Optional<order_by?> = nil, fitsCategories: Swift.Optional<order_by?> = nil, fitsInterests: Swift.Optional<order_by?> = nil, fitsRisk: Swift.Optional<order_by?> = nil, interestMatches: Swift.Optional<order_by?> = nil, interestSimilarity: Swift.Optional<order_by?> = nil, matchScore: Swift.Optional<order_by?> = nil, matchesPortfolio: Swift.Optional<order_by?> = nil, profile: Swift.Optional<app_profiles_order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, riskSimilarity: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_matches": categoryMatches, "category_similarity": categorySimilarity, "fits_categories": fitsCategories, "fits_interests": fitsInterests, "fits_risk": fitsRisk, "interest_matches": interestMatches, "interest_similarity": interestSimilarity, "match_score": matchScore, "matches_portfolio": matchesPortfolio, "profile": profile, "profile_id": profileId, "risk_similarity": riskSimilarity, "symbol": symbol, "updated_at": updatedAt]
  }

  public var categoryMatches: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_matches"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_matches")
    }
  }

  public var categorySimilarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_similarity")
    }
  }

  public var fitsCategories: Swift.Optional<order_by?> {
    get {
      return graphQLMap["fits_categories"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_categories")
    }
  }

  public var fitsInterests: Swift.Optional<order_by?> {
    get {
      return graphQLMap["fits_interests"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_interests")
    }
  }

  public var fitsRisk: Swift.Optional<order_by?> {
    get {
      return graphQLMap["fits_risk"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_risk")
    }
  }

  public var interestMatches: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_matches"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_matches")
    }
  }

  public var interestSimilarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_similarity")
    }
  }

  public var matchScore: Swift.Optional<order_by?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
    }
  }

  public var matchesPortfolio: Swift.Optional<order_by?> {
    get {
      return graphQLMap["matches_portfolio"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "matches_portfolio")
    }
  }

  public var profile: Swift.Optional<app_profiles_order_by?> {
    get {
      return graphQLMap["profile"] as? Swift.Optional<app_profiles_order_by?> ?? Swift.Optional<app_profiles_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var riskSimilarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["risk_similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_similarity")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Ordering options when selecting data from "public_220413044555.ticker_realtime_metrics".
public struct ticker_realtime_metrics_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - absoluteDailyChange
  ///   - actualPrice
  ///   - dailyVolume
  ///   - lastKnownPrice
  ///   - lastKnownPriceDatetime
  ///   - previousDayClosePrice
  ///   - relativeDailyChange
  ///   - symbol
  ///   - time
  public init(absoluteDailyChange: Swift.Optional<order_by?> = nil, actualPrice: Swift.Optional<order_by?> = nil, dailyVolume: Swift.Optional<order_by?> = nil, lastKnownPrice: Swift.Optional<order_by?> = nil, lastKnownPriceDatetime: Swift.Optional<order_by?> = nil, previousDayClosePrice: Swift.Optional<order_by?> = nil, relativeDailyChange: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, time: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "daily_volume": dailyVolume, "last_known_price": lastKnownPrice, "last_known_price_datetime": lastKnownPriceDatetime, "previous_day_close_price": previousDayClosePrice, "relative_daily_change": relativeDailyChange, "symbol": symbol, "time": time]
  }

  public var absoluteDailyChange: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_daily_change"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_daily_change")
    }
  }

  public var actualPrice: Swift.Optional<order_by?> {
    get {
      return graphQLMap["actual_price"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "actual_price")
    }
  }

  public var dailyVolume: Swift.Optional<order_by?> {
    get {
      return graphQLMap["daily_volume"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "daily_volume")
    }
  }

  public var lastKnownPrice: Swift.Optional<order_by?> {
    get {
      return graphQLMap["last_known_price"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_known_price")
    }
  }

  public var lastKnownPriceDatetime: Swift.Optional<order_by?> {
    get {
      return graphQLMap["last_known_price_datetime"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_known_price_datetime")
    }
  }

  public var previousDayClosePrice: Swift.Optional<order_by?> {
    get {
      return graphQLMap["previous_day_close_price"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "previous_day_close_price")
    }
  }

  public var relativeDailyChange: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_daily_change"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_daily_change")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var time: Swift.Optional<order_by?> {
    get {
      return graphQLMap["time"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "time")
    }
  }
}

/// Ordering options when selecting data from "public_220413044555.analyst_ratings".
public struct analyst_ratings_order_by: GraphQLMapConvertible {
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
  public init(buy: Swift.Optional<order_by?> = nil, hold: Swift.Optional<order_by?> = nil, rating: Swift.Optional<order_by?> = nil, sell: Swift.Optional<order_by?> = nil, strongBuy: Swift.Optional<order_by?> = nil, strongSell: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, targetPrice: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["buy": buy, "hold": hold, "rating": rating, "sell": sell, "strong_buy": strongBuy, "strong_sell": strongSell, "symbol": symbol, "target_price": targetPrice]
  }

  public var buy: Swift.Optional<order_by?> {
    get {
      return graphQLMap["buy"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "buy")
    }
  }

  public var hold: Swift.Optional<order_by?> {
    get {
      return graphQLMap["hold"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hold")
    }
  }

  public var rating: Swift.Optional<order_by?> {
    get {
      return graphQLMap["rating"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "rating")
    }
  }

  public var sell: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sell"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sell")
    }
  }

  public var strongBuy: Swift.Optional<order_by?> {
    get {
      return graphQLMap["strong_buy"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "strong_buy")
    }
  }

  public var strongSell: Swift.Optional<order_by?> {
    get {
      return graphQLMap["strong_sell"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "strong_sell")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var targetPrice: Swift.Optional<order_by?> {
    get {
      return graphQLMap["target_price"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "target_price")
    }
  }
}

/// order by aggregate values of table "public_220413044555.ticker_categories"
public struct ticker_categories_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<ticker_categories_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<ticker_categories_max_order_by?> = nil, min: Swift.Optional<ticker_categories_min_order_by?> = nil, stddev: Swift.Optional<ticker_categories_stddev_order_by?> = nil, stddevPop: Swift.Optional<ticker_categories_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<ticker_categories_stddev_samp_order_by?> = nil, sum: Swift.Optional<ticker_categories_sum_order_by?> = nil, varPop: Swift.Optional<ticker_categories_var_pop_order_by?> = nil, varSamp: Swift.Optional<ticker_categories_var_samp_order_by?> = nil, variance: Swift.Optional<ticker_categories_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<ticker_categories_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<ticker_categories_avg_order_by?> ?? Swift.Optional<ticker_categories_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<ticker_categories_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<ticker_categories_max_order_by?> ?? Swift.Optional<ticker_categories_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<ticker_categories_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<ticker_categories_min_order_by?> ?? Swift.Optional<ticker_categories_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<ticker_categories_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<ticker_categories_stddev_order_by?> ?? Swift.Optional<ticker_categories_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<ticker_categories_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<ticker_categories_stddev_pop_order_by?> ?? Swift.Optional<ticker_categories_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<ticker_categories_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<ticker_categories_stddev_samp_order_by?> ?? Swift.Optional<ticker_categories_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<ticker_categories_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<ticker_categories_sum_order_by?> ?? Swift.Optional<ticker_categories_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<ticker_categories_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<ticker_categories_var_pop_order_by?> ?? Swift.Optional<ticker_categories_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<ticker_categories_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<ticker_categories_var_samp_order_by?> ?? Swift.Optional<ticker_categories_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<ticker_categories_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<ticker_categories_variance_order_by?> ?? Swift.Optional<ticker_categories_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  public init(categoryId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }
}

/// order by max() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - id
  ///   - symbol
  ///   - updatedAt
  public init(categoryId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "id": id, "symbol": symbol, "updated_at": updatedAt]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by min() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  ///   - id
  ///   - symbol
  ///   - updatedAt
  public init(categoryId: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId, "id": id, "symbol": symbol, "updated_at": updatedAt]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by stddev() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  public init(categoryId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }
}

/// order by stddev_pop() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  public init(categoryId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }
}

/// order by stddev_samp() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  public init(categoryId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }
}

/// order by sum() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  public init(categoryId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }
}

/// order by var_pop() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  public init(categoryId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }
}

/// order by var_samp() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  public init(categoryId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }
}

/// order by variance() on columns of table "public_220413044555.ticker_categories"
public struct ticker_categories_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryId
  public init(categoryId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["category_id": categoryId]
  }

  public var categoryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["category_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_id")
    }
  }
}

/// order by aggregate values of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<ticker_collections_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<ticker_collections_max_order_by?> = nil, min: Swift.Optional<ticker_collections_min_order_by?> = nil, stddev: Swift.Optional<ticker_collections_stddev_order_by?> = nil, stddevPop: Swift.Optional<ticker_collections_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<ticker_collections_stddev_samp_order_by?> = nil, sum: Swift.Optional<ticker_collections_sum_order_by?> = nil, varPop: Swift.Optional<ticker_collections_var_pop_order_by?> = nil, varSamp: Swift.Optional<ticker_collections_var_samp_order_by?> = nil, variance: Swift.Optional<ticker_collections_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<ticker_collections_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<ticker_collections_avg_order_by?> ?? Swift.Optional<ticker_collections_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<ticker_collections_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<ticker_collections_max_order_by?> ?? Swift.Optional<ticker_collections_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<ticker_collections_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<ticker_collections_min_order_by?> ?? Swift.Optional<ticker_collections_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<ticker_collections_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<ticker_collections_stddev_order_by?> ?? Swift.Optional<ticker_collections_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<ticker_collections_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<ticker_collections_stddev_pop_order_by?> ?? Swift.Optional<ticker_collections_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<ticker_collections_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<ticker_collections_stddev_samp_order_by?> ?? Swift.Optional<ticker_collections_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<ticker_collections_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<ticker_collections_sum_order_by?> ?? Swift.Optional<ticker_collections_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<ticker_collections_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<ticker_collections_var_pop_order_by?> ?? Swift.Optional<ticker_collections_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<ticker_collections_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<ticker_collections_var_samp_order_by?> ?? Swift.Optional<ticker_collections_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<ticker_collections_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<ticker_collections_variance_order_by?> ?? Swift.Optional<ticker_collections_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by max() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  ///   - symbol
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId, "symbol": symbol]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// order by min() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  ///   - symbol
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId, "symbol": symbol]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// order by stddev() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_pop() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by stddev_samp() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by sum() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_pop() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by var_samp() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by variance() on columns of table "public_220413044555.profile_ticker_collections"
public struct ticker_collections_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - profileId
  public init(collectionId: Swift.Optional<order_by?> = nil, profileId: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["collection_id": collectionId, "profile_id": profileId]
  }

  public var collectionId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var profileId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profile_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_id")
    }
  }
}

/// order by aggregate values of table "public_220413044555.ticker_events"
public struct ticker_events_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - count
  ///   - max
  ///   - min
  public init(count: Swift.Optional<order_by?> = nil, max: Swift.Optional<ticker_events_max_order_by?> = nil, min: Swift.Optional<ticker_events_min_order_by?> = nil) {
    graphQLMap = ["count": count, "max": max, "min": min]
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<ticker_events_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<ticker_events_max_order_by?> ?? Swift.Optional<ticker_events_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<ticker_events_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<ticker_events_min_order_by?> ?? Swift.Optional<ticker_events_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }
}

/// order by max() on columns of table "public_220413044555.ticker_events"
public struct ticker_events_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - date
  ///   - description
  ///   - id
  ///   - symbol
  ///   - timestamp
  ///   - type
  public init(createdAt: Swift.Optional<order_by?> = nil, date: Swift.Optional<order_by?> = nil, description: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, timestamp: Swift.Optional<order_by?> = nil, type: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["created_at": createdAt, "date": date, "description": description, "id": id, "symbol": symbol, "timestamp": timestamp, "type": type]
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var date: Swift.Optional<order_by?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var description: Swift.Optional<order_by?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var timestamp: Swift.Optional<order_by?> {
    get {
      return graphQLMap["timestamp"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "timestamp")
    }
  }

  public var type: Swift.Optional<order_by?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }
}

/// order by min() on columns of table "public_220413044555.ticker_events"
public struct ticker_events_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - date
  ///   - description
  ///   - id
  ///   - symbol
  ///   - timestamp
  ///   - type
  public init(createdAt: Swift.Optional<order_by?> = nil, date: Swift.Optional<order_by?> = nil, description: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, timestamp: Swift.Optional<order_by?> = nil, type: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["created_at": createdAt, "date": date, "description": description, "id": id, "symbol": symbol, "timestamp": timestamp, "type": type]
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var date: Swift.Optional<order_by?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var description: Swift.Optional<order_by?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var timestamp: Swift.Optional<order_by?> {
    get {
      return graphQLMap["timestamp"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "timestamp")
    }
  }

  public var type: Swift.Optional<order_by?> {
    get {
      return graphQLMap["type"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "type")
    }
  }
}

/// order by aggregate values of table "public_220413044555.ticker_highlights"
public struct ticker_highlights_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - count
  ///   - max
  ///   - min
  public init(count: Swift.Optional<order_by?> = nil, max: Swift.Optional<ticker_highlights_max_order_by?> = nil, min: Swift.Optional<ticker_highlights_min_order_by?> = nil) {
    graphQLMap = ["count": count, "max": max, "min": min]
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<ticker_highlights_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<ticker_highlights_max_order_by?> ?? Swift.Optional<ticker_highlights_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<ticker_highlights_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<ticker_highlights_min_order_by?> ?? Swift.Optional<ticker_highlights_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }
}

/// order by max() on columns of table "public_220413044555.ticker_highlights"
public struct ticker_highlights_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - highlight
  ///   - id
  ///   - symbol
  public init(createdAt: Swift.Optional<order_by?> = nil, highlight: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["created_at": createdAt, "highlight": highlight, "id": id, "symbol": symbol]
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var highlight: Swift.Optional<order_by?> {
    get {
      return graphQLMap["highlight"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "highlight")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// order by min() on columns of table "public_220413044555.ticker_highlights"
public struct ticker_highlights_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - highlight
  ///   - id
  ///   - symbol
  public init(createdAt: Swift.Optional<order_by?> = nil, highlight: Swift.Optional<order_by?> = nil, id: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["created_at": createdAt, "highlight": highlight, "id": id, "symbol": symbol]
  }

  public var createdAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["created_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "created_at")
    }
  }

  public var highlight: Swift.Optional<order_by?> {
    get {
      return graphQLMap["highlight"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "highlight")
    }
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// order by aggregate values of table "public_220413044555.ticker_industries"
public struct ticker_industries_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<ticker_industries_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<ticker_industries_max_order_by?> = nil, min: Swift.Optional<ticker_industries_min_order_by?> = nil, stddev: Swift.Optional<ticker_industries_stddev_order_by?> = nil, stddevPop: Swift.Optional<ticker_industries_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<ticker_industries_stddev_samp_order_by?> = nil, sum: Swift.Optional<ticker_industries_sum_order_by?> = nil, varPop: Swift.Optional<ticker_industries_var_pop_order_by?> = nil, varSamp: Swift.Optional<ticker_industries_var_samp_order_by?> = nil, variance: Swift.Optional<ticker_industries_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<ticker_industries_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<ticker_industries_avg_order_by?> ?? Swift.Optional<ticker_industries_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<ticker_industries_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<ticker_industries_max_order_by?> ?? Swift.Optional<ticker_industries_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<ticker_industries_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<ticker_industries_min_order_by?> ?? Swift.Optional<ticker_industries_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<ticker_industries_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<ticker_industries_stddev_order_by?> ?? Swift.Optional<ticker_industries_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<ticker_industries_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<ticker_industries_stddev_pop_order_by?> ?? Swift.Optional<ticker_industries_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<ticker_industries_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<ticker_industries_stddev_samp_order_by?> ?? Swift.Optional<ticker_industries_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<ticker_industries_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<ticker_industries_sum_order_by?> ?? Swift.Optional<ticker_industries_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<ticker_industries_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<ticker_industries_var_pop_order_by?> ?? Swift.Optional<ticker_industries_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<ticker_industries_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<ticker_industries_var_samp_order_by?> ?? Swift.Optional<ticker_industries_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<ticker_industries_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<ticker_industries_variance_order_by?> ?? Swift.Optional<ticker_industries_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  public init(industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["industry_id": industryId, "industry_order": industryOrder, "similarity": similarity]
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }
}

/// order by max() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  ///   - symbol
  ///   - updatedAt
  public init(id: Swift.Optional<order_by?> = nil, industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "industry_id": industryId, "industry_order": industryOrder, "similarity": similarity, "symbol": symbol, "updated_at": updatedAt]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by min() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  ///   - symbol
  ///   - updatedAt
  public init(id: Swift.Optional<order_by?> = nil, industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "industry_id": industryId, "industry_order": industryOrder, "similarity": similarity, "symbol": symbol, "updated_at": updatedAt]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by stddev() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  public init(industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["industry_id": industryId, "industry_order": industryOrder, "similarity": similarity]
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }
}

/// order by stddev_pop() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  public init(industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["industry_id": industryId, "industry_order": industryOrder, "similarity": similarity]
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }
}

/// order by stddev_samp() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  public init(industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["industry_id": industryId, "industry_order": industryOrder, "similarity": similarity]
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }
}

/// order by sum() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  public init(industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["industry_id": industryId, "industry_order": industryOrder, "similarity": similarity]
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }
}

/// order by var_pop() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  public init(industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["industry_id": industryId, "industry_order": industryOrder, "similarity": similarity]
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }
}

/// order by var_samp() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  public init(industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["industry_id": industryId, "industry_order": industryOrder, "similarity": similarity]
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }
}

/// order by variance() on columns of table "public_220413044555.ticker_industries"
public struct ticker_industries_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  public init(industryId: Swift.Optional<order_by?> = nil, industryOrder: Swift.Optional<order_by?> = nil, similarity: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["industry_id": industryId, "industry_order": industryOrder, "similarity": similarity]
  }

  public var industryId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<order_by?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
    }
  }
}

/// order by aggregate values of table "public_220413044555.ticker_interests"
public struct ticker_interests_aggregate_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - avg
  ///   - count
  ///   - max
  ///   - min
  ///   - stddev
  ///   - stddevPop
  ///   - stddevSamp
  ///   - sum
  ///   - varPop
  ///   - varSamp
  ///   - variance
  public init(avg: Swift.Optional<ticker_interests_avg_order_by?> = nil, count: Swift.Optional<order_by?> = nil, max: Swift.Optional<ticker_interests_max_order_by?> = nil, min: Swift.Optional<ticker_interests_min_order_by?> = nil, stddev: Swift.Optional<ticker_interests_stddev_order_by?> = nil, stddevPop: Swift.Optional<ticker_interests_stddev_pop_order_by?> = nil, stddevSamp: Swift.Optional<ticker_interests_stddev_samp_order_by?> = nil, sum: Swift.Optional<ticker_interests_sum_order_by?> = nil, varPop: Swift.Optional<ticker_interests_var_pop_order_by?> = nil, varSamp: Swift.Optional<ticker_interests_var_samp_order_by?> = nil, variance: Swift.Optional<ticker_interests_variance_order_by?> = nil) {
    graphQLMap = ["avg": avg, "count": count, "max": max, "min": min, "stddev": stddev, "stddev_pop": stddevPop, "stddev_samp": stddevSamp, "sum": sum, "var_pop": varPop, "var_samp": varSamp, "variance": variance]
  }

  public var avg: Swift.Optional<ticker_interests_avg_order_by?> {
    get {
      return graphQLMap["avg"] as? Swift.Optional<ticker_interests_avg_order_by?> ?? Swift.Optional<ticker_interests_avg_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg")
    }
  }

  public var count: Swift.Optional<order_by?> {
    get {
      return graphQLMap["count"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "count")
    }
  }

  public var max: Swift.Optional<ticker_interests_max_order_by?> {
    get {
      return graphQLMap["max"] as? Swift.Optional<ticker_interests_max_order_by?> ?? Swift.Optional<ticker_interests_max_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max")
    }
  }

  public var min: Swift.Optional<ticker_interests_min_order_by?> {
    get {
      return graphQLMap["min"] as? Swift.Optional<ticker_interests_min_order_by?> ?? Swift.Optional<ticker_interests_min_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "min")
    }
  }

  public var stddev: Swift.Optional<ticker_interests_stddev_order_by?> {
    get {
      return graphQLMap["stddev"] as? Swift.Optional<ticker_interests_stddev_order_by?> ?? Swift.Optional<ticker_interests_stddev_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev")
    }
  }

  public var stddevPop: Swift.Optional<ticker_interests_stddev_pop_order_by?> {
    get {
      return graphQLMap["stddev_pop"] as? Swift.Optional<ticker_interests_stddev_pop_order_by?> ?? Swift.Optional<ticker_interests_stddev_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_pop")
    }
  }

  public var stddevSamp: Swift.Optional<ticker_interests_stddev_samp_order_by?> {
    get {
      return graphQLMap["stddev_samp"] as? Swift.Optional<ticker_interests_stddev_samp_order_by?> ?? Swift.Optional<ticker_interests_stddev_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "stddev_samp")
    }
  }

  public var sum: Swift.Optional<ticker_interests_sum_order_by?> {
    get {
      return graphQLMap["sum"] as? Swift.Optional<ticker_interests_sum_order_by?> ?? Swift.Optional<ticker_interests_sum_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sum")
    }
  }

  public var varPop: Swift.Optional<ticker_interests_var_pop_order_by?> {
    get {
      return graphQLMap["var_pop"] as? Swift.Optional<ticker_interests_var_pop_order_by?> ?? Swift.Optional<ticker_interests_var_pop_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_pop")
    }
  }

  public var varSamp: Swift.Optional<ticker_interests_var_samp_order_by?> {
    get {
      return graphQLMap["var_samp"] as? Swift.Optional<ticker_interests_var_samp_order_by?> ?? Swift.Optional<ticker_interests_var_samp_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "var_samp")
    }
  }

  public var variance: Swift.Optional<ticker_interests_variance_order_by?> {
    get {
      return graphQLMap["variance"] as? Swift.Optional<ticker_interests_variance_order_by?> ?? Swift.Optional<ticker_interests_variance_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "variance")
    }
  }
}

/// order by avg() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_avg_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - simDif
  public init(interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "sim_dif": simDif]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }
}

/// order by max() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_max_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - interestId
  ///   - simDif
  ///   - symbol
  ///   - updatedAt
  public init(id: Swift.Optional<order_by?> = nil, interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "interest_id": interestId, "sim_dif": simDif, "symbol": symbol, "updated_at": updatedAt]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by min() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_min_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - interestId
  ///   - simDif
  ///   - symbol
  ///   - updatedAt
  public init(id: Swift.Optional<order_by?> = nil, interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, updatedAt: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["id": id, "interest_id": interestId, "sim_dif": simDif, "symbol": symbol, "updated_at": updatedAt]
  }

  public var id: Swift.Optional<order_by?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var updatedAt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// order by stddev() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_stddev_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - simDif
  public init(interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "sim_dif": simDif]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }
}

/// order by stddev_pop() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_stddev_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - simDif
  public init(interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "sim_dif": simDif]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }
}

/// order by stddev_samp() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_stddev_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - simDif
  public init(interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "sim_dif": simDif]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }
}

/// order by sum() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_sum_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - simDif
  public init(interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "sim_dif": simDif]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }
}

/// order by var_pop() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_var_pop_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - simDif
  public init(interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "sim_dif": simDif]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }
}

/// order by var_samp() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_var_samp_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - simDif
  public init(interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "sim_dif": simDif]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }
}

/// order by variance() on columns of table "public_220413044555.ticker_interests"
public struct ticker_interests_variance_order_by: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - interestId
  ///   - simDif
  public init(interestId: Swift.Optional<order_by?> = nil, simDif: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["interest_id": interestId, "sim_dif": simDif]
  }

  public var interestId: Swift.Optional<order_by?> {
    get {
      return graphQLMap["interest_id"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_id")
    }
  }

  public var simDif: Swift.Optional<order_by?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
    }
  }
}

/// Ordering options when selecting data from "public_220413044555.ticker_metrics".
public struct ticker_metrics_order_by: GraphQLMapConvertible {
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
  ///   - epsTtm
  ///   - exchangeName
  ///   - impliedVolatility
  ///   - marketCapitalization
  ///   - netDebt
  ///   - netIncome
  ///   - netIncomeTtm
  ///   - priceChange_1m
  ///   - priceChange_1w
  ///   - priceChange_1y
  ///   - priceChange_3m
  ///   - priceChange_5y
  ///   - priceChangeAll
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
  ///   - shortPercent
  ///   - shortPercentOutstanding
  ///   - shortRatio
  ///   - symbol
  ///   - ticker
  ///   - totalAssets
  ///   - yearsOfConsecutiveDividendGrowth
  public init(absoluteHistoricalVolatilityAdjustedCurrent: Swift.Optional<order_by?> = nil, absoluteHistoricalVolatilityAdjustedMax_1y: Swift.Optional<order_by?> = nil, absoluteHistoricalVolatilityAdjustedMin_1y: Swift.Optional<order_by?> = nil, addressCity: Swift.Optional<order_by?> = nil, addressCounty: Swift.Optional<order_by?> = nil, addressFull: Swift.Optional<order_by?> = nil, addressState: Swift.Optional<order_by?> = nil, assetCashAndEquivalents: Swift.Optional<order_by?> = nil, avgVolume_10d: Swift.Optional<order_by?> = nil, avgVolume_90d: Swift.Optional<order_by?> = nil, beatenQuarterlyEpsEstimationCountTtm: Swift.Optional<order_by?> = nil, beta: Swift.Optional<order_by?> = nil, dividendFrequency: Swift.Optional<order_by?> = nil, dividendPayoutRatio: Swift.Optional<order_by?> = nil, dividendYield: Swift.Optional<order_by?> = nil, dividendsPerShare: Swift.Optional<order_by?> = nil, ebitda: Swift.Optional<order_by?> = nil, ebitdaGrowthYoy: Swift.Optional<order_by?> = nil, ebitdaTtm: Swift.Optional<order_by?> = nil, enterpriseValueToEbitda: Swift.Optional<order_by?> = nil, enterpriseValueToSales: Swift.Optional<order_by?> = nil, epsActual: Swift.Optional<order_by?> = nil, epsDifference: Swift.Optional<order_by?> = nil, epsEstimate: Swift.Optional<order_by?> = nil, epsGrowthFwd: Swift.Optional<order_by?> = nil, epsGrowthYoy: Swift.Optional<order_by?> = nil, epsSurprise: Swift.Optional<order_by?> = nil, epsTtm: Swift.Optional<order_by?> = nil, exchangeName: Swift.Optional<order_by?> = nil, impliedVolatility: Swift.Optional<order_by?> = nil, marketCapitalization: Swift.Optional<order_by?> = nil, netDebt: Swift.Optional<order_by?> = nil, netIncome: Swift.Optional<order_by?> = nil, netIncomeTtm: Swift.Optional<order_by?> = nil, priceChange_1m: Swift.Optional<order_by?> = nil, priceChange_1w: Swift.Optional<order_by?> = nil, priceChange_1y: Swift.Optional<order_by?> = nil, priceChange_3m: Swift.Optional<order_by?> = nil, priceChange_5y: Swift.Optional<order_by?> = nil, priceChangeAll: Swift.Optional<order_by?> = nil, priceToBookValue: Swift.Optional<order_by?> = nil, priceToEarningsTtm: Swift.Optional<order_by?> = nil, priceToSalesTtm: Swift.Optional<order_by?> = nil, profitMargin: Swift.Optional<order_by?> = nil, relativeHistoricalVolatilityAdjustedCurrent: Swift.Optional<order_by?> = nil, relativeHistoricalVolatilityAdjustedMax_1y: Swift.Optional<order_by?> = nil, relativeHistoricalVolatilityAdjustedMin_1y: Swift.Optional<order_by?> = nil, revenueActual: Swift.Optional<order_by?> = nil, revenueEstimateAvg_0y: Swift.Optional<order_by?> = nil, revenueGrowthFwd: Swift.Optional<order_by?> = nil, revenueGrowthYoy: Swift.Optional<order_by?> = nil, revenuePerShareTtm: Swift.Optional<order_by?> = nil, revenueTtm: Swift.Optional<order_by?> = nil, roa: Swift.Optional<order_by?> = nil, roi: Swift.Optional<order_by?> = nil, sharesFloat: Swift.Optional<order_by?> = nil, sharesOutstanding: Swift.Optional<order_by?> = nil, shortPercent: Swift.Optional<order_by?> = nil, shortPercentOutstanding: Swift.Optional<order_by?> = nil, shortRatio: Swift.Optional<order_by?> = nil, symbol: Swift.Optional<order_by?> = nil, ticker: Swift.Optional<tickers_order_by?> = nil, totalAssets: Swift.Optional<order_by?> = nil, yearsOfConsecutiveDividendGrowth: Swift.Optional<order_by?> = nil) {
    graphQLMap = ["absolute_historical_volatility_adjusted_current": absoluteHistoricalVolatilityAdjustedCurrent, "absolute_historical_volatility_adjusted_max_1y": absoluteHistoricalVolatilityAdjustedMax_1y, "absolute_historical_volatility_adjusted_min_1y": absoluteHistoricalVolatilityAdjustedMin_1y, "address_city": addressCity, "address_county": addressCounty, "address_full": addressFull, "address_state": addressState, "asset_cash_and_equivalents": assetCashAndEquivalents, "avg_volume_10d": avgVolume_10d, "avg_volume_90d": avgVolume_90d, "beaten_quarterly_eps_estimation_count_ttm": beatenQuarterlyEpsEstimationCountTtm, "beta": beta, "dividend_frequency": dividendFrequency, "dividend_payout_ratio": dividendPayoutRatio, "dividend_yield": dividendYield, "dividends_per_share": dividendsPerShare, "ebitda": ebitda, "ebitda_growth_yoy": ebitdaGrowthYoy, "ebitda_ttm": ebitdaTtm, "enterprise_value_to_ebitda": enterpriseValueToEbitda, "enterprise_value_to_sales": enterpriseValueToSales, "eps_actual": epsActual, "eps_difference": epsDifference, "eps_estimate": epsEstimate, "eps_growth_fwd": epsGrowthFwd, "eps_growth_yoy": epsGrowthYoy, "eps_surprise": epsSurprise, "eps_ttm": epsTtm, "exchange_name": exchangeName, "implied_volatility": impliedVolatility, "market_capitalization": marketCapitalization, "net_debt": netDebt, "net_income": netIncome, "net_income_ttm": netIncomeTtm, "price_change_1m": priceChange_1m, "price_change_1w": priceChange_1w, "price_change_1y": priceChange_1y, "price_change_3m": priceChange_3m, "price_change_5y": priceChange_5y, "price_change_all": priceChangeAll, "price_to_book_value": priceToBookValue, "price_to_earnings_ttm": priceToEarningsTtm, "price_to_sales_ttm": priceToSalesTtm, "profit_margin": profitMargin, "relative_historical_volatility_adjusted_current": relativeHistoricalVolatilityAdjustedCurrent, "relative_historical_volatility_adjusted_max_1y": relativeHistoricalVolatilityAdjustedMax_1y, "relative_historical_volatility_adjusted_min_1y": relativeHistoricalVolatilityAdjustedMin_1y, "revenue_actual": revenueActual, "revenue_estimate_avg_0y": revenueEstimateAvg_0y, "revenue_growth_fwd": revenueGrowthFwd, "revenue_growth_yoy": revenueGrowthYoy, "revenue_per_share_ttm": revenuePerShareTtm, "revenue_ttm": revenueTtm, "roa": roa, "roi": roi, "shares_float": sharesFloat, "shares_outstanding": sharesOutstanding, "short_percent": shortPercent, "short_percent_outstanding": shortPercentOutstanding, "short_ratio": shortRatio, "symbol": symbol, "ticker": ticker, "total_assets": totalAssets, "years_of_consecutive_dividend_growth": yearsOfConsecutiveDividendGrowth]
  }

  public var absoluteHistoricalVolatilityAdjustedCurrent: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_current"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_current")
    }
  }

  public var absoluteHistoricalVolatilityAdjustedMax_1y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_max_1y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_max_1y")
    }
  }

  public var absoluteHistoricalVolatilityAdjustedMin_1y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["absolute_historical_volatility_adjusted_min_1y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "absolute_historical_volatility_adjusted_min_1y")
    }
  }

  public var addressCity: Swift.Optional<order_by?> {
    get {
      return graphQLMap["address_city"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_city")
    }
  }

  public var addressCounty: Swift.Optional<order_by?> {
    get {
      return graphQLMap["address_county"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_county")
    }
  }

  public var addressFull: Swift.Optional<order_by?> {
    get {
      return graphQLMap["address_full"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_full")
    }
  }

  public var addressState: Swift.Optional<order_by?> {
    get {
      return graphQLMap["address_state"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address_state")
    }
  }

  public var assetCashAndEquivalents: Swift.Optional<order_by?> {
    get {
      return graphQLMap["asset_cash_and_equivalents"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "asset_cash_and_equivalents")
    }
  }

  public var avgVolume_10d: Swift.Optional<order_by?> {
    get {
      return graphQLMap["avg_volume_10d"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg_volume_10d")
    }
  }

  public var avgVolume_90d: Swift.Optional<order_by?> {
    get {
      return graphQLMap["avg_volume_90d"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg_volume_90d")
    }
  }

  public var beatenQuarterlyEpsEstimationCountTtm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["beaten_quarterly_eps_estimation_count_ttm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beaten_quarterly_eps_estimation_count_ttm")
    }
  }

  public var beta: Swift.Optional<order_by?> {
    get {
      return graphQLMap["beta"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beta")
    }
  }

  public var dividendFrequency: Swift.Optional<order_by?> {
    get {
      return graphQLMap["dividend_frequency"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_frequency")
    }
  }

  public var dividendPayoutRatio: Swift.Optional<order_by?> {
    get {
      return graphQLMap["dividend_payout_ratio"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_payout_ratio")
    }
  }

  public var dividendYield: Swift.Optional<order_by?> {
    get {
      return graphQLMap["dividend_yield"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividend_yield")
    }
  }

  public var dividendsPerShare: Swift.Optional<order_by?> {
    get {
      return graphQLMap["dividends_per_share"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dividends_per_share")
    }
  }

  public var ebitda: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ebitda"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda")
    }
  }

  public var ebitdaGrowthYoy: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ebitda_growth_yoy"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda_growth_yoy")
    }
  }

  public var ebitdaTtm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["ebitda_ttm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ebitda_ttm")
    }
  }

  public var enterpriseValueToEbitda: Swift.Optional<order_by?> {
    get {
      return graphQLMap["enterprise_value_to_ebitda"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enterprise_value_to_ebitda")
    }
  }

  public var enterpriseValueToSales: Swift.Optional<order_by?> {
    get {
      return graphQLMap["enterprise_value_to_sales"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enterprise_value_to_sales")
    }
  }

  public var epsActual: Swift.Optional<order_by?> {
    get {
      return graphQLMap["eps_actual"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_actual")
    }
  }

  public var epsDifference: Swift.Optional<order_by?> {
    get {
      return graphQLMap["eps_difference"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_difference")
    }
  }

  public var epsEstimate: Swift.Optional<order_by?> {
    get {
      return graphQLMap["eps_estimate"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_estimate")
    }
  }

  public var epsGrowthFwd: Swift.Optional<order_by?> {
    get {
      return graphQLMap["eps_growth_fwd"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_growth_fwd")
    }
  }

  public var epsGrowthYoy: Swift.Optional<order_by?> {
    get {
      return graphQLMap["eps_growth_yoy"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_growth_yoy")
    }
  }

  public var epsSurprise: Swift.Optional<order_by?> {
    get {
      return graphQLMap["eps_surprise"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_surprise")
    }
  }

  public var epsTtm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["eps_ttm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_ttm")
    }
  }

  public var exchangeName: Swift.Optional<order_by?> {
    get {
      return graphQLMap["exchange_name"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange_name")
    }
  }

  public var impliedVolatility: Swift.Optional<order_by?> {
    get {
      return graphQLMap["implied_volatility"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "implied_volatility")
    }
  }

  public var marketCapitalization: Swift.Optional<order_by?> {
    get {
      return graphQLMap["market_capitalization"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capitalization")
    }
  }

  public var netDebt: Swift.Optional<order_by?> {
    get {
      return graphQLMap["net_debt"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_debt")
    }
  }

  public var netIncome: Swift.Optional<order_by?> {
    get {
      return graphQLMap["net_income"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_income")
    }
  }

  public var netIncomeTtm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["net_income_ttm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "net_income_ttm")
    }
  }

  public var priceChange_1m: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_1m"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1m")
    }
  }

  public var priceChange_1w: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_1w"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1w")
    }
  }

  public var priceChange_1y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_1y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1y")
    }
  }

  public var priceChange_3m: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_3m"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_3m")
    }
  }

  public var priceChange_5y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_5y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_5y")
    }
  }

  public var priceChangeAll: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_change_all"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_all")
    }
  }

  public var priceToBookValue: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_to_book_value"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_book_value")
    }
  }

  public var priceToEarningsTtm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_to_earnings_ttm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_earnings_ttm")
    }
  }

  public var priceToSalesTtm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["price_to_sales_ttm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_to_sales_ttm")
    }
  }

  public var profitMargin: Swift.Optional<order_by?> {
    get {
      return graphQLMap["profit_margin"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profit_margin")
    }
  }

  public var relativeHistoricalVolatilityAdjustedCurrent: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_current"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_current")
    }
  }

  public var relativeHistoricalVolatilityAdjustedMax_1y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_max_1y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_max_1y")
    }
  }

  public var relativeHistoricalVolatilityAdjustedMin_1y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["relative_historical_volatility_adjusted_min_1y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_historical_volatility_adjusted_min_1y")
    }
  }

  public var revenueActual: Swift.Optional<order_by?> {
    get {
      return graphQLMap["revenue_actual"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_actual")
    }
  }

  public var revenueEstimateAvg_0y: Swift.Optional<order_by?> {
    get {
      return graphQLMap["revenue_estimate_avg_0y"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_estimate_avg_0y")
    }
  }

  public var revenueGrowthFwd: Swift.Optional<order_by?> {
    get {
      return graphQLMap["revenue_growth_fwd"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_growth_fwd")
    }
  }

  public var revenueGrowthYoy: Swift.Optional<order_by?> {
    get {
      return graphQLMap["revenue_growth_yoy"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_growth_yoy")
    }
  }

  public var revenuePerShareTtm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["revenue_per_share_ttm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_per_share_ttm")
    }
  }

  public var revenueTtm: Swift.Optional<order_by?> {
    get {
      return graphQLMap["revenue_ttm"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "revenue_ttm")
    }
  }

  public var roa: Swift.Optional<order_by?> {
    get {
      return graphQLMap["roa"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "roa")
    }
  }

  public var roi: Swift.Optional<order_by?> {
    get {
      return graphQLMap["roi"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "roi")
    }
  }

  public var sharesFloat: Swift.Optional<order_by?> {
    get {
      return graphQLMap["shares_float"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "shares_float")
    }
  }

  public var sharesOutstanding: Swift.Optional<order_by?> {
    get {
      return graphQLMap["shares_outstanding"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "shares_outstanding")
    }
  }

  public var shortPercent: Swift.Optional<order_by?> {
    get {
      return graphQLMap["short_percent"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_percent")
    }
  }

  public var shortPercentOutstanding: Swift.Optional<order_by?> {
    get {
      return graphQLMap["short_percent_outstanding"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_percent_outstanding")
    }
  }

  public var shortRatio: Swift.Optional<order_by?> {
    get {
      return graphQLMap["short_ratio"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_ratio")
    }
  }

  public var symbol: Swift.Optional<order_by?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }

  public var ticker: Swift.Optional<tickers_order_by?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_order_by?> ?? Swift.Optional<tickers_order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }

  public var totalAssets: Swift.Optional<order_by?> {
    get {
      return graphQLMap["total_assets"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "total_assets")
    }
  }

  public var yearsOfConsecutiveDividendGrowth: Swift.Optional<order_by?> {
    get {
      return graphQLMap["years_of_consecutive_dividend_growth"] as? Swift.Optional<order_by?> ?? Swift.Optional<order_by?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "years_of_consecutive_dividend_growth")
    }
  }
}

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

/// input type for inserting object relation for remote table "public_220413044555.portfolio_gains"
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

/// input type for inserting data into table "public_220413044555.portfolio_gains"
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

/// on conflict condition type for table "public_220413044555.portfolio_gains"
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

/// unique or primary key constraints on table "public_220413044555.portfolio_gains"
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

/// update columns of table "public_220413044555.portfolio_gains"
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

/// Boolean expression to filter rows from the table "public_220413044555.portfolio_gains". All fields are combined with a logical 'AND'.
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
  ///   - collection
  ///   - collectionId
  ///   - profile
  ///   - profileId
  public init(_and: Swift.Optional<[app_profile_favorite_collections_bool_exp]?> = nil, _not: Swift.Optional<app_profile_favorite_collections_bool_exp?> = nil, _or: Swift.Optional<[app_profile_favorite_collections_bool_exp]?> = nil, collection: Swift.Optional<collections_bool_exp?> = nil, collectionId: Swift.Optional<Int_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "collection": collection, "collection_id": collectionId, "profile": profile, "profile_id": profileId]
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

  public var collection: Swift.Optional<collections_bool_exp?> {
    get {
      return graphQLMap["collection"] as? Swift.Optional<collections_bool_exp?> ?? Swift.Optional<collections_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection")
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

/// Boolean expression to filter rows from the table "public_220413044555.profile_collections". All fields are combined with a logical 'AND'.
public struct collections_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - description
  ///   - enabled
  ///   - id
  ///   - imageUrl
  ///   - matchScore
  ///   - matchScoreExplanation
  ///   - metrics
  ///   - name
  ///   - personalized
  ///   - profile
  ///   - profileId
  ///   - size
  ///   - tickerCollections
  ///   - uniqId
  public init(_and: Swift.Optional<[collections_bool_exp]?> = nil, _not: Swift.Optional<collections_bool_exp?> = nil, _or: Swift.Optional<[collections_bool_exp]?> = nil, description: Swift.Optional<String_comparison_exp?> = nil, enabled: Swift.Optional<String_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, imageUrl: Swift.Optional<String_comparison_exp?> = nil, matchScore: Swift.Optional<collection_match_score_bool_exp?> = nil, matchScoreExplanation: Swift.Optional<collection_match_score_explanation_bool_exp?> = nil, metrics: Swift.Optional<collection_metrics_bool_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, personalized: Swift.Optional<String_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, size: Swift.Optional<Int_comparison_exp?> = nil, tickerCollections: Swift.Optional<ticker_collections_bool_exp?> = nil, uniqId: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "description": description, "enabled": enabled, "id": id, "image_url": imageUrl, "match_score": matchScore, "match_score_explanation": matchScoreExplanation, "metrics": metrics, "name": name, "personalized": personalized, "profile": profile, "profile_id": profileId, "size": size, "ticker_collections": tickerCollections, "uniq_id": uniqId]
  }

  public var _and: Swift.Optional<[collections_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[collections_bool_exp]?> ?? Swift.Optional<[collections_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<collections_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<collections_bool_exp?> ?? Swift.Optional<collections_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[collections_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[collections_bool_exp]?> ?? Swift.Optional<[collections_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
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

  public var enabled: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["enabled"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enabled")
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

  public var imageUrl: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["image_url"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_url")
    }
  }

  public var matchScore: Swift.Optional<collection_match_score_bool_exp?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<collection_match_score_bool_exp?> ?? Swift.Optional<collection_match_score_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
    }
  }

  public var matchScoreExplanation: Swift.Optional<collection_match_score_explanation_bool_exp?> {
    get {
      return graphQLMap["match_score_explanation"] as? Swift.Optional<collection_match_score_explanation_bool_exp?> ?? Swift.Optional<collection_match_score_explanation_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score_explanation")
    }
  }

  public var metrics: Swift.Optional<collection_metrics_bool_exp?> {
    get {
      return graphQLMap["metrics"] as? Swift.Optional<collection_metrics_bool_exp?> ?? Swift.Optional<collection_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "metrics")
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

  public var personalized: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["personalized"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "personalized")
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

  public var size: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["size"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
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

  public var uniqId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["uniq_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "uniq_id")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.collection_match_score". All fields are combined with a logical 'AND'.
public struct collection_match_score_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - categoryLevel
  ///   - categorySimilarity
  ///   - collectionId
  ///   - collectionUniqId
  ///   - interestLevel
  ///   - interestSimilarity
  ///   - matchScore
  ///   - profile
  ///   - profileId
  ///   - riskLevel
  ///   - riskSimilarity
  public init(_and: Swift.Optional<[collection_match_score_bool_exp]?> = nil, _not: Swift.Optional<collection_match_score_bool_exp?> = nil, _or: Swift.Optional<[collection_match_score_bool_exp]?> = nil, categoryLevel: Swift.Optional<Int_comparison_exp?> = nil, categorySimilarity: Swift.Optional<float8_comparison_exp?> = nil, collectionId: Swift.Optional<Int_comparison_exp?> = nil, collectionUniqId: Swift.Optional<String_comparison_exp?> = nil, interestLevel: Swift.Optional<Int_comparison_exp?> = nil, interestSimilarity: Swift.Optional<float8_comparison_exp?> = nil, matchScore: Swift.Optional<float8_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, riskLevel: Swift.Optional<Int_comparison_exp?> = nil, riskSimilarity: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "category_level": categoryLevel, "category_similarity": categorySimilarity, "collection_id": collectionId, "collection_uniq_id": collectionUniqId, "interest_level": interestLevel, "interest_similarity": interestSimilarity, "match_score": matchScore, "profile": profile, "profile_id": profileId, "risk_level": riskLevel, "risk_similarity": riskSimilarity]
  }

  public var _and: Swift.Optional<[collection_match_score_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[collection_match_score_bool_exp]?> ?? Swift.Optional<[collection_match_score_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<collection_match_score_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<collection_match_score_bool_exp?> ?? Swift.Optional<collection_match_score_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[collection_match_score_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[collection_match_score_bool_exp]?> ?? Swift.Optional<[collection_match_score_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var categoryLevel: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["category_level"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_level")
    }
  }

  public var categorySimilarity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["category_similarity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_similarity")
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

  public var collectionUniqId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["collection_uniq_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_uniq_id")
    }
  }

  public var interestLevel: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["interest_level"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_level")
    }
  }

  public var interestSimilarity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["interest_similarity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_similarity")
    }
  }

  public var matchScore: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
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

  public var riskLevel: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["risk_level"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_level")
    }
  }

  public var riskSimilarity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["risk_similarity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_similarity")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.collection_match_score_explanation". All fields are combined with a logical 'AND'.
public struct collection_match_score_explanation_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - category
  ///   - categoryId
  ///   - collectionId
  ///   - collectionUniqId
  ///   - interest
  ///   - interestId
  ///   - profile
  ///   - profileId
  public init(_and: Swift.Optional<[collection_match_score_explanation_bool_exp]?> = nil, _not: Swift.Optional<collection_match_score_explanation_bool_exp?> = nil, _or: Swift.Optional<[collection_match_score_explanation_bool_exp]?> = nil, category: Swift.Optional<categories_bool_exp?> = nil, categoryId: Swift.Optional<Int_comparison_exp?> = nil, collectionId: Swift.Optional<Int_comparison_exp?> = nil, collectionUniqId: Swift.Optional<String_comparison_exp?> = nil, interest: Swift.Optional<interests_bool_exp?> = nil, interestId: Swift.Optional<Int_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "category": category, "category_id": categoryId, "collection_id": collectionId, "collection_uniq_id": collectionUniqId, "interest": interest, "interest_id": interestId, "profile": profile, "profile_id": profileId]
  }

  public var _and: Swift.Optional<[collection_match_score_explanation_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[collection_match_score_explanation_bool_exp]?> ?? Swift.Optional<[collection_match_score_explanation_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<collection_match_score_explanation_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<collection_match_score_explanation_bool_exp?> ?? Swift.Optional<collection_match_score_explanation_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[collection_match_score_explanation_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[collection_match_score_explanation_bool_exp]?> ?? Swift.Optional<[collection_match_score_explanation_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var category: Swift.Optional<categories_bool_exp?> {
    get {
      return graphQLMap["category"] as? Swift.Optional<categories_bool_exp?> ?? Swift.Optional<categories_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category")
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

  public var collectionId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var collectionUniqId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["collection_uniq_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_uniq_id")
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

/// Boolean expression to filter rows from the table "public_220413044555.categories". All fields are combined with a logical 'AND'.
public struct categories_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - collectionId
  ///   - iconUrl
  ///   - id
  ///   - name
  ///   - riskScore
  ///   - updatedAt
  public init(_and: Swift.Optional<[categories_bool_exp]?> = nil, _not: Swift.Optional<categories_bool_exp?> = nil, _or: Swift.Optional<[categories_bool_exp]?> = nil, collectionId: Swift.Optional<Int_comparison_exp?> = nil, iconUrl: Swift.Optional<String_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, riskScore: Swift.Optional<Int_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "collection_id": collectionId, "icon_url": iconUrl, "id": id, "name": name, "risk_score": riskScore, "updated_at": updatedAt]
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

  public var collectionId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
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

  public var updatedAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.interests". All fields are combined with a logical 'AND'.
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
  ///   - updatedAt
  public init(_and: Swift.Optional<[interests_bool_exp]?> = nil, _not: Swift.Optional<interests_bool_exp?> = nil, _or: Swift.Optional<[interests_bool_exp]?> = nil, enabled: Swift.Optional<String_comparison_exp?> = nil, iconUrl: Swift.Optional<String_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, tickerInterests: Swift.Optional<ticker_interests_bool_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "enabled": enabled, "icon_url": iconUrl, "id": id, "name": name, "ticker_interests": tickerInterests, "updated_at": updatedAt]
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

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.ticker_interests". All fields are combined with a logical 'AND'.
public struct ticker_interests_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - id
  ///   - interest
  ///   - interestId
  ///   - simDif
  ///   - symbol
  ///   - ticker
  ///   - updatedAt
  public init(_and: Swift.Optional<[ticker_interests_bool_exp]?> = nil, _not: Swift.Optional<ticker_interests_bool_exp?> = nil, _or: Swift.Optional<[ticker_interests_bool_exp]?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, interest: Swift.Optional<interests_bool_exp?> = nil, interestId: Swift.Optional<Int_comparison_exp?> = nil, simDif: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "id": id, "interest": interest, "interest_id": interestId, "sim_dif": simDif, "symbol": symbol, "ticker": ticker, "updated_at": updatedAt]
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

  public var id: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
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

  public var simDif: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
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

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.tickers". All fields are combined with a logical 'AND'.
public struct tickers_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - countryName
  ///   - cryptoMetrics
  ///   - cryptoRealtimeMetrics
  ///   - description
  ///   - exchange
  ///   - exchangeCanonical
  ///   - gicGroup
  ///   - gicIndustry
  ///   - gicSector
  ///   - gicSubIndustry
  ///   - industry
  ///   - ipoDate
  ///   - logoUrl
  ///   - matchScore
  ///   - name
  ///   - phone
  ///   - realtimeMetrics
  ///   - sector
  ///   - symbol
  ///   - tickerAnalystRatings
  ///   - tickerCategories
  ///   - tickerCollections
  ///   - tickerEvents
  ///   - tickerHighlights
  ///   - tickerIndustries
  ///   - tickerInterests
  ///   - tickerMetrics
  ///   - type
  ///   - updatedAt
  ///   - webUrl
  public init(_and: Swift.Optional<[tickers_bool_exp]?> = nil, _not: Swift.Optional<tickers_bool_exp?> = nil, _or: Swift.Optional<[tickers_bool_exp]?> = nil, countryName: Swift.Optional<String_comparison_exp?> = nil, cryptoMetrics: Swift.Optional<crypto_metrics_bool_exp?> = nil, cryptoRealtimeMetrics: Swift.Optional<crypto_realtime_metrics_bool_exp?> = nil, description: Swift.Optional<String_comparison_exp?> = nil, exchange: Swift.Optional<String_comparison_exp?> = nil, exchangeCanonical: Swift.Optional<String_comparison_exp?> = nil, gicGroup: Swift.Optional<String_comparison_exp?> = nil, gicIndustry: Swift.Optional<String_comparison_exp?> = nil, gicSector: Swift.Optional<String_comparison_exp?> = nil, gicSubIndustry: Swift.Optional<String_comparison_exp?> = nil, industry: Swift.Optional<String_comparison_exp?> = nil, ipoDate: Swift.Optional<date_comparison_exp?> = nil, logoUrl: Swift.Optional<String_comparison_exp?> = nil, matchScore: Swift.Optional<app_profile_ticker_match_score_bool_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, phone: Swift.Optional<String_comparison_exp?> = nil, realtimeMetrics: Swift.Optional<ticker_realtime_metrics_bool_exp?> = nil, sector: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, tickerAnalystRatings: Swift.Optional<analyst_ratings_bool_exp?> = nil, tickerCategories: Swift.Optional<ticker_categories_bool_exp?> = nil, tickerCollections: Swift.Optional<ticker_collections_bool_exp?> = nil, tickerEvents: Swift.Optional<ticker_events_bool_exp?> = nil, tickerHighlights: Swift.Optional<ticker_highlights_bool_exp?> = nil, tickerIndustries: Swift.Optional<ticker_industries_bool_exp?> = nil, tickerInterests: Swift.Optional<ticker_interests_bool_exp?> = nil, tickerMetrics: Swift.Optional<ticker_metrics_bool_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil, webUrl: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "country_name": countryName, "crypto_metrics": cryptoMetrics, "crypto_realtime_metrics": cryptoRealtimeMetrics, "description": description, "exchange": exchange, "exchange_canonical": exchangeCanonical, "gic_group": gicGroup, "gic_industry": gicIndustry, "gic_sector": gicSector, "gic_sub_industry": gicSubIndustry, "industry": industry, "ipo_date": ipoDate, "logo_url": logoUrl, "match_score": matchScore, "name": name, "phone": phone, "realtime_metrics": realtimeMetrics, "sector": sector, "symbol": symbol, "ticker_analyst_ratings": tickerAnalystRatings, "ticker_categories": tickerCategories, "ticker_collections": tickerCollections, "ticker_events": tickerEvents, "ticker_highlights": tickerHighlights, "ticker_industries": tickerIndustries, "ticker_interests": tickerInterests, "ticker_metrics": tickerMetrics, "type": type, "updated_at": updatedAt, "web_url": webUrl]
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

  public var cryptoMetrics: Swift.Optional<crypto_metrics_bool_exp?> {
    get {
      return graphQLMap["crypto_metrics"] as? Swift.Optional<crypto_metrics_bool_exp?> ?? Swift.Optional<crypto_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "crypto_metrics")
    }
  }

  public var cryptoRealtimeMetrics: Swift.Optional<crypto_realtime_metrics_bool_exp?> {
    get {
      return graphQLMap["crypto_realtime_metrics"] as? Swift.Optional<crypto_realtime_metrics_bool_exp?> ?? Swift.Optional<crypto_realtime_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "crypto_realtime_metrics")
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

  public var exchange: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["exchange"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange")
    }
  }

  public var exchangeCanonical: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["exchange_canonical"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange_canonical")
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

  public var matchScore: Swift.Optional<app_profile_ticker_match_score_bool_exp?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<app_profile_ticker_match_score_bool_exp?> ?? Swift.Optional<app_profile_ticker_match_score_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
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

/// Boolean expression to filter rows from the table "public_220413044555.crypto_metrics". All fields are combined with a logical 'AND'.
public struct crypto_metrics_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - alexaRank
  ///   - assetPlatformId
  ///   - bingMatches
  ///   - categories
  ///   - coingeckoRank
  ///   - coingeckoScore
  ///   - communityFacebookLikes
  ///   - communityRedditAccountsActive_48h
  ///   - communityRedditAverageComments_48h
  ///   - communityRedditAveragePosts_48h
  ///   - communityRedditSubscribers
  ///   - communityScore
  ///   - communityTelegramChannelUserCount
  ///   - communityTwitterFollowers
  ///   - countryOrigin
  ///   - description
  ///   - developmentClosedIssues
  ///   - developmentCodeAdditionsDeletions_4WeeksAdditions
  ///   - developmentCodeAdditionsDeletions_4WeeksDeletions
  ///   - developmentCommitCount_4Weeks
  ///   - developmentForks
  ///   - developmentPullRequestContributors
  ///   - developmentPullRequestsMerged
  ///   - developmentScore
  ///   - developmentStars
  ///   - developmentSubscribers
  ///   - developmentTotalIssues
  ///   - hashingAlgorithm
  ///   - icoEndDate
  ///   - icoStartDate
  ///   - imageLarge
  ///   - imageSmall
  ///   - imageThumb
  ///   - links
  ///   - liquidityScore
  ///   - marketCapRank
  ///   - marketFdvToTvlRatio
  ///   - marketMcapToTvlRatio
  ///   - marketTotalValueLocked
  ///   - name
  ///   - priceChange_1m
  ///   - priceChange_1w
  ///   - priceChange_1y
  ///   - priceChange_3m
  ///   - priceChange_5y
  ///   - priceChangeAll
  ///   - publicInterestScore
  ///   - sentimentVotesDownPercentage
  ///   - sentimentVotesUpPercentage
  ///   - symbol
  public init(_and: Swift.Optional<[crypto_metrics_bool_exp]?> = nil, _not: Swift.Optional<crypto_metrics_bool_exp?> = nil, _or: Swift.Optional<[crypto_metrics_bool_exp]?> = nil, alexaRank: Swift.Optional<Int_comparison_exp?> = nil, assetPlatformId: Swift.Optional<String_comparison_exp?> = nil, bingMatches: Swift.Optional<Int_comparison_exp?> = nil, categories: Swift.Optional<jsonb_comparison_exp?> = nil, coingeckoRank: Swift.Optional<Int_comparison_exp?> = nil, coingeckoScore: Swift.Optional<float8_comparison_exp?> = nil, communityFacebookLikes: Swift.Optional<Int_comparison_exp?> = nil, communityRedditAccountsActive_48h: Swift.Optional<Int_comparison_exp?> = nil, communityRedditAverageComments_48h: Swift.Optional<float8_comparison_exp?> = nil, communityRedditAveragePosts_48h: Swift.Optional<float8_comparison_exp?> = nil, communityRedditSubscribers: Swift.Optional<Int_comparison_exp?> = nil, communityScore: Swift.Optional<float8_comparison_exp?> = nil, communityTelegramChannelUserCount: Swift.Optional<Int_comparison_exp?> = nil, communityTwitterFollowers: Swift.Optional<Int_comparison_exp?> = nil, countryOrigin: Swift.Optional<String_comparison_exp?> = nil, description: Swift.Optional<String_comparison_exp?> = nil, developmentClosedIssues: Swift.Optional<Int_comparison_exp?> = nil, developmentCodeAdditionsDeletions_4WeeksAdditions: Swift.Optional<Int_comparison_exp?> = nil, developmentCodeAdditionsDeletions_4WeeksDeletions: Swift.Optional<Int_comparison_exp?> = nil, developmentCommitCount_4Weeks: Swift.Optional<Int_comparison_exp?> = nil, developmentForks: Swift.Optional<Int_comparison_exp?> = nil, developmentPullRequestContributors: Swift.Optional<Int_comparison_exp?> = nil, developmentPullRequestsMerged: Swift.Optional<Int_comparison_exp?> = nil, developmentScore: Swift.Optional<float8_comparison_exp?> = nil, developmentStars: Swift.Optional<Int_comparison_exp?> = nil, developmentSubscribers: Swift.Optional<Int_comparison_exp?> = nil, developmentTotalIssues: Swift.Optional<Int_comparison_exp?> = nil, hashingAlgorithm: Swift.Optional<String_comparison_exp?> = nil, icoEndDate: Swift.Optional<date_comparison_exp?> = nil, icoStartDate: Swift.Optional<date_comparison_exp?> = nil, imageLarge: Swift.Optional<String_comparison_exp?> = nil, imageSmall: Swift.Optional<String_comparison_exp?> = nil, imageThumb: Swift.Optional<String_comparison_exp?> = nil, links: Swift.Optional<jsonb_comparison_exp?> = nil, liquidityScore: Swift.Optional<float8_comparison_exp?> = nil, marketCapRank: Swift.Optional<Int_comparison_exp?> = nil, marketFdvToTvlRatio: Swift.Optional<float8_comparison_exp?> = nil, marketMcapToTvlRatio: Swift.Optional<float8_comparison_exp?> = nil, marketTotalValueLocked: Swift.Optional<float8_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, priceChange_1m: Swift.Optional<float8_comparison_exp?> = nil, priceChange_1w: Swift.Optional<float8_comparison_exp?> = nil, priceChange_1y: Swift.Optional<float8_comparison_exp?> = nil, priceChange_3m: Swift.Optional<float8_comparison_exp?> = nil, priceChange_5y: Swift.Optional<float8_comparison_exp?> = nil, priceChangeAll: Swift.Optional<float8_comparison_exp?> = nil, publicInterestScore: Swift.Optional<float8_comparison_exp?> = nil, sentimentVotesDownPercentage: Swift.Optional<float8_comparison_exp?> = nil, sentimentVotesUpPercentage: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "alexa_rank": alexaRank, "asset_platform_id": assetPlatformId, "bing_matches": bingMatches, "categories": categories, "coingecko_rank": coingeckoRank, "coingecko_score": coingeckoScore, "community_facebook_likes": communityFacebookLikes, "community_reddit_accounts_active_48h": communityRedditAccountsActive_48h, "community_reddit_average_comments_48h": communityRedditAverageComments_48h, "community_reddit_average_posts_48h": communityRedditAveragePosts_48h, "community_reddit_subscribers": communityRedditSubscribers, "community_score": communityScore, "community_telegram_channel_user_count": communityTelegramChannelUserCount, "community_twitter_followers": communityTwitterFollowers, "country_origin": countryOrigin, "description": description, "development_closed_issues": developmentClosedIssues, "development_code_additions_deletions_4_weeks_additions": developmentCodeAdditionsDeletions_4WeeksAdditions, "development_code_additions_deletions_4_weeks_deletions": developmentCodeAdditionsDeletions_4WeeksDeletions, "development_commit_count_4_weeks": developmentCommitCount_4Weeks, "development_forks": developmentForks, "development_pull_request_contributors": developmentPullRequestContributors, "development_pull_requests_merged": developmentPullRequestsMerged, "development_score": developmentScore, "development_stars": developmentStars, "development_subscribers": developmentSubscribers, "development_total_issues": developmentTotalIssues, "hashing_algorithm": hashingAlgorithm, "ico_end_date": icoEndDate, "ico_start_date": icoStartDate, "image_large": imageLarge, "image_small": imageSmall, "image_thumb": imageThumb, "links": links, "liquidity_score": liquidityScore, "market_cap_rank": marketCapRank, "market_fdv_to_tvl_ratio": marketFdvToTvlRatio, "market_mcap_to_tvl_ratio": marketMcapToTvlRatio, "market_total_value_locked": marketTotalValueLocked, "name": name, "price_change_1m": priceChange_1m, "price_change_1w": priceChange_1w, "price_change_1y": priceChange_1y, "price_change_3m": priceChange_3m, "price_change_5y": priceChange_5y, "price_change_all": priceChangeAll, "public_interest_score": publicInterestScore, "sentiment_votes_down_percentage": sentimentVotesDownPercentage, "sentiment_votes_up_percentage": sentimentVotesUpPercentage, "symbol": symbol]
  }

  public var _and: Swift.Optional<[crypto_metrics_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[crypto_metrics_bool_exp]?> ?? Swift.Optional<[crypto_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<crypto_metrics_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<crypto_metrics_bool_exp?> ?? Swift.Optional<crypto_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[crypto_metrics_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[crypto_metrics_bool_exp]?> ?? Swift.Optional<[crypto_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var alexaRank: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["alexa_rank"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "alexa_rank")
    }
  }

  public var assetPlatformId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["asset_platform_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "asset_platform_id")
    }
  }

  public var bingMatches: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["bing_matches"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "bing_matches")
    }
  }

  public var categories: Swift.Optional<jsonb_comparison_exp?> {
    get {
      return graphQLMap["categories"] as? Swift.Optional<jsonb_comparison_exp?> ?? Swift.Optional<jsonb_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "categories")
    }
  }

  public var coingeckoRank: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["coingecko_rank"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "coingecko_rank")
    }
  }

  public var coingeckoScore: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["coingecko_score"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "coingecko_score")
    }
  }

  public var communityFacebookLikes: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["community_facebook_likes"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_facebook_likes")
    }
  }

  public var communityRedditAccountsActive_48h: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["community_reddit_accounts_active_48h"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_accounts_active_48h")
    }
  }

  public var communityRedditAverageComments_48h: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["community_reddit_average_comments_48h"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_average_comments_48h")
    }
  }

  public var communityRedditAveragePosts_48h: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["community_reddit_average_posts_48h"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_average_posts_48h")
    }
  }

  public var communityRedditSubscribers: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["community_reddit_subscribers"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_subscribers")
    }
  }

  public var communityScore: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["community_score"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_score")
    }
  }

  public var communityTelegramChannelUserCount: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["community_telegram_channel_user_count"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_telegram_channel_user_count")
    }
  }

  public var communityTwitterFollowers: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["community_twitter_followers"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_twitter_followers")
    }
  }

  public var countryOrigin: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["country_origin"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country_origin")
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

  public var developmentClosedIssues: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_closed_issues"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_closed_issues")
    }
  }

  public var developmentCodeAdditionsDeletions_4WeeksAdditions: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_code_additions_deletions_4_weeks_additions"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_code_additions_deletions_4_weeks_additions")
    }
  }

  public var developmentCodeAdditionsDeletions_4WeeksDeletions: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_code_additions_deletions_4_weeks_deletions"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_code_additions_deletions_4_weeks_deletions")
    }
  }

  public var developmentCommitCount_4Weeks: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_commit_count_4_weeks"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_commit_count_4_weeks")
    }
  }

  public var developmentForks: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_forks"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_forks")
    }
  }

  public var developmentPullRequestContributors: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_pull_request_contributors"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_pull_request_contributors")
    }
  }

  public var developmentPullRequestsMerged: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_pull_requests_merged"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_pull_requests_merged")
    }
  }

  public var developmentScore: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["development_score"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_score")
    }
  }

  public var developmentStars: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_stars"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_stars")
    }
  }

  public var developmentSubscribers: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_subscribers"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_subscribers")
    }
  }

  public var developmentTotalIssues: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["development_total_issues"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_total_issues")
    }
  }

  public var hashingAlgorithm: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["hashing_algorithm"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hashing_algorithm")
    }
  }

  public var icoEndDate: Swift.Optional<date_comparison_exp?> {
    get {
      return graphQLMap["ico_end_date"] as? Swift.Optional<date_comparison_exp?> ?? Swift.Optional<date_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ico_end_date")
    }
  }

  public var icoStartDate: Swift.Optional<date_comparison_exp?> {
    get {
      return graphQLMap["ico_start_date"] as? Swift.Optional<date_comparison_exp?> ?? Swift.Optional<date_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ico_start_date")
    }
  }

  public var imageLarge: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["image_large"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_large")
    }
  }

  public var imageSmall: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["image_small"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_small")
    }
  }

  public var imageThumb: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["image_thumb"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_thumb")
    }
  }

  public var links: Swift.Optional<jsonb_comparison_exp?> {
    get {
      return graphQLMap["links"] as? Swift.Optional<jsonb_comparison_exp?> ?? Swift.Optional<jsonb_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "links")
    }
  }

  public var liquidityScore: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["liquidity_score"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "liquidity_score")
    }
  }

  public var marketCapRank: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["market_cap_rank"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_cap_rank")
    }
  }

  public var marketFdvToTvlRatio: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["market_fdv_to_tvl_ratio"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_fdv_to_tvl_ratio")
    }
  }

  public var marketMcapToTvlRatio: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["market_mcap_to_tvl_ratio"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_mcap_to_tvl_ratio")
    }
  }

  public var marketTotalValueLocked: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["market_total_value_locked"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_total_value_locked")
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

  public var priceChange_1m: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_1m"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1m")
    }
  }

  public var priceChange_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1w")
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

  public var priceChange_5y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_5y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_5y")
    }
  }

  public var priceChangeAll: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_all"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_all")
    }
  }

  public var publicInterestScore: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["public_interest_score"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "public_interest_score")
    }
  }

  public var sentimentVotesDownPercentage: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["sentiment_votes_down_percentage"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sentiment_votes_down_percentage")
    }
  }

  public var sentimentVotesUpPercentage: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["sentiment_votes_up_percentage"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sentiment_votes_up_percentage")
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

/// Boolean expression to compare columns of type "jsonb". All fields are combined with logical 'AND'.
public struct jsonb_comparison_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _containedIn: is the column contained in the given json value
  ///   - _contains: does the column contain the given json value at the top level
  ///   - _eq
  ///   - _gt
  ///   - _gte
  ///   - _hasKey: does the string exist as a top-level key in the column
  ///   - _hasKeysAll: do all of these strings exist as top-level keys in the column
  ///   - _hasKeysAny: do any of these strings exist as top-level keys in the column
  ///   - _in
  ///   - _isNull
  ///   - _lt
  ///   - _lte
  ///   - _neq
  ///   - _nin
  public init(_containedIn: Swift.Optional<jsonb?> = nil, _contains: Swift.Optional<jsonb?> = nil, _eq: Swift.Optional<jsonb?> = nil, _gt: Swift.Optional<jsonb?> = nil, _gte: Swift.Optional<jsonb?> = nil, _hasKey: Swift.Optional<String?> = nil, _hasKeysAll: Swift.Optional<[String]?> = nil, _hasKeysAny: Swift.Optional<[String]?> = nil, _in: Swift.Optional<[jsonb]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<jsonb?> = nil, _lte: Swift.Optional<jsonb?> = nil, _neq: Swift.Optional<jsonb?> = nil, _nin: Swift.Optional<[jsonb]?> = nil) {
    graphQLMap = ["_contained_in": _containedIn, "_contains": _contains, "_eq": _eq, "_gt": _gt, "_gte": _gte, "_has_key": _hasKey, "_has_keys_all": _hasKeysAll, "_has_keys_any": _hasKeysAny, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  /// is the column contained in the given json value
  public var _containedIn: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["_contained_in"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_contained_in")
    }
  }

  /// does the column contain the given json value at the top level
  public var _contains: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["_contains"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_contains")
    }
  }

  public var _eq: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  /// does the string exist as a top-level key in the column
  public var _hasKey: Swift.Optional<String?> {
    get {
      return graphQLMap["_has_key"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_has_key")
    }
  }

  /// do all of these strings exist as top-level keys in the column
  public var _hasKeysAll: Swift.Optional<[String]?> {
    get {
      return graphQLMap["_has_keys_all"] as? Swift.Optional<[String]?> ?? Swift.Optional<[String]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_has_keys_all")
    }
  }

  /// do any of these strings exist as top-level keys in the column
  public var _hasKeysAny: Swift.Optional<[String]?> {
    get {
      return graphQLMap["_has_keys_any"] as? Swift.Optional<[String]?> ?? Swift.Optional<[String]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_has_keys_any")
    }
  }

  public var _in: Swift.Optional<[jsonb]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[jsonb]?> ?? Swift.Optional<[jsonb]?>.none
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

  public var _lt: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[jsonb]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[jsonb]?> ?? Swift.Optional<[jsonb]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
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

/// Boolean expression to filter rows from the table "public_220413044555.crypto_realtime_metrics". All fields are combined with a logical 'AND'.
public struct crypto_realtime_metrics_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - ath
  ///   - atl
  ///   - circulatingSupply
  ///   - high_24h
  ///   - low_24h
  ///   - marketCapiptalization
  ///   - maxSupply
  ///   - symbol
  ///   - totalSupply
  ///   - volume_24h
  public init(_and: Swift.Optional<[crypto_realtime_metrics_bool_exp]?> = nil, _not: Swift.Optional<crypto_realtime_metrics_bool_exp?> = nil, _or: Swift.Optional<[crypto_realtime_metrics_bool_exp]?> = nil, ath: Swift.Optional<float8_comparison_exp?> = nil, atl: Swift.Optional<float8_comparison_exp?> = nil, circulatingSupply: Swift.Optional<float8_comparison_exp?> = nil, high_24h: Swift.Optional<float8_comparison_exp?> = nil, low_24h: Swift.Optional<float8_comparison_exp?> = nil, marketCapiptalization: Swift.Optional<float8_comparison_exp?> = nil, maxSupply: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, totalSupply: Swift.Optional<float8_comparison_exp?> = nil, volume_24h: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "ath": ath, "atl": atl, "circulating_supply": circulatingSupply, "high_24h": high_24h, "low_24h": low_24h, "market_capiptalization": marketCapiptalization, "max_supply": maxSupply, "symbol": symbol, "total_supply": totalSupply, "volume_24h": volume_24h]
  }

  public var _and: Swift.Optional<[crypto_realtime_metrics_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[crypto_realtime_metrics_bool_exp]?> ?? Swift.Optional<[crypto_realtime_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<crypto_realtime_metrics_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<crypto_realtime_metrics_bool_exp?> ?? Swift.Optional<crypto_realtime_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[crypto_realtime_metrics_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[crypto_realtime_metrics_bool_exp]?> ?? Swift.Optional<[crypto_realtime_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var ath: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["ath"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ath")
    }
  }

  public var atl: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["atl"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "atl")
    }
  }

  public var circulatingSupply: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["circulating_supply"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "circulating_supply")
    }
  }

  public var high_24h: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["high_24h"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "high_24h")
    }
  }

  public var low_24h: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["low_24h"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "low_24h")
    }
  }

  public var marketCapiptalization: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["market_capiptalization"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capiptalization")
    }
  }

  public var maxSupply: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["max_supply"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max_supply")
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

  public var totalSupply: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["total_supply"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "total_supply")
    }
  }

  public var volume_24h: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["volume_24h"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "volume_24h")
    }
  }
}

/// Boolean expression to filter rows from the table "app.profile_ticker_match_score". All fields are combined with a logical 'AND'.
public struct app_profile_ticker_match_score_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - categoryMatches
  ///   - categorySimilarity
  ///   - fitsCategories
  ///   - fitsInterests
  ///   - fitsRisk
  ///   - interestMatches
  ///   - interestSimilarity
  ///   - matchScore
  ///   - matchesPortfolio
  ///   - profile
  ///   - profileId
  ///   - riskSimilarity
  ///   - symbol
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_profile_ticker_match_score_bool_exp]?> = nil, _not: Swift.Optional<app_profile_ticker_match_score_bool_exp?> = nil, _or: Swift.Optional<[app_profile_ticker_match_score_bool_exp]?> = nil, categoryMatches: Swift.Optional<String_comparison_exp?> = nil, categorySimilarity: Swift.Optional<float8_comparison_exp?> = nil, fitsCategories: Swift.Optional<Int_comparison_exp?> = nil, fitsInterests: Swift.Optional<Int_comparison_exp?> = nil, fitsRisk: Swift.Optional<Int_comparison_exp?> = nil, interestMatches: Swift.Optional<String_comparison_exp?> = nil, interestSimilarity: Swift.Optional<float8_comparison_exp?> = nil, matchScore: Swift.Optional<Int_comparison_exp?> = nil, matchesPortfolio: Swift.Optional<Boolean_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, riskSimilarity: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "category_matches": categoryMatches, "category_similarity": categorySimilarity, "fits_categories": fitsCategories, "fits_interests": fitsInterests, "fits_risk": fitsRisk, "interest_matches": interestMatches, "interest_similarity": interestSimilarity, "match_score": matchScore, "matches_portfolio": matchesPortfolio, "profile": profile, "profile_id": profileId, "risk_similarity": riskSimilarity, "symbol": symbol, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[app_profile_ticker_match_score_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_profile_ticker_match_score_bool_exp]?> ?? Swift.Optional<[app_profile_ticker_match_score_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_profile_ticker_match_score_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_profile_ticker_match_score_bool_exp?> ?? Swift.Optional<app_profile_ticker_match_score_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_profile_ticker_match_score_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_profile_ticker_match_score_bool_exp]?> ?? Swift.Optional<[app_profile_ticker_match_score_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var categoryMatches: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["category_matches"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_matches")
    }
  }

  public var categorySimilarity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["category_similarity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_similarity")
    }
  }

  public var fitsCategories: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["fits_categories"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_categories")
    }
  }

  public var fitsInterests: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["fits_interests"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_interests")
    }
  }

  public var fitsRisk: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["fits_risk"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_risk")
    }
  }

  public var interestMatches: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["interest_matches"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_matches")
    }
  }

  public var interestSimilarity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["interest_similarity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_similarity")
    }
  }

  public var matchScore: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
    }
  }

  public var matchesPortfolio: Swift.Optional<Boolean_comparison_exp?> {
    get {
      return graphQLMap["matches_portfolio"] as? Swift.Optional<Boolean_comparison_exp?> ?? Swift.Optional<Boolean_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "matches_portfolio")
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

  public var riskSimilarity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["risk_similarity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_similarity")
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

  public var updatedAt: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to compare columns of type "Boolean". All fields are combined with logical 'AND'.
public struct Boolean_comparison_exp: GraphQLMapConvertible {
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
  public init(_eq: Swift.Optional<Bool?> = nil, _gt: Swift.Optional<Bool?> = nil, _gte: Swift.Optional<Bool?> = nil, _in: Swift.Optional<[Bool]?> = nil, _isNull: Swift.Optional<Bool?> = nil, _lt: Swift.Optional<Bool?> = nil, _lte: Swift.Optional<Bool?> = nil, _neq: Swift.Optional<Bool?> = nil, _nin: Swift.Optional<[Bool]?> = nil) {
    graphQLMap = ["_eq": _eq, "_gt": _gt, "_gte": _gte, "_in": _in, "_is_null": _isNull, "_lt": _lt, "_lte": _lte, "_neq": _neq, "_nin": _nin]
  }

  public var _eq: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_eq"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_eq")
    }
  }

  public var _gt: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_gt"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gt")
    }
  }

  public var _gte: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_gte"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_gte")
    }
  }

  public var _in: Swift.Optional<[Bool]?> {
    get {
      return graphQLMap["_in"] as? Swift.Optional<[Bool]?> ?? Swift.Optional<[Bool]?>.none
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

  public var _lt: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_lt"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lt")
    }
  }

  public var _lte: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_lte"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_lte")
    }
  }

  public var _neq: Swift.Optional<Bool?> {
    get {
      return graphQLMap["_neq"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_neq")
    }
  }

  public var _nin: Swift.Optional<[Bool]?> {
    get {
      return graphQLMap["_nin"] as? Swift.Optional<[Bool]?> ?? Swift.Optional<[Bool]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_nin")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.ticker_realtime_metrics". All fields are combined with a logical 'AND'.
public struct ticker_realtime_metrics_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - absoluteDailyChange
  ///   - actualPrice
  ///   - dailyVolume
  ///   - lastKnownPrice
  ///   - lastKnownPriceDatetime
  ///   - previousDayClosePrice
  ///   - relativeDailyChange
  ///   - symbol
  ///   - time
  public init(_and: Swift.Optional<[ticker_realtime_metrics_bool_exp]?> = nil, _not: Swift.Optional<ticker_realtime_metrics_bool_exp?> = nil, _or: Swift.Optional<[ticker_realtime_metrics_bool_exp]?> = nil, absoluteDailyChange: Swift.Optional<float8_comparison_exp?> = nil, actualPrice: Swift.Optional<float8_comparison_exp?> = nil, dailyVolume: Swift.Optional<float8_comparison_exp?> = nil, lastKnownPrice: Swift.Optional<float8_comparison_exp?> = nil, lastKnownPriceDatetime: Swift.Optional<timestamp_comparison_exp?> = nil, previousDayClosePrice: Swift.Optional<float8_comparison_exp?> = nil, relativeDailyChange: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, time: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "daily_volume": dailyVolume, "last_known_price": lastKnownPrice, "last_known_price_datetime": lastKnownPriceDatetime, "previous_day_close_price": previousDayClosePrice, "relative_daily_change": relativeDailyChange, "symbol": symbol, "time": time]
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

  public var lastKnownPrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["last_known_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_known_price")
    }
  }

  public var lastKnownPriceDatetime: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["last_known_price_datetime"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_known_price_datetime")
    }
  }

  public var previousDayClosePrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["previous_day_close_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "previous_day_close_price")
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

/// Boolean expression to filter rows from the table "public_220413044555.analyst_ratings". All fields are combined with a logical 'AND'.
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

/// Boolean expression to filter rows from the table "public_220413044555.ticker_categories". All fields are combined with a logical 'AND'.
public struct ticker_categories_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - categories
  ///   - categoryId
  ///   - id
  ///   - symbol
  ///   - updatedAt
  public init(_and: Swift.Optional<[ticker_categories_bool_exp]?> = nil, _not: Swift.Optional<ticker_categories_bool_exp?> = nil, _or: Swift.Optional<[ticker_categories_bool_exp]?> = nil, categories: Swift.Optional<categories_bool_exp?> = nil, categoryId: Swift.Optional<Int_comparison_exp?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "categories": categories, "category_id": categoryId, "id": id, "symbol": symbol, "updated_at": updatedAt]
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

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.profile_ticker_collections". All fields are combined with a logical 'AND'.
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

/// Boolean expression to filter rows from the table "public_220413044555.ticker_events". All fields are combined with a logical 'AND'.
public struct ticker_events_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - createdAt
  ///   - date
  ///   - description
  ///   - id
  ///   - symbol
  ///   - timestamp
  ///   - type
  public init(_and: Swift.Optional<[ticker_events_bool_exp]?> = nil, _not: Swift.Optional<ticker_events_bool_exp?> = nil, _or: Swift.Optional<[ticker_events_bool_exp]?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, description: Swift.Optional<String_comparison_exp?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, timestamp: Swift.Optional<timestamptz_comparison_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "created_at": createdAt, "date": date, "description": description, "id": id, "symbol": symbol, "timestamp": timestamp, "type": type]
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

/// Boolean expression to filter rows from the table "public_220413044555.ticker_highlights". All fields are combined with a logical 'AND'.
public struct ticker_highlights_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - createdAt
  ///   - highlight
  ///   - id
  ///   - symbol
  ///   - ticker
  public init(_and: Swift.Optional<[ticker_highlights_bool_exp]?> = nil, _not: Swift.Optional<ticker_highlights_bool_exp?> = nil, _or: Swift.Optional<[ticker_highlights_bool_exp]?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, highlight: Swift.Optional<String_comparison_exp?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "created_at": createdAt, "highlight": highlight, "id": id, "symbol": symbol, "ticker": ticker]
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

  public var ticker: Swift.Optional<tickers_bool_exp?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_bool_exp?> ?? Swift.Optional<tickers_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.ticker_industries". All fields are combined with a logical 'AND'.
public struct ticker_industries_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - gainyIndustry
  ///   - id
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  ///   - symbol
  ///   - ticker
  ///   - updatedAt
  public init(_and: Swift.Optional<[ticker_industries_bool_exp]?> = nil, _not: Swift.Optional<ticker_industries_bool_exp?> = nil, _or: Swift.Optional<[ticker_industries_bool_exp]?> = nil, gainyIndustry: Swift.Optional<gainy_industries_bool_exp?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, industryId: Swift.Optional<bigint_comparison_exp?> = nil, industryOrder: Swift.Optional<bigint_comparison_exp?> = nil, similarity: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "gainy_industry": gainyIndustry, "id": id, "industry_id": industryId, "industry_order": industryOrder, "similarity": similarity, "symbol": symbol, "ticker": ticker, "updated_at": updatedAt]
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

  public var id: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var industryId: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
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

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.gainy_industries". All fields are combined with a logical 'AND'.
public struct gainy_industries_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - collectionId
  ///   - id
  ///   - industryStatsDailies
  ///   - industryStatsQuarterlies
  ///   - name
  ///   - tickerIndustries
  ///   - tickerIndustryMedian_1m
  ///   - tickerIndustryMedian_1w
  ///   - updatedAt
  public init(_and: Swift.Optional<[gainy_industries_bool_exp]?> = nil, _not: Swift.Optional<gainy_industries_bool_exp?> = nil, _or: Swift.Optional<[gainy_industries_bool_exp]?> = nil, collectionId: Swift.Optional<Int_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, industryStatsDailies: Swift.Optional<industry_stats_daily_bool_exp?> = nil, industryStatsQuarterlies: Swift.Optional<industry_stats_quarterly_bool_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, tickerIndustries: Swift.Optional<ticker_industries_bool_exp?> = nil, tickerIndustryMedian_1m: Swift.Optional<industry_median_1m_bool_exp?> = nil, tickerIndustryMedian_1w: Swift.Optional<industry_median_1w_bool_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "collection_id": collectionId, "id": id, "industry_stats_dailies": industryStatsDailies, "industry_stats_quarterlies": industryStatsQuarterlies, "name": name, "ticker_industries": tickerIndustries, "ticker_industry_median_1m": tickerIndustryMedian_1m, "ticker_industry_median_1w": tickerIndustryMedian_1w, "updated_at": updatedAt]
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

  public var collectionId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
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

  public var updatedAt: Swift.Optional<timestamp_comparison_exp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp_comparison_exp?> ?? Swift.Optional<timestamp_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// Boolean expression to filter rows from the table "public_220413044555.industry_stats_daily". All fields are combined with a logical 'AND'.
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
  ///   - medianPrice
  public init(_and: Swift.Optional<[industry_stats_daily_bool_exp]?> = nil, _not: Swift.Optional<industry_stats_daily_bool_exp?> = nil, _or: Swift.Optional<[industry_stats_daily_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, industryId: Swift.Optional<bigint_comparison_exp?> = nil, medianGrowthRate_1d: Swift.Optional<float8_comparison_exp?> = nil, medianPrice: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "id": id, "industry_id": industryId, "median_growth_rate_1d": medianGrowthRate_1d, "median_price": medianPrice]
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

  public var industryId: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
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

  public var medianPrice: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["median_price"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_price")
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

/// Boolean expression to filter rows from the table "public_220413044555.industry_stats_quarterly". All fields are combined with a logical 'AND'.
public struct industry_stats_quarterly_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - date
  ///   - id
  ///   - industryId
  ///   - medianNetIncome
  ///   - medianRevenue
  public init(_and: Swift.Optional<[industry_stats_quarterly_bool_exp]?> = nil, _not: Swift.Optional<industry_stats_quarterly_bool_exp?> = nil, _or: Swift.Optional<[industry_stats_quarterly_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, id: Swift.Optional<String_comparison_exp?> = nil, industryId: Swift.Optional<bigint_comparison_exp?> = nil, medianNetIncome: Swift.Optional<float8_comparison_exp?> = nil, medianRevenue: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "id": id, "industry_id": industryId, "median_net_income": medianNetIncome, "median_revenue": medianRevenue]
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

  public var id: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var industryId: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
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

/// Boolean expression to filter rows from the table "public_220413044555.industry_median_1m". All fields are combined with a logical 'AND'.
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
  public init(_and: Swift.Optional<[industry_median_1m_bool_exp]?> = nil, _not: Swift.Optional<industry_median_1m_bool_exp?> = nil, _or: Swift.Optional<[industry_median_1m_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, industryId: Swift.Optional<bigint_comparison_exp?> = nil, medianGrowthRate: Swift.Optional<float8_comparison_exp?> = nil, medianPrice: Swift.Optional<float8_comparison_exp?> = nil) {
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

  public var industryId: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
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

/// Boolean expression to filter rows from the table "public_220413044555.industry_median_1w". All fields are combined with a logical 'AND'.
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
  public init(_and: Swift.Optional<[industry_median_1w_bool_exp]?> = nil, _not: Swift.Optional<industry_median_1w_bool_exp?> = nil, _or: Swift.Optional<[industry_median_1w_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, industryId: Swift.Optional<bigint_comparison_exp?> = nil, medianGrowthRate: Swift.Optional<float8_comparison_exp?> = nil, medianPrice: Swift.Optional<float8_comparison_exp?> = nil) {
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

  public var industryId: Swift.Optional<bigint_comparison_exp?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint_comparison_exp?> ?? Swift.Optional<bigint_comparison_exp?>.none
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

/// Boolean expression to filter rows from the table "public_220413044555.ticker_metrics". All fields are combined with a logical 'AND'.
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
  ///   - epsTtm
  ///   - exchangeName
  ///   - impliedVolatility
  ///   - marketCapitalization
  ///   - netDebt
  ///   - netIncome
  ///   - netIncomeTtm
  ///   - priceChange_1m
  ///   - priceChange_1w
  ///   - priceChange_1y
  ///   - priceChange_3m
  ///   - priceChange_5y
  ///   - priceChangeAll
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
  ///   - shortPercent
  ///   - shortPercentOutstanding
  ///   - shortRatio
  ///   - symbol
  ///   - ticker
  ///   - totalAssets
  ///   - yearsOfConsecutiveDividendGrowth
  public init(_and: Swift.Optional<[ticker_metrics_bool_exp]?> = nil, _not: Swift.Optional<ticker_metrics_bool_exp?> = nil, _or: Swift.Optional<[ticker_metrics_bool_exp]?> = nil, absoluteHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8_comparison_exp?> = nil, absoluteHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8_comparison_exp?> = nil, absoluteHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8_comparison_exp?> = nil, addressCity: Swift.Optional<String_comparison_exp?> = nil, addressCounty: Swift.Optional<String_comparison_exp?> = nil, addressFull: Swift.Optional<String_comparison_exp?> = nil, addressState: Swift.Optional<String_comparison_exp?> = nil, assetCashAndEquivalents: Swift.Optional<float8_comparison_exp?> = nil, avgVolume_10d: Swift.Optional<float8_comparison_exp?> = nil, avgVolume_90d: Swift.Optional<float8_comparison_exp?> = nil, beatenQuarterlyEpsEstimationCountTtm: Swift.Optional<Int_comparison_exp?> = nil, beta: Swift.Optional<float8_comparison_exp?> = nil, dividendFrequency: Swift.Optional<String_comparison_exp?> = nil, dividendPayoutRatio: Swift.Optional<float8_comparison_exp?> = nil, dividendYield: Swift.Optional<float8_comparison_exp?> = nil, dividendsPerShare: Swift.Optional<float8_comparison_exp?> = nil, ebitda: Swift.Optional<float8_comparison_exp?> = nil, ebitdaGrowthYoy: Swift.Optional<float8_comparison_exp?> = nil, ebitdaTtm: Swift.Optional<float8_comparison_exp?> = nil, enterpriseValueToEbitda: Swift.Optional<float8_comparison_exp?> = nil, enterpriseValueToSales: Swift.Optional<float8_comparison_exp?> = nil, epsActual: Swift.Optional<float8_comparison_exp?> = nil, epsDifference: Swift.Optional<float8_comparison_exp?> = nil, epsEstimate: Swift.Optional<float8_comparison_exp?> = nil, epsGrowthFwd: Swift.Optional<float8_comparison_exp?> = nil, epsGrowthYoy: Swift.Optional<float8_comparison_exp?> = nil, epsSurprise: Swift.Optional<float8_comparison_exp?> = nil, epsTtm: Swift.Optional<float8_comparison_exp?> = nil, exchangeName: Swift.Optional<String_comparison_exp?> = nil, impliedVolatility: Swift.Optional<float8_comparison_exp?> = nil, marketCapitalization: Swift.Optional<bigint_comparison_exp?> = nil, netDebt: Swift.Optional<float8_comparison_exp?> = nil, netIncome: Swift.Optional<float8_comparison_exp?> = nil, netIncomeTtm: Swift.Optional<float8_comparison_exp?> = nil, priceChange_1m: Swift.Optional<float8_comparison_exp?> = nil, priceChange_1w: Swift.Optional<float8_comparison_exp?> = nil, priceChange_1y: Swift.Optional<float8_comparison_exp?> = nil, priceChange_3m: Swift.Optional<float8_comparison_exp?> = nil, priceChange_5y: Swift.Optional<float8_comparison_exp?> = nil, priceChangeAll: Swift.Optional<float8_comparison_exp?> = nil, priceToBookValue: Swift.Optional<float8_comparison_exp?> = nil, priceToEarningsTtm: Swift.Optional<float8_comparison_exp?> = nil, priceToSalesTtm: Swift.Optional<float8_comparison_exp?> = nil, profitMargin: Swift.Optional<float8_comparison_exp?> = nil, relativeHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8_comparison_exp?> = nil, relativeHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8_comparison_exp?> = nil, relativeHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8_comparison_exp?> = nil, revenueActual: Swift.Optional<float8_comparison_exp?> = nil, revenueEstimateAvg_0y: Swift.Optional<float8_comparison_exp?> = nil, revenueGrowthFwd: Swift.Optional<float8_comparison_exp?> = nil, revenueGrowthYoy: Swift.Optional<float8_comparison_exp?> = nil, revenuePerShareTtm: Swift.Optional<float8_comparison_exp?> = nil, revenueTtm: Swift.Optional<float8_comparison_exp?> = nil, roa: Swift.Optional<float8_comparison_exp?> = nil, roi: Swift.Optional<float8_comparison_exp?> = nil, sharesFloat: Swift.Optional<bigint_comparison_exp?> = nil, sharesOutstanding: Swift.Optional<bigint_comparison_exp?> = nil, shortPercent: Swift.Optional<float8_comparison_exp?> = nil, shortPercentOutstanding: Swift.Optional<float8_comparison_exp?> = nil, shortRatio: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil, totalAssets: Swift.Optional<float8_comparison_exp?> = nil, yearsOfConsecutiveDividendGrowth: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "absolute_historical_volatility_adjusted_current": absoluteHistoricalVolatilityAdjustedCurrent, "absolute_historical_volatility_adjusted_max_1y": absoluteHistoricalVolatilityAdjustedMax_1y, "absolute_historical_volatility_adjusted_min_1y": absoluteHistoricalVolatilityAdjustedMin_1y, "address_city": addressCity, "address_county": addressCounty, "address_full": addressFull, "address_state": addressState, "asset_cash_and_equivalents": assetCashAndEquivalents, "avg_volume_10d": avgVolume_10d, "avg_volume_90d": avgVolume_90d, "beaten_quarterly_eps_estimation_count_ttm": beatenQuarterlyEpsEstimationCountTtm, "beta": beta, "dividend_frequency": dividendFrequency, "dividend_payout_ratio": dividendPayoutRatio, "dividend_yield": dividendYield, "dividends_per_share": dividendsPerShare, "ebitda": ebitda, "ebitda_growth_yoy": ebitdaGrowthYoy, "ebitda_ttm": ebitdaTtm, "enterprise_value_to_ebitda": enterpriseValueToEbitda, "enterprise_value_to_sales": enterpriseValueToSales, "eps_actual": epsActual, "eps_difference": epsDifference, "eps_estimate": epsEstimate, "eps_growth_fwd": epsGrowthFwd, "eps_growth_yoy": epsGrowthYoy, "eps_surprise": epsSurprise, "eps_ttm": epsTtm, "exchange_name": exchangeName, "implied_volatility": impliedVolatility, "market_capitalization": marketCapitalization, "net_debt": netDebt, "net_income": netIncome, "net_income_ttm": netIncomeTtm, "price_change_1m": priceChange_1m, "price_change_1w": priceChange_1w, "price_change_1y": priceChange_1y, "price_change_3m": priceChange_3m, "price_change_5y": priceChange_5y, "price_change_all": priceChangeAll, "price_to_book_value": priceToBookValue, "price_to_earnings_ttm": priceToEarningsTtm, "price_to_sales_ttm": priceToSalesTtm, "profit_margin": profitMargin, "relative_historical_volatility_adjusted_current": relativeHistoricalVolatilityAdjustedCurrent, "relative_historical_volatility_adjusted_max_1y": relativeHistoricalVolatilityAdjustedMax_1y, "relative_historical_volatility_adjusted_min_1y": relativeHistoricalVolatilityAdjustedMin_1y, "revenue_actual": revenueActual, "revenue_estimate_avg_0y": revenueEstimateAvg_0y, "revenue_growth_fwd": revenueGrowthFwd, "revenue_growth_yoy": revenueGrowthYoy, "revenue_per_share_ttm": revenuePerShareTtm, "revenue_ttm": revenueTtm, "roa": roa, "roi": roi, "shares_float": sharesFloat, "shares_outstanding": sharesOutstanding, "short_percent": shortPercent, "short_percent_outstanding": shortPercentOutstanding, "short_ratio": shortRatio, "symbol": symbol, "ticker": ticker, "total_assets": totalAssets, "years_of_consecutive_dividend_growth": yearsOfConsecutiveDividendGrowth]
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

  public var epsTtm: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["eps_ttm"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_ttm")
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

  public var priceChange_1w: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_1w"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1w")
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

  public var priceChange_5y: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_5y"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_5y")
    }
  }

  public var priceChangeAll: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["price_change_all"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_all")
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

  public var shortPercent: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["short_percent"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_percent")
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

/// Boolean expression to filter rows from the table "public_220413044555.collection_metrics". All fields are combined with a logical 'AND'.
public struct collection_metrics_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - absoluteDailyChange
  ///   - actualPrice
  ///   - collectionUniqId
  ///   - profile
  ///   - profileId
  ///   - relativeDailyChange
  ///   - updatedAt
  public init(_and: Swift.Optional<[collection_metrics_bool_exp]?> = nil, _not: Swift.Optional<collection_metrics_bool_exp?> = nil, _or: Swift.Optional<[collection_metrics_bool_exp]?> = nil, absoluteDailyChange: Swift.Optional<float8_comparison_exp?> = nil, actualPrice: Swift.Optional<float8_comparison_exp?> = nil, collectionUniqId: Swift.Optional<String_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, relativeDailyChange: Swift.Optional<float8_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "collection_uniq_id": collectionUniqId, "profile": profile, "profile_id": profileId, "relative_daily_change": relativeDailyChange, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[collection_metrics_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[collection_metrics_bool_exp]?> ?? Swift.Optional<[collection_metrics_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<collection_metrics_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<collection_metrics_bool_exp?> ?? Swift.Optional<collection_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[collection_metrics_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[collection_metrics_bool_exp]?> ?? Swift.Optional<[collection_metrics_bool_exp]?>.none
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

  public var collectionUniqId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["collection_uniq_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_uniq_id")
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

  public var relativeDailyChange: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["relative_daily_change"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_daily_change")
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

/// Boolean expression to filter rows from the table "app.profile_holdings". All fields are combined with a logical 'AND'.
public struct app_profile_holdings_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - accessToken
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
  public init(_and: Swift.Optional<[app_profile_holdings_bool_exp]?> = nil, _not: Swift.Optional<app_profile_holdings_bool_exp?> = nil, _or: Swift.Optional<[app_profile_holdings_bool_exp]?> = nil, accessToken: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> = nil, account: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> = nil, accountId: Swift.Optional<Int_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, holdingDetails: Swift.Optional<portfolio_holding_details_bool_exp?> = nil, holdingTransactions: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, isoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, plaidAccessTokenId: Swift.Optional<Int_comparison_exp?> = nil, portfolioHoldingGains: Swift.Optional<portfolio_holding_gains_bool_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, quantity: Swift.Optional<float8_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, security: Swift.Optional<app_portfolio_securities_bool_exp?> = nil, securityId: Swift.Optional<Int_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "access_token": accessToken, "account": account, "account_id": accountId, "created_at": createdAt, "holding_details": holdingDetails, "holding_transactions": holdingTransactions, "id": id, "iso_currency_code": isoCurrencyCode, "plaid_access_token_id": plaidAccessTokenId, "portfolio_holding_gains": portfolioHoldingGains, "profile": profile, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "updated_at": updatedAt]
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

  public var accessToken: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> {
    get {
      return graphQLMap["access_token"] as? Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> ?? Swift.Optional<app_profile_plaid_access_tokens_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "access_token")
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
  ///   - institution
  ///   - institutionId
  ///   - itemId
  ///   - needsReauthSince
  ///   - profile
  ///   - profileId
  public init(_and: Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?> = nil, _not: Swift.Optional<app_profile_plaid_access_tokens_bool_exp?> = nil, _or: Swift.Optional<[app_profile_plaid_access_tokens_bool_exp]?> = nil, accessToken: Swift.Optional<String_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, institution: Swift.Optional<app_plaid_institutions_bool_exp?> = nil, institutionId: Swift.Optional<Int_comparison_exp?> = nil, itemId: Swift.Optional<String_comparison_exp?> = nil, needsReauthSince: Swift.Optional<timestamptz_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "access_token": accessToken, "created_at": createdAt, "id": id, "institution": institution, "institution_id": institutionId, "item_id": itemId, "needs_reauth_since": needsReauthSince, "profile": profile, "profile_id": profileId]
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

  public var institution: Swift.Optional<app_plaid_institutions_bool_exp?> {
    get {
      return graphQLMap["institution"] as? Swift.Optional<app_plaid_institutions_bool_exp?> ?? Swift.Optional<app_plaid_institutions_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution")
    }
  }

  public var institutionId: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
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

  public var needsReauthSince: Swift.Optional<timestamptz_comparison_exp?> {
    get {
      return graphQLMap["needs_reauth_since"] as? Swift.Optional<timestamptz_comparison_exp?> ?? Swift.Optional<timestamptz_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "needs_reauth_since")
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

/// Boolean expression to filter rows from the table "app.plaid_institutions". All fields are combined with a logical 'AND'.
public struct app_plaid_institutions_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - createdAt
  ///   - id
  ///   - name
  ///   - refId
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_plaid_institutions_bool_exp]?> = nil, _not: Swift.Optional<app_plaid_institutions_bool_exp?> = nil, _or: Swift.Optional<[app_plaid_institutions_bool_exp]?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "created_at": createdAt, "id": id, "name": name, "ref_id": refId, "updated_at": updatedAt]
  }

  public var _and: Swift.Optional<[app_plaid_institutions_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[app_plaid_institutions_bool_exp]?> ?? Swift.Optional<[app_plaid_institutions_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<app_plaid_institutions_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<app_plaid_institutions_bool_exp?> ?? Swift.Optional<app_plaid_institutions_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[app_plaid_institutions_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[app_plaid_institutions_bool_exp]?> ?? Swift.Optional<[app_plaid_institutions_bool_exp]?>.none
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

  public var refId: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["ref_id"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ref_id")
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

/// Boolean expression to filter rows from the table "public_220413044555.portfolio_holding_details". All fields are combined with a logical 'AND'.
public struct portfolio_holding_details_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - accountId
  ///   - avgCost
  ///   - holding
  ///   - holdingId
  ///   - lttQuantityTotal
  ///   - marketCapitalization
  ///   - name
  ///   - nextEarningsDate
  ///   - purchaseDate
  ///   - quantity
  ///   - relativeGain_1d
  ///   - relativeGainTotal
  ///   - securityType
  ///   - ticker
  ///   - tickerName
  ///   - tickerSymbol
  ///   - valueToPortfolioValue
  public init(_and: Swift.Optional<[portfolio_holding_details_bool_exp]?> = nil, _not: Swift.Optional<portfolio_holding_details_bool_exp?> = nil, _or: Swift.Optional<[portfolio_holding_details_bool_exp]?> = nil, accountId: Swift.Optional<Int_comparison_exp?> = nil, avgCost: Swift.Optional<float8_comparison_exp?> = nil, holding: Swift.Optional<app_profile_holdings_bool_exp?> = nil, holdingId: Swift.Optional<Int_comparison_exp?> = nil, lttQuantityTotal: Swift.Optional<float8_comparison_exp?> = nil, marketCapitalization: Swift.Optional<bigint_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, nextEarningsDate: Swift.Optional<timestamp_comparison_exp?> = nil, purchaseDate: Swift.Optional<timestamp_comparison_exp?> = nil, quantity: Swift.Optional<float8_comparison_exp?> = nil, relativeGain_1d: Swift.Optional<float8_comparison_exp?> = nil, relativeGainTotal: Swift.Optional<float8_comparison_exp?> = nil, securityType: Swift.Optional<String_comparison_exp?> = nil, ticker: Swift.Optional<tickers_bool_exp?> = nil, tickerName: Swift.Optional<String_comparison_exp?> = nil, tickerSymbol: Swift.Optional<String_comparison_exp?> = nil, valueToPortfolioValue: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "account_id": accountId, "avg_cost": avgCost, "holding": holding, "holding_id": holdingId, "ltt_quantity_total": lttQuantityTotal, "market_capitalization": marketCapitalization, "name": name, "next_earnings_date": nextEarningsDate, "purchase_date": purchaseDate, "quantity": quantity, "relative_gain_1d": relativeGain_1d, "relative_gain_total": relativeGainTotal, "security_type": securityType, "ticker": ticker, "ticker_name": tickerName, "ticker_symbol": tickerSymbol, "value_to_portfolio_value": valueToPortfolioValue]
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

  public var avgCost: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["avg_cost"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg_cost")
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

  public var name: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
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

  public var quantity: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
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
  public init(_and: Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?> = nil, _not: Swift.Optional<app_profile_portfolio_transactions_bool_exp?> = nil, _or: Swift.Optional<[app_profile_portfolio_transactions_bool_exp]?> = nil, account: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> = nil, accountId: Swift.Optional<Int_comparison_exp?> = nil, amount: Swift.Optional<float8_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, fees: Swift.Optional<float8_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, isoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, plaidAccessTokenId: Swift.Optional<Int_comparison_exp?> = nil, price: Swift.Optional<float8_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, quantity: Swift.Optional<float8_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, security: Swift.Optional<app_portfolio_securities_bool_exp?> = nil, securityId: Swift.Optional<Int_comparison_exp?> = nil, subtype: Swift.Optional<String_comparison_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "account": account, "account_id": accountId, "amount": amount, "created_at": createdAt, "date": date, "fees": fees, "id": id, "iso_currency_code": isoCurrencyCode, "name": name, "plaid_access_token_id": plaidAccessTokenId, "price": price, "profile": profile, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "subtype": subtype, "type": type, "updated_at": updatedAt]
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

/// Boolean expression to filter rows from the table "public_220413044555.portfolio_holding_gains". All fields are combined with a logical 'AND'.
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
  ///   - riskScore
  ///   - stockMarketRiskLevel
  ///   - tradingExperience
  ///   - unexpectedPurchasesSource
  public init(_and: Swift.Optional<[app_profile_scoring_settings_bool_exp]?> = nil, _not: Swift.Optional<app_profile_scoring_settings_bool_exp?> = nil, _or: Swift.Optional<[app_profile_scoring_settings_bool_exp]?> = nil, averageMarketReturn: Swift.Optional<Int_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, damageOfFailure: Swift.Optional<Float_comparison_exp?> = nil, ifMarketDrops_20IWillBuy: Swift.Optional<Float_comparison_exp?> = nil, ifMarketDrops_40IWillBuy: Swift.Optional<Float_comparison_exp?> = nil, investmentHorizon: Swift.Optional<Float_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, riskLevel: Swift.Optional<Float_comparison_exp?> = nil, riskScore: Swift.Optional<Int_comparison_exp?> = nil, stockMarketRiskLevel: Swift.Optional<String_comparison_exp?> = nil, tradingExperience: Swift.Optional<String_comparison_exp?> = nil, unexpectedPurchasesSource: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "average_market_return": averageMarketReturn, "created_at": createdAt, "damage_of_failure": damageOfFailure, "if_market_drops_20_i_will_buy": ifMarketDrops_20IWillBuy, "if_market_drops_40_i_will_buy": ifMarketDrops_40IWillBuy, "investment_horizon": investmentHorizon, "profile": profile, "profile_id": profileId, "risk_level": riskLevel, "risk_score": riskScore, "stock_market_risk_level": stockMarketRiskLevel, "trading_experience": tradingExperience, "unexpected_purchases_source": unexpectedPurchasesSource]
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

  public var riskScore: Swift.Optional<Int_comparison_exp?> {
    get {
      return graphQLMap["risk_score"] as? Swift.Optional<Int_comparison_exp?> ?? Swift.Optional<Int_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_score")
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
  ///   - collection
  ///   - collectionId
  ///   - profile
  ///   - profileId
  public init(collection: Swift.Optional<collections_obj_rel_insert_input?> = nil, collectionId: Swift.Optional<Int?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil) {
    graphQLMap = ["collection": collection, "collection_id": collectionId, "profile": profile, "profile_id": profileId]
  }

  public var collection: Swift.Optional<collections_obj_rel_insert_input?> {
    get {
      return graphQLMap["collection"] as? Swift.Optional<collections_obj_rel_insert_input?> ?? Swift.Optional<collections_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection")
    }
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

/// input type for inserting object relation for remote table "public_220413044555.profile_collections"
public struct collections_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: collections_insert_input) {
    graphQLMap = ["data": data]
  }

  public var data: collections_insert_input {
    get {
      return graphQLMap["data"] as! collections_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "public_220413044555.profile_collections"
public struct collections_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - description
  ///   - enabled
  ///   - id
  ///   - imageUrl
  ///   - matchScore
  ///   - matchScoreExplanation
  ///   - metrics
  ///   - name
  ///   - personalized
  ///   - profile
  ///   - profileId
  ///   - size
  ///   - tickerCollections
  ///   - uniqId
  public init(description: Swift.Optional<String?> = nil, enabled: Swift.Optional<String?> = nil, id: Swift.Optional<Int?> = nil, imageUrl: Swift.Optional<String?> = nil, matchScore: Swift.Optional<collection_match_score_obj_rel_insert_input?> = nil, matchScoreExplanation: Swift.Optional<collection_match_score_explanation_arr_rel_insert_input?> = nil, metrics: Swift.Optional<collection_metrics_obj_rel_insert_input?> = nil, name: Swift.Optional<String?> = nil, personalized: Swift.Optional<String?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, size: Swift.Optional<Int?> = nil, tickerCollections: Swift.Optional<ticker_collections_arr_rel_insert_input?> = nil, uniqId: Swift.Optional<String?> = nil) {
    graphQLMap = ["description": description, "enabled": enabled, "id": id, "image_url": imageUrl, "match_score": matchScore, "match_score_explanation": matchScoreExplanation, "metrics": metrics, "name": name, "personalized": personalized, "profile": profile, "profile_id": profileId, "size": size, "ticker_collections": tickerCollections, "uniq_id": uniqId]
  }

  public var description: Swift.Optional<String?> {
    get {
      return graphQLMap["description"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "description")
    }
  }

  public var enabled: Swift.Optional<String?> {
    get {
      return graphQLMap["enabled"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "enabled")
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

  public var imageUrl: Swift.Optional<String?> {
    get {
      return graphQLMap["image_url"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_url")
    }
  }

  public var matchScore: Swift.Optional<collection_match_score_obj_rel_insert_input?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<collection_match_score_obj_rel_insert_input?> ?? Swift.Optional<collection_match_score_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
    }
  }

  public var matchScoreExplanation: Swift.Optional<collection_match_score_explanation_arr_rel_insert_input?> {
    get {
      return graphQLMap["match_score_explanation"] as? Swift.Optional<collection_match_score_explanation_arr_rel_insert_input?> ?? Swift.Optional<collection_match_score_explanation_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score_explanation")
    }
  }

  public var metrics: Swift.Optional<collection_metrics_obj_rel_insert_input?> {
    get {
      return graphQLMap["metrics"] as? Swift.Optional<collection_metrics_obj_rel_insert_input?> ?? Swift.Optional<collection_metrics_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "metrics")
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

  public var personalized: Swift.Optional<String?> {
    get {
      return graphQLMap["personalized"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "personalized")
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

  public var size: Swift.Optional<Int?> {
    get {
      return graphQLMap["size"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
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

  public var uniqId: Swift.Optional<String?> {
    get {
      return graphQLMap["uniq_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "uniq_id")
    }
  }
}

/// input type for inserting object relation for remote table "public_220413044555.collection_match_score"
public struct collection_match_score_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: collection_match_score_insert_input) {
    graphQLMap = ["data": data]
  }

  public var data: collection_match_score_insert_input {
    get {
      return graphQLMap["data"] as! collection_match_score_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "public_220413044555.collection_match_score"
public struct collection_match_score_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryLevel
  ///   - categorySimilarity
  ///   - collectionId
  ///   - collectionUniqId
  ///   - interestLevel
  ///   - interestSimilarity
  ///   - matchScore
  ///   - profile
  ///   - profileId
  ///   - riskLevel
  ///   - riskSimilarity
  public init(categoryLevel: Swift.Optional<Int?> = nil, categorySimilarity: Swift.Optional<float8?> = nil, collectionId: Swift.Optional<Int?> = nil, collectionUniqId: Swift.Optional<String?> = nil, interestLevel: Swift.Optional<Int?> = nil, interestSimilarity: Swift.Optional<float8?> = nil, matchScore: Swift.Optional<float8?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, riskLevel: Swift.Optional<Int?> = nil, riskSimilarity: Swift.Optional<float8?> = nil) {
    graphQLMap = ["category_level": categoryLevel, "category_similarity": categorySimilarity, "collection_id": collectionId, "collection_uniq_id": collectionUniqId, "interest_level": interestLevel, "interest_similarity": interestSimilarity, "match_score": matchScore, "profile": profile, "profile_id": profileId, "risk_level": riskLevel, "risk_similarity": riskSimilarity]
  }

  public var categoryLevel: Swift.Optional<Int?> {
    get {
      return graphQLMap["category_level"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_level")
    }
  }

  public var categorySimilarity: Swift.Optional<float8?> {
    get {
      return graphQLMap["category_similarity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_similarity")
    }
  }

  public var collectionId: Swift.Optional<Int?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var collectionUniqId: Swift.Optional<String?> {
    get {
      return graphQLMap["collection_uniq_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_uniq_id")
    }
  }

  public var interestLevel: Swift.Optional<Int?> {
    get {
      return graphQLMap["interest_level"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_level")
    }
  }

  public var interestSimilarity: Swift.Optional<float8?> {
    get {
      return graphQLMap["interest_similarity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_similarity")
    }
  }

  public var matchScore: Swift.Optional<float8?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
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

  public var riskLevel: Swift.Optional<Int?> {
    get {
      return graphQLMap["risk_level"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_level")
    }
  }

  public var riskSimilarity: Swift.Optional<float8?> {
    get {
      return graphQLMap["risk_similarity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_similarity")
    }
  }
}

/// input type for inserting array relation for remote table "public_220413044555.collection_match_score_explanation"
public struct collection_match_score_explanation_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [collection_match_score_explanation_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [collection_match_score_explanation_insert_input] {
    get {
      return graphQLMap["data"] as! [collection_match_score_explanation_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "public_220413044555.collection_match_score_explanation"
public struct collection_match_score_explanation_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - category
  ///   - categoryId
  ///   - collectionId
  ///   - collectionUniqId
  ///   - interest
  ///   - interestId
  ///   - profile
  ///   - profileId
  public init(category: Swift.Optional<categories_obj_rel_insert_input?> = nil, categoryId: Swift.Optional<Int?> = nil, collectionId: Swift.Optional<Int?> = nil, collectionUniqId: Swift.Optional<String?> = nil, interest: Swift.Optional<interests_obj_rel_insert_input?> = nil, interestId: Swift.Optional<Int?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil) {
    graphQLMap = ["category": category, "category_id": categoryId, "collection_id": collectionId, "collection_uniq_id": collectionUniqId, "interest": interest, "interest_id": interestId, "profile": profile, "profile_id": profileId]
  }

  public var category: Swift.Optional<categories_obj_rel_insert_input?> {
    get {
      return graphQLMap["category"] as? Swift.Optional<categories_obj_rel_insert_input?> ?? Swift.Optional<categories_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category")
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

  public var collectionId: Swift.Optional<Int?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
    }
  }

  public var collectionUniqId: Swift.Optional<String?> {
    get {
      return graphQLMap["collection_uniq_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_uniq_id")
    }
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

/// input type for inserting object relation for remote table "public_220413044555.categories"
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

/// input type for inserting data into table "public_220413044555.categories"
public struct categories_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - iconUrl
  ///   - id
  ///   - name
  ///   - riskScore
  ///   - updatedAt
  public init(collectionId: Swift.Optional<Int?> = nil, iconUrl: Swift.Optional<String?> = nil, id: Swift.Optional<Int?> = nil, name: Swift.Optional<String?> = nil, riskScore: Swift.Optional<Int?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["collection_id": collectionId, "icon_url": iconUrl, "id": id, "name": name, "risk_score": riskScore, "updated_at": updatedAt]
  }

  public var collectionId: Swift.Optional<Int?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
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

  public var riskScore: Swift.Optional<Int?> {
    get {
      return graphQLMap["risk_score"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_score")
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

/// on conflict condition type for table "public_220413044555.categories"
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

/// unique or primary key constraints on table "public_220413044555.categories"
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

/// update columns of table "public_220413044555.categories"
public enum categories_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case collectionId
  /// column name
  case iconUrl
  /// column name
  case id
  /// column name
  case name
  /// column name
  case riskScore
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "collection_id": self = .collectionId
      case "icon_url": self = .iconUrl
      case "id": self = .id
      case "name": self = .name
      case "risk_score": self = .riskScore
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .collectionId: return "collection_id"
      case .iconUrl: return "icon_url"
      case .id: return "id"
      case .name: return "name"
      case .riskScore: return "risk_score"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: categories_update_column, rhs: categories_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.collectionId, .collectionId): return true
      case (.iconUrl, .iconUrl): return true
      case (.id, .id): return true
      case (.name, .name): return true
      case (.riskScore, .riskScore): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [categories_update_column] {
    return [
      .collectionId,
      .iconUrl,
      .id,
      .name,
      .riskScore,
      .updatedAt,
    ]
  }
}

/// input type for inserting object relation for remote table "public_220413044555.interests"
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

/// input type for inserting data into table "public_220413044555.interests"
public struct interests_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - enabled
  ///   - iconUrl
  ///   - id
  ///   - name
  ///   - tickerInterests
  ///   - updatedAt
  public init(enabled: Swift.Optional<String?> = nil, iconUrl: Swift.Optional<String?> = nil, id: Swift.Optional<Int?> = nil, name: Swift.Optional<String?> = nil, tickerInterests: Swift.Optional<ticker_interests_arr_rel_insert_input?> = nil, updatedAt: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["enabled": enabled, "icon_url": iconUrl, "id": id, "name": name, "ticker_interests": tickerInterests, "updated_at": updatedAt]
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

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// input type for inserting array relation for remote table "public_220413044555.ticker_interests"
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

/// input type for inserting data into table "public_220413044555.ticker_interests"
public struct ticker_interests_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - id
  ///   - interest
  ///   - interestId
  ///   - simDif
  ///   - symbol
  ///   - ticker
  ///   - updatedAt
  public init(id: Swift.Optional<String?> = nil, interest: Swift.Optional<interests_obj_rel_insert_input?> = nil, interestId: Swift.Optional<Int?> = nil, simDif: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil, updatedAt: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["id": id, "interest": interest, "interest_id": interestId, "sim_dif": simDif, "symbol": symbol, "ticker": ticker, "updated_at": updatedAt]
  }

  public var id: Swift.Optional<String?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
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

  public var simDif: Swift.Optional<float8?> {
    get {
      return graphQLMap["sim_dif"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sim_dif")
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

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// input type for inserting object relation for remote table "public_220413044555.tickers"
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

/// input type for inserting data into table "public_220413044555.tickers"
public struct tickers_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - countryName
  ///   - cryptoMetrics
  ///   - cryptoRealtimeMetrics
  ///   - description
  ///   - exchange
  ///   - exchangeCanonical
  ///   - gicGroup
  ///   - gicIndustry
  ///   - gicSector
  ///   - gicSubIndustry
  ///   - industry
  ///   - ipoDate
  ///   - logoUrl
  ///   - matchScore
  ///   - name
  ///   - phone
  ///   - realtimeMetrics
  ///   - sector
  ///   - symbol
  ///   - tickerAnalystRatings
  ///   - tickerCategories
  ///   - tickerCollections
  ///   - tickerEvents
  ///   - tickerHighlights
  ///   - tickerIndustries
  ///   - tickerInterests
  ///   - tickerMetrics
  ///   - type
  ///   - updatedAt
  ///   - webUrl
  public init(countryName: Swift.Optional<String?> = nil, cryptoMetrics: Swift.Optional<crypto_metrics_obj_rel_insert_input?> = nil, cryptoRealtimeMetrics: Swift.Optional<crypto_realtime_metrics_obj_rel_insert_input?> = nil, description: Swift.Optional<String?> = nil, exchange: Swift.Optional<String?> = nil, exchangeCanonical: Swift.Optional<String?> = nil, gicGroup: Swift.Optional<String?> = nil, gicIndustry: Swift.Optional<String?> = nil, gicSector: Swift.Optional<String?> = nil, gicSubIndustry: Swift.Optional<String?> = nil, industry: Swift.Optional<String?> = nil, ipoDate: Swift.Optional<date?> = nil, logoUrl: Swift.Optional<String?> = nil, matchScore: Swift.Optional<app_profile_ticker_match_score_obj_rel_insert_input?> = nil, name: Swift.Optional<String?> = nil, phone: Swift.Optional<String?> = nil, realtimeMetrics: Swift.Optional<ticker_realtime_metrics_obj_rel_insert_input?> = nil, sector: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil, tickerAnalystRatings: Swift.Optional<analyst_ratings_obj_rel_insert_input?> = nil, tickerCategories: Swift.Optional<ticker_categories_arr_rel_insert_input?> = nil, tickerCollections: Swift.Optional<ticker_collections_arr_rel_insert_input?> = nil, tickerEvents: Swift.Optional<ticker_events_arr_rel_insert_input?> = nil, tickerHighlights: Swift.Optional<ticker_highlights_arr_rel_insert_input?> = nil, tickerIndustries: Swift.Optional<ticker_industries_arr_rel_insert_input?> = nil, tickerInterests: Swift.Optional<ticker_interests_arr_rel_insert_input?> = nil, tickerMetrics: Swift.Optional<ticker_metrics_obj_rel_insert_input?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamp?> = nil, webUrl: Swift.Optional<String?> = nil) {
    graphQLMap = ["country_name": countryName, "crypto_metrics": cryptoMetrics, "crypto_realtime_metrics": cryptoRealtimeMetrics, "description": description, "exchange": exchange, "exchange_canonical": exchangeCanonical, "gic_group": gicGroup, "gic_industry": gicIndustry, "gic_sector": gicSector, "gic_sub_industry": gicSubIndustry, "industry": industry, "ipo_date": ipoDate, "logo_url": logoUrl, "match_score": matchScore, "name": name, "phone": phone, "realtime_metrics": realtimeMetrics, "sector": sector, "symbol": symbol, "ticker_analyst_ratings": tickerAnalystRatings, "ticker_categories": tickerCategories, "ticker_collections": tickerCollections, "ticker_events": tickerEvents, "ticker_highlights": tickerHighlights, "ticker_industries": tickerIndustries, "ticker_interests": tickerInterests, "ticker_metrics": tickerMetrics, "type": type, "updated_at": updatedAt, "web_url": webUrl]
  }

  public var countryName: Swift.Optional<String?> {
    get {
      return graphQLMap["country_name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country_name")
    }
  }

  public var cryptoMetrics: Swift.Optional<crypto_metrics_obj_rel_insert_input?> {
    get {
      return graphQLMap["crypto_metrics"] as? Swift.Optional<crypto_metrics_obj_rel_insert_input?> ?? Swift.Optional<crypto_metrics_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "crypto_metrics")
    }
  }

  public var cryptoRealtimeMetrics: Swift.Optional<crypto_realtime_metrics_obj_rel_insert_input?> {
    get {
      return graphQLMap["crypto_realtime_metrics"] as? Swift.Optional<crypto_realtime_metrics_obj_rel_insert_input?> ?? Swift.Optional<crypto_realtime_metrics_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "crypto_realtime_metrics")
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

  public var exchange: Swift.Optional<String?> {
    get {
      return graphQLMap["exchange"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange")
    }
  }

  public var exchangeCanonical: Swift.Optional<String?> {
    get {
      return graphQLMap["exchange_canonical"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exchange_canonical")
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

  public var matchScore: Swift.Optional<app_profile_ticker_match_score_obj_rel_insert_input?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<app_profile_ticker_match_score_obj_rel_insert_input?> ?? Swift.Optional<app_profile_ticker_match_score_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
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

/// input type for inserting object relation for remote table "public_220413044555.crypto_metrics"
public struct crypto_metrics_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: crypto_metrics_insert_input, onConflict: Swift.Optional<crypto_metrics_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: crypto_metrics_insert_input {
    get {
      return graphQLMap["data"] as! crypto_metrics_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<crypto_metrics_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<crypto_metrics_on_conflict?> ?? Swift.Optional<crypto_metrics_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "public_220413044555.crypto_metrics"
public struct crypto_metrics_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - alexaRank
  ///   - assetPlatformId
  ///   - bingMatches
  ///   - categories
  ///   - coingeckoRank
  ///   - coingeckoScore
  ///   - communityFacebookLikes
  ///   - communityRedditAccountsActive_48h
  ///   - communityRedditAverageComments_48h
  ///   - communityRedditAveragePosts_48h
  ///   - communityRedditSubscribers
  ///   - communityScore
  ///   - communityTelegramChannelUserCount
  ///   - communityTwitterFollowers
  ///   - countryOrigin
  ///   - description
  ///   - developmentClosedIssues
  ///   - developmentCodeAdditionsDeletions_4WeeksAdditions
  ///   - developmentCodeAdditionsDeletions_4WeeksDeletions
  ///   - developmentCommitCount_4Weeks
  ///   - developmentForks
  ///   - developmentPullRequestContributors
  ///   - developmentPullRequestsMerged
  ///   - developmentScore
  ///   - developmentStars
  ///   - developmentSubscribers
  ///   - developmentTotalIssues
  ///   - hashingAlgorithm
  ///   - icoEndDate
  ///   - icoStartDate
  ///   - imageLarge
  ///   - imageSmall
  ///   - imageThumb
  ///   - links
  ///   - liquidityScore
  ///   - marketCapRank
  ///   - marketFdvToTvlRatio
  ///   - marketMcapToTvlRatio
  ///   - marketTotalValueLocked
  ///   - name
  ///   - priceChange_1m
  ///   - priceChange_1w
  ///   - priceChange_1y
  ///   - priceChange_3m
  ///   - priceChange_5y
  ///   - priceChangeAll
  ///   - publicInterestScore
  ///   - sentimentVotesDownPercentage
  ///   - sentimentVotesUpPercentage
  ///   - symbol
  public init(alexaRank: Swift.Optional<Int?> = nil, assetPlatformId: Swift.Optional<String?> = nil, bingMatches: Swift.Optional<Int?> = nil, categories: Swift.Optional<jsonb?> = nil, coingeckoRank: Swift.Optional<Int?> = nil, coingeckoScore: Swift.Optional<float8?> = nil, communityFacebookLikes: Swift.Optional<Int?> = nil, communityRedditAccountsActive_48h: Swift.Optional<Int?> = nil, communityRedditAverageComments_48h: Swift.Optional<float8?> = nil, communityRedditAveragePosts_48h: Swift.Optional<float8?> = nil, communityRedditSubscribers: Swift.Optional<Int?> = nil, communityScore: Swift.Optional<float8?> = nil, communityTelegramChannelUserCount: Swift.Optional<Int?> = nil, communityTwitterFollowers: Swift.Optional<Int?> = nil, countryOrigin: Swift.Optional<String?> = nil, description: Swift.Optional<String?> = nil, developmentClosedIssues: Swift.Optional<Int?> = nil, developmentCodeAdditionsDeletions_4WeeksAdditions: Swift.Optional<Int?> = nil, developmentCodeAdditionsDeletions_4WeeksDeletions: Swift.Optional<Int?> = nil, developmentCommitCount_4Weeks: Swift.Optional<Int?> = nil, developmentForks: Swift.Optional<Int?> = nil, developmentPullRequestContributors: Swift.Optional<Int?> = nil, developmentPullRequestsMerged: Swift.Optional<Int?> = nil, developmentScore: Swift.Optional<float8?> = nil, developmentStars: Swift.Optional<Int?> = nil, developmentSubscribers: Swift.Optional<Int?> = nil, developmentTotalIssues: Swift.Optional<Int?> = nil, hashingAlgorithm: Swift.Optional<String?> = nil, icoEndDate: Swift.Optional<date?> = nil, icoStartDate: Swift.Optional<date?> = nil, imageLarge: Swift.Optional<String?> = nil, imageSmall: Swift.Optional<String?> = nil, imageThumb: Swift.Optional<String?> = nil, links: Swift.Optional<jsonb?> = nil, liquidityScore: Swift.Optional<float8?> = nil, marketCapRank: Swift.Optional<Int?> = nil, marketFdvToTvlRatio: Swift.Optional<float8?> = nil, marketMcapToTvlRatio: Swift.Optional<float8?> = nil, marketTotalValueLocked: Swift.Optional<float8?> = nil, name: Swift.Optional<String?> = nil, priceChange_1m: Swift.Optional<float8?> = nil, priceChange_1w: Swift.Optional<float8?> = nil, priceChange_1y: Swift.Optional<float8?> = nil, priceChange_3m: Swift.Optional<float8?> = nil, priceChange_5y: Swift.Optional<float8?> = nil, priceChangeAll: Swift.Optional<float8?> = nil, publicInterestScore: Swift.Optional<float8?> = nil, sentimentVotesDownPercentage: Swift.Optional<float8?> = nil, sentimentVotesUpPercentage: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["alexa_rank": alexaRank, "asset_platform_id": assetPlatformId, "bing_matches": bingMatches, "categories": categories, "coingecko_rank": coingeckoRank, "coingecko_score": coingeckoScore, "community_facebook_likes": communityFacebookLikes, "community_reddit_accounts_active_48h": communityRedditAccountsActive_48h, "community_reddit_average_comments_48h": communityRedditAverageComments_48h, "community_reddit_average_posts_48h": communityRedditAveragePosts_48h, "community_reddit_subscribers": communityRedditSubscribers, "community_score": communityScore, "community_telegram_channel_user_count": communityTelegramChannelUserCount, "community_twitter_followers": communityTwitterFollowers, "country_origin": countryOrigin, "description": description, "development_closed_issues": developmentClosedIssues, "development_code_additions_deletions_4_weeks_additions": developmentCodeAdditionsDeletions_4WeeksAdditions, "development_code_additions_deletions_4_weeks_deletions": developmentCodeAdditionsDeletions_4WeeksDeletions, "development_commit_count_4_weeks": developmentCommitCount_4Weeks, "development_forks": developmentForks, "development_pull_request_contributors": developmentPullRequestContributors, "development_pull_requests_merged": developmentPullRequestsMerged, "development_score": developmentScore, "development_stars": developmentStars, "development_subscribers": developmentSubscribers, "development_total_issues": developmentTotalIssues, "hashing_algorithm": hashingAlgorithm, "ico_end_date": icoEndDate, "ico_start_date": icoStartDate, "image_large": imageLarge, "image_small": imageSmall, "image_thumb": imageThumb, "links": links, "liquidity_score": liquidityScore, "market_cap_rank": marketCapRank, "market_fdv_to_tvl_ratio": marketFdvToTvlRatio, "market_mcap_to_tvl_ratio": marketMcapToTvlRatio, "market_total_value_locked": marketTotalValueLocked, "name": name, "price_change_1m": priceChange_1m, "price_change_1w": priceChange_1w, "price_change_1y": priceChange_1y, "price_change_3m": priceChange_3m, "price_change_5y": priceChange_5y, "price_change_all": priceChangeAll, "public_interest_score": publicInterestScore, "sentiment_votes_down_percentage": sentimentVotesDownPercentage, "sentiment_votes_up_percentage": sentimentVotesUpPercentage, "symbol": symbol]
  }

  public var alexaRank: Swift.Optional<Int?> {
    get {
      return graphQLMap["alexa_rank"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "alexa_rank")
    }
  }

  public var assetPlatformId: Swift.Optional<String?> {
    get {
      return graphQLMap["asset_platform_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "asset_platform_id")
    }
  }

  public var bingMatches: Swift.Optional<Int?> {
    get {
      return graphQLMap["bing_matches"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "bing_matches")
    }
  }

  public var categories: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["categories"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "categories")
    }
  }

  public var coingeckoRank: Swift.Optional<Int?> {
    get {
      return graphQLMap["coingecko_rank"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "coingecko_rank")
    }
  }

  public var coingeckoScore: Swift.Optional<float8?> {
    get {
      return graphQLMap["coingecko_score"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "coingecko_score")
    }
  }

  public var communityFacebookLikes: Swift.Optional<Int?> {
    get {
      return graphQLMap["community_facebook_likes"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_facebook_likes")
    }
  }

  public var communityRedditAccountsActive_48h: Swift.Optional<Int?> {
    get {
      return graphQLMap["community_reddit_accounts_active_48h"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_accounts_active_48h")
    }
  }

  public var communityRedditAverageComments_48h: Swift.Optional<float8?> {
    get {
      return graphQLMap["community_reddit_average_comments_48h"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_average_comments_48h")
    }
  }

  public var communityRedditAveragePosts_48h: Swift.Optional<float8?> {
    get {
      return graphQLMap["community_reddit_average_posts_48h"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_average_posts_48h")
    }
  }

  public var communityRedditSubscribers: Swift.Optional<Int?> {
    get {
      return graphQLMap["community_reddit_subscribers"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_reddit_subscribers")
    }
  }

  public var communityScore: Swift.Optional<float8?> {
    get {
      return graphQLMap["community_score"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_score")
    }
  }

  public var communityTelegramChannelUserCount: Swift.Optional<Int?> {
    get {
      return graphQLMap["community_telegram_channel_user_count"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_telegram_channel_user_count")
    }
  }

  public var communityTwitterFollowers: Swift.Optional<Int?> {
    get {
      return graphQLMap["community_twitter_followers"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "community_twitter_followers")
    }
  }

  public var countryOrigin: Swift.Optional<String?> {
    get {
      return graphQLMap["country_origin"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "country_origin")
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

  public var developmentClosedIssues: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_closed_issues"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_closed_issues")
    }
  }

  public var developmentCodeAdditionsDeletions_4WeeksAdditions: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_code_additions_deletions_4_weeks_additions"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_code_additions_deletions_4_weeks_additions")
    }
  }

  public var developmentCodeAdditionsDeletions_4WeeksDeletions: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_code_additions_deletions_4_weeks_deletions"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_code_additions_deletions_4_weeks_deletions")
    }
  }

  public var developmentCommitCount_4Weeks: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_commit_count_4_weeks"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_commit_count_4_weeks")
    }
  }

  public var developmentForks: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_forks"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_forks")
    }
  }

  public var developmentPullRequestContributors: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_pull_request_contributors"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_pull_request_contributors")
    }
  }

  public var developmentPullRequestsMerged: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_pull_requests_merged"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_pull_requests_merged")
    }
  }

  public var developmentScore: Swift.Optional<float8?> {
    get {
      return graphQLMap["development_score"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_score")
    }
  }

  public var developmentStars: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_stars"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_stars")
    }
  }

  public var developmentSubscribers: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_subscribers"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_subscribers")
    }
  }

  public var developmentTotalIssues: Swift.Optional<Int?> {
    get {
      return graphQLMap["development_total_issues"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "development_total_issues")
    }
  }

  public var hashingAlgorithm: Swift.Optional<String?> {
    get {
      return graphQLMap["hashing_algorithm"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hashing_algorithm")
    }
  }

  public var icoEndDate: Swift.Optional<date?> {
    get {
      return graphQLMap["ico_end_date"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ico_end_date")
    }
  }

  public var icoStartDate: Swift.Optional<date?> {
    get {
      return graphQLMap["ico_start_date"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ico_start_date")
    }
  }

  public var imageLarge: Swift.Optional<String?> {
    get {
      return graphQLMap["image_large"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_large")
    }
  }

  public var imageSmall: Swift.Optional<String?> {
    get {
      return graphQLMap["image_small"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_small")
    }
  }

  public var imageThumb: Swift.Optional<String?> {
    get {
      return graphQLMap["image_thumb"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "image_thumb")
    }
  }

  public var links: Swift.Optional<jsonb?> {
    get {
      return graphQLMap["links"] as? Swift.Optional<jsonb?> ?? Swift.Optional<jsonb?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "links")
    }
  }

  public var liquidityScore: Swift.Optional<float8?> {
    get {
      return graphQLMap["liquidity_score"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "liquidity_score")
    }
  }

  public var marketCapRank: Swift.Optional<Int?> {
    get {
      return graphQLMap["market_cap_rank"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_cap_rank")
    }
  }

  public var marketFdvToTvlRatio: Swift.Optional<float8?> {
    get {
      return graphQLMap["market_fdv_to_tvl_ratio"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_fdv_to_tvl_ratio")
    }
  }

  public var marketMcapToTvlRatio: Swift.Optional<float8?> {
    get {
      return graphQLMap["market_mcap_to_tvl_ratio"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_mcap_to_tvl_ratio")
    }
  }

  public var marketTotalValueLocked: Swift.Optional<float8?> {
    get {
      return graphQLMap["market_total_value_locked"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_total_value_locked")
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

  public var priceChange_1m: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_1m"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1m")
    }
  }

  public var priceChange_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1w")
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

  public var priceChange_5y: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_5y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_5y")
    }
  }

  public var priceChangeAll: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_all"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_all")
    }
  }

  public var publicInterestScore: Swift.Optional<float8?> {
    get {
      return graphQLMap["public_interest_score"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "public_interest_score")
    }
  }

  public var sentimentVotesDownPercentage: Swift.Optional<float8?> {
    get {
      return graphQLMap["sentiment_votes_down_percentage"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sentiment_votes_down_percentage")
    }
  }

  public var sentimentVotesUpPercentage: Swift.Optional<float8?> {
    get {
      return graphQLMap["sentiment_votes_up_percentage"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sentiment_votes_up_percentage")
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

/// on conflict condition type for table "public_220413044555.crypto_metrics"
public struct crypto_metrics_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: crypto_metrics_constraint, updateColumns: [crypto_metrics_update_column], `where`: Swift.Optional<crypto_metrics_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: crypto_metrics_constraint {
    get {
      return graphQLMap["constraint"] as! crypto_metrics_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [crypto_metrics_update_column] {
    get {
      return graphQLMap["update_columns"] as! [crypto_metrics_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<crypto_metrics_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<crypto_metrics_bool_exp?> ?? Swift.Optional<crypto_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "public_220413044555.crypto_metrics"
public enum crypto_metrics_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case cryptoMetricsUniqueSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "crypto_metrics_unique_symbol": self = .cryptoMetricsUniqueSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .cryptoMetricsUniqueSymbol: return "crypto_metrics_unique_symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: crypto_metrics_constraint, rhs: crypto_metrics_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.cryptoMetricsUniqueSymbol, .cryptoMetricsUniqueSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [crypto_metrics_constraint] {
    return [
      .cryptoMetricsUniqueSymbol,
    ]
  }
}

/// update columns of table "public_220413044555.crypto_metrics"
public enum crypto_metrics_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case alexaRank
  /// column name
  case assetPlatformId
  /// column name
  case bingMatches
  /// column name
  case categories
  /// column name
  case coingeckoRank
  /// column name
  case coingeckoScore
  /// column name
  case communityFacebookLikes
  /// column name
  case communityRedditAccountsActive_48h
  /// column name
  case communityRedditAverageComments_48h
  /// column name
  case communityRedditAveragePosts_48h
  /// column name
  case communityRedditSubscribers
  /// column name
  case communityScore
  /// column name
  case communityTelegramChannelUserCount
  /// column name
  case communityTwitterFollowers
  /// column name
  case countryOrigin
  /// column name
  case description
  /// column name
  case developmentClosedIssues
  /// column name
  case developmentCodeAdditionsDeletions_4WeeksAdditions
  /// column name
  case developmentCodeAdditionsDeletions_4WeeksDeletions
  /// column name
  case developmentCommitCount_4Weeks
  /// column name
  case developmentForks
  /// column name
  case developmentPullRequestContributors
  /// column name
  case developmentPullRequestsMerged
  /// column name
  case developmentScore
  /// column name
  case developmentStars
  /// column name
  case developmentSubscribers
  /// column name
  case developmentTotalIssues
  /// column name
  case hashingAlgorithm
  /// column name
  case icoEndDate
  /// column name
  case icoStartDate
  /// column name
  case imageLarge
  /// column name
  case imageSmall
  /// column name
  case imageThumb
  /// column name
  case links
  /// column name
  case liquidityScore
  /// column name
  case marketCapRank
  /// column name
  case marketFdvToTvlRatio
  /// column name
  case marketMcapToTvlRatio
  /// column name
  case marketTotalValueLocked
  /// column name
  case name
  /// column name
  case priceChange_1m
  /// column name
  case priceChange_1w
  /// column name
  case priceChange_1y
  /// column name
  case priceChange_3m
  /// column name
  case priceChange_5y
  /// column name
  case priceChangeAll
  /// column name
  case publicInterestScore
  /// column name
  case sentimentVotesDownPercentage
  /// column name
  case sentimentVotesUpPercentage
  /// column name
  case symbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "alexa_rank": self = .alexaRank
      case "asset_platform_id": self = .assetPlatformId
      case "bing_matches": self = .bingMatches
      case "categories": self = .categories
      case "coingecko_rank": self = .coingeckoRank
      case "coingecko_score": self = .coingeckoScore
      case "community_facebook_likes": self = .communityFacebookLikes
      case "community_reddit_accounts_active_48h": self = .communityRedditAccountsActive_48h
      case "community_reddit_average_comments_48h": self = .communityRedditAverageComments_48h
      case "community_reddit_average_posts_48h": self = .communityRedditAveragePosts_48h
      case "community_reddit_subscribers": self = .communityRedditSubscribers
      case "community_score": self = .communityScore
      case "community_telegram_channel_user_count": self = .communityTelegramChannelUserCount
      case "community_twitter_followers": self = .communityTwitterFollowers
      case "country_origin": self = .countryOrigin
      case "description": self = .description
      case "development_closed_issues": self = .developmentClosedIssues
      case "development_code_additions_deletions_4_weeks_additions": self = .developmentCodeAdditionsDeletions_4WeeksAdditions
      case "development_code_additions_deletions_4_weeks_deletions": self = .developmentCodeAdditionsDeletions_4WeeksDeletions
      case "development_commit_count_4_weeks": self = .developmentCommitCount_4Weeks
      case "development_forks": self = .developmentForks
      case "development_pull_request_contributors": self = .developmentPullRequestContributors
      case "development_pull_requests_merged": self = .developmentPullRequestsMerged
      case "development_score": self = .developmentScore
      case "development_stars": self = .developmentStars
      case "development_subscribers": self = .developmentSubscribers
      case "development_total_issues": self = .developmentTotalIssues
      case "hashing_algorithm": self = .hashingAlgorithm
      case "ico_end_date": self = .icoEndDate
      case "ico_start_date": self = .icoStartDate
      case "image_large": self = .imageLarge
      case "image_small": self = .imageSmall
      case "image_thumb": self = .imageThumb
      case "links": self = .links
      case "liquidity_score": self = .liquidityScore
      case "market_cap_rank": self = .marketCapRank
      case "market_fdv_to_tvl_ratio": self = .marketFdvToTvlRatio
      case "market_mcap_to_tvl_ratio": self = .marketMcapToTvlRatio
      case "market_total_value_locked": self = .marketTotalValueLocked
      case "name": self = .name
      case "price_change_1m": self = .priceChange_1m
      case "price_change_1w": self = .priceChange_1w
      case "price_change_1y": self = .priceChange_1y
      case "price_change_3m": self = .priceChange_3m
      case "price_change_5y": self = .priceChange_5y
      case "price_change_all": self = .priceChangeAll
      case "public_interest_score": self = .publicInterestScore
      case "sentiment_votes_down_percentage": self = .sentimentVotesDownPercentage
      case "sentiment_votes_up_percentage": self = .sentimentVotesUpPercentage
      case "symbol": self = .symbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .alexaRank: return "alexa_rank"
      case .assetPlatformId: return "asset_platform_id"
      case .bingMatches: return "bing_matches"
      case .categories: return "categories"
      case .coingeckoRank: return "coingecko_rank"
      case .coingeckoScore: return "coingecko_score"
      case .communityFacebookLikes: return "community_facebook_likes"
      case .communityRedditAccountsActive_48h: return "community_reddit_accounts_active_48h"
      case .communityRedditAverageComments_48h: return "community_reddit_average_comments_48h"
      case .communityRedditAveragePosts_48h: return "community_reddit_average_posts_48h"
      case .communityRedditSubscribers: return "community_reddit_subscribers"
      case .communityScore: return "community_score"
      case .communityTelegramChannelUserCount: return "community_telegram_channel_user_count"
      case .communityTwitterFollowers: return "community_twitter_followers"
      case .countryOrigin: return "country_origin"
      case .description: return "description"
      case .developmentClosedIssues: return "development_closed_issues"
      case .developmentCodeAdditionsDeletions_4WeeksAdditions: return "development_code_additions_deletions_4_weeks_additions"
      case .developmentCodeAdditionsDeletions_4WeeksDeletions: return "development_code_additions_deletions_4_weeks_deletions"
      case .developmentCommitCount_4Weeks: return "development_commit_count_4_weeks"
      case .developmentForks: return "development_forks"
      case .developmentPullRequestContributors: return "development_pull_request_contributors"
      case .developmentPullRequestsMerged: return "development_pull_requests_merged"
      case .developmentScore: return "development_score"
      case .developmentStars: return "development_stars"
      case .developmentSubscribers: return "development_subscribers"
      case .developmentTotalIssues: return "development_total_issues"
      case .hashingAlgorithm: return "hashing_algorithm"
      case .icoEndDate: return "ico_end_date"
      case .icoStartDate: return "ico_start_date"
      case .imageLarge: return "image_large"
      case .imageSmall: return "image_small"
      case .imageThumb: return "image_thumb"
      case .links: return "links"
      case .liquidityScore: return "liquidity_score"
      case .marketCapRank: return "market_cap_rank"
      case .marketFdvToTvlRatio: return "market_fdv_to_tvl_ratio"
      case .marketMcapToTvlRatio: return "market_mcap_to_tvl_ratio"
      case .marketTotalValueLocked: return "market_total_value_locked"
      case .name: return "name"
      case .priceChange_1m: return "price_change_1m"
      case .priceChange_1w: return "price_change_1w"
      case .priceChange_1y: return "price_change_1y"
      case .priceChange_3m: return "price_change_3m"
      case .priceChange_5y: return "price_change_5y"
      case .priceChangeAll: return "price_change_all"
      case .publicInterestScore: return "public_interest_score"
      case .sentimentVotesDownPercentage: return "sentiment_votes_down_percentage"
      case .sentimentVotesUpPercentage: return "sentiment_votes_up_percentage"
      case .symbol: return "symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: crypto_metrics_update_column, rhs: crypto_metrics_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.alexaRank, .alexaRank): return true
      case (.assetPlatformId, .assetPlatformId): return true
      case (.bingMatches, .bingMatches): return true
      case (.categories, .categories): return true
      case (.coingeckoRank, .coingeckoRank): return true
      case (.coingeckoScore, .coingeckoScore): return true
      case (.communityFacebookLikes, .communityFacebookLikes): return true
      case (.communityRedditAccountsActive_48h, .communityRedditAccountsActive_48h): return true
      case (.communityRedditAverageComments_48h, .communityRedditAverageComments_48h): return true
      case (.communityRedditAveragePosts_48h, .communityRedditAveragePosts_48h): return true
      case (.communityRedditSubscribers, .communityRedditSubscribers): return true
      case (.communityScore, .communityScore): return true
      case (.communityTelegramChannelUserCount, .communityTelegramChannelUserCount): return true
      case (.communityTwitterFollowers, .communityTwitterFollowers): return true
      case (.countryOrigin, .countryOrigin): return true
      case (.description, .description): return true
      case (.developmentClosedIssues, .developmentClosedIssues): return true
      case (.developmentCodeAdditionsDeletions_4WeeksAdditions, .developmentCodeAdditionsDeletions_4WeeksAdditions): return true
      case (.developmentCodeAdditionsDeletions_4WeeksDeletions, .developmentCodeAdditionsDeletions_4WeeksDeletions): return true
      case (.developmentCommitCount_4Weeks, .developmentCommitCount_4Weeks): return true
      case (.developmentForks, .developmentForks): return true
      case (.developmentPullRequestContributors, .developmentPullRequestContributors): return true
      case (.developmentPullRequestsMerged, .developmentPullRequestsMerged): return true
      case (.developmentScore, .developmentScore): return true
      case (.developmentStars, .developmentStars): return true
      case (.developmentSubscribers, .developmentSubscribers): return true
      case (.developmentTotalIssues, .developmentTotalIssues): return true
      case (.hashingAlgorithm, .hashingAlgorithm): return true
      case (.icoEndDate, .icoEndDate): return true
      case (.icoStartDate, .icoStartDate): return true
      case (.imageLarge, .imageLarge): return true
      case (.imageSmall, .imageSmall): return true
      case (.imageThumb, .imageThumb): return true
      case (.links, .links): return true
      case (.liquidityScore, .liquidityScore): return true
      case (.marketCapRank, .marketCapRank): return true
      case (.marketFdvToTvlRatio, .marketFdvToTvlRatio): return true
      case (.marketMcapToTvlRatio, .marketMcapToTvlRatio): return true
      case (.marketTotalValueLocked, .marketTotalValueLocked): return true
      case (.name, .name): return true
      case (.priceChange_1m, .priceChange_1m): return true
      case (.priceChange_1w, .priceChange_1w): return true
      case (.priceChange_1y, .priceChange_1y): return true
      case (.priceChange_3m, .priceChange_3m): return true
      case (.priceChange_5y, .priceChange_5y): return true
      case (.priceChangeAll, .priceChangeAll): return true
      case (.publicInterestScore, .publicInterestScore): return true
      case (.sentimentVotesDownPercentage, .sentimentVotesDownPercentage): return true
      case (.sentimentVotesUpPercentage, .sentimentVotesUpPercentage): return true
      case (.symbol, .symbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [crypto_metrics_update_column] {
    return [
      .alexaRank,
      .assetPlatformId,
      .bingMatches,
      .categories,
      .coingeckoRank,
      .coingeckoScore,
      .communityFacebookLikes,
      .communityRedditAccountsActive_48h,
      .communityRedditAverageComments_48h,
      .communityRedditAveragePosts_48h,
      .communityRedditSubscribers,
      .communityScore,
      .communityTelegramChannelUserCount,
      .communityTwitterFollowers,
      .countryOrigin,
      .description,
      .developmentClosedIssues,
      .developmentCodeAdditionsDeletions_4WeeksAdditions,
      .developmentCodeAdditionsDeletions_4WeeksDeletions,
      .developmentCommitCount_4Weeks,
      .developmentForks,
      .developmentPullRequestContributors,
      .developmentPullRequestsMerged,
      .developmentScore,
      .developmentStars,
      .developmentSubscribers,
      .developmentTotalIssues,
      .hashingAlgorithm,
      .icoEndDate,
      .icoStartDate,
      .imageLarge,
      .imageSmall,
      .imageThumb,
      .links,
      .liquidityScore,
      .marketCapRank,
      .marketFdvToTvlRatio,
      .marketMcapToTvlRatio,
      .marketTotalValueLocked,
      .name,
      .priceChange_1m,
      .priceChange_1w,
      .priceChange_1y,
      .priceChange_3m,
      .priceChange_5y,
      .priceChangeAll,
      .publicInterestScore,
      .sentimentVotesDownPercentage,
      .sentimentVotesUpPercentage,
      .symbol,
    ]
  }
}

/// input type for inserting object relation for remote table "public_220413044555.crypto_realtime_metrics"
public struct crypto_realtime_metrics_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: crypto_realtime_metrics_insert_input, onConflict: Swift.Optional<crypto_realtime_metrics_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: crypto_realtime_metrics_insert_input {
    get {
      return graphQLMap["data"] as! crypto_realtime_metrics_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<crypto_realtime_metrics_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<crypto_realtime_metrics_on_conflict?> ?? Swift.Optional<crypto_realtime_metrics_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "public_220413044555.crypto_realtime_metrics"
public struct crypto_realtime_metrics_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - ath
  ///   - atl
  ///   - circulatingSupply
  ///   - high_24h
  ///   - low_24h
  ///   - marketCapiptalization
  ///   - maxSupply
  ///   - symbol
  ///   - totalSupply
  ///   - volume_24h
  public init(ath: Swift.Optional<float8?> = nil, atl: Swift.Optional<float8?> = nil, circulatingSupply: Swift.Optional<float8?> = nil, high_24h: Swift.Optional<float8?> = nil, low_24h: Swift.Optional<float8?> = nil, marketCapiptalization: Swift.Optional<float8?> = nil, maxSupply: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil, totalSupply: Swift.Optional<float8?> = nil, volume_24h: Swift.Optional<float8?> = nil) {
    graphQLMap = ["ath": ath, "atl": atl, "circulating_supply": circulatingSupply, "high_24h": high_24h, "low_24h": low_24h, "market_capiptalization": marketCapiptalization, "max_supply": maxSupply, "symbol": symbol, "total_supply": totalSupply, "volume_24h": volume_24h]
  }

  public var ath: Swift.Optional<float8?> {
    get {
      return graphQLMap["ath"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ath")
    }
  }

  public var atl: Swift.Optional<float8?> {
    get {
      return graphQLMap["atl"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "atl")
    }
  }

  public var circulatingSupply: Swift.Optional<float8?> {
    get {
      return graphQLMap["circulating_supply"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "circulating_supply")
    }
  }

  public var high_24h: Swift.Optional<float8?> {
    get {
      return graphQLMap["high_24h"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "high_24h")
    }
  }

  public var low_24h: Swift.Optional<float8?> {
    get {
      return graphQLMap["low_24h"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "low_24h")
    }
  }

  public var marketCapiptalization: Swift.Optional<float8?> {
    get {
      return graphQLMap["market_capiptalization"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "market_capiptalization")
    }
  }

  public var maxSupply: Swift.Optional<float8?> {
    get {
      return graphQLMap["max_supply"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "max_supply")
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

  public var totalSupply: Swift.Optional<float8?> {
    get {
      return graphQLMap["total_supply"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "total_supply")
    }
  }

  public var volume_24h: Swift.Optional<float8?> {
    get {
      return graphQLMap["volume_24h"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "volume_24h")
    }
  }
}

/// on conflict condition type for table "public_220413044555.crypto_realtime_metrics"
public struct crypto_realtime_metrics_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: crypto_realtime_metrics_constraint, updateColumns: [crypto_realtime_metrics_update_column], `where`: Swift.Optional<crypto_realtime_metrics_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: crypto_realtime_metrics_constraint {
    get {
      return graphQLMap["constraint"] as! crypto_realtime_metrics_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [crypto_realtime_metrics_update_column] {
    get {
      return graphQLMap["update_columns"] as! [crypto_realtime_metrics_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<crypto_realtime_metrics_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<crypto_realtime_metrics_bool_exp?> ?? Swift.Optional<crypto_realtime_metrics_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "public_220413044555.crypto_realtime_metrics"
public enum crypto_realtime_metrics_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case cryptoRealtimeMetricsUniqueSymbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "crypto_realtime_metrics_unique_symbol": self = .cryptoRealtimeMetricsUniqueSymbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .cryptoRealtimeMetricsUniqueSymbol: return "crypto_realtime_metrics_unique_symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: crypto_realtime_metrics_constraint, rhs: crypto_realtime_metrics_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.cryptoRealtimeMetricsUniqueSymbol, .cryptoRealtimeMetricsUniqueSymbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [crypto_realtime_metrics_constraint] {
    return [
      .cryptoRealtimeMetricsUniqueSymbol,
    ]
  }
}

/// update columns of table "public_220413044555.crypto_realtime_metrics"
public enum crypto_realtime_metrics_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case ath
  /// column name
  case atl
  /// column name
  case circulatingSupply
  /// column name
  case high_24h
  /// column name
  case low_24h
  /// column name
  case marketCapiptalization
  /// column name
  case maxSupply
  /// column name
  case symbol
  /// column name
  case totalSupply
  /// column name
  case volume_24h
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ath": self = .ath
      case "atl": self = .atl
      case "circulating_supply": self = .circulatingSupply
      case "high_24h": self = .high_24h
      case "low_24h": self = .low_24h
      case "market_capiptalization": self = .marketCapiptalization
      case "max_supply": self = .maxSupply
      case "symbol": self = .symbol
      case "total_supply": self = .totalSupply
      case "volume_24h": self = .volume_24h
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .ath: return "ath"
      case .atl: return "atl"
      case .circulatingSupply: return "circulating_supply"
      case .high_24h: return "high_24h"
      case .low_24h: return "low_24h"
      case .marketCapiptalization: return "market_capiptalization"
      case .maxSupply: return "max_supply"
      case .symbol: return "symbol"
      case .totalSupply: return "total_supply"
      case .volume_24h: return "volume_24h"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: crypto_realtime_metrics_update_column, rhs: crypto_realtime_metrics_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.ath, .ath): return true
      case (.atl, .atl): return true
      case (.circulatingSupply, .circulatingSupply): return true
      case (.high_24h, .high_24h): return true
      case (.low_24h, .low_24h): return true
      case (.marketCapiptalization, .marketCapiptalization): return true
      case (.maxSupply, .maxSupply): return true
      case (.symbol, .symbol): return true
      case (.totalSupply, .totalSupply): return true
      case (.volume_24h, .volume_24h): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [crypto_realtime_metrics_update_column] {
    return [
      .ath,
      .atl,
      .circulatingSupply,
      .high_24h,
      .low_24h,
      .marketCapiptalization,
      .maxSupply,
      .symbol,
      .totalSupply,
      .volume_24h,
    ]
  }
}

/// input type for inserting object relation for remote table "app.profile_ticker_match_score"
public struct app_profile_ticker_match_score_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_profile_ticker_match_score_insert_input, onConflict: Swift.Optional<app_profile_ticker_match_score_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_profile_ticker_match_score_insert_input {
    get {
      return graphQLMap["data"] as! app_profile_ticker_match_score_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_profile_ticker_match_score_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_profile_ticker_match_score_on_conflict?> ?? Swift.Optional<app_profile_ticker_match_score_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.profile_ticker_match_score"
public struct app_profile_ticker_match_score_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categoryMatches
  ///   - categorySimilarity
  ///   - fitsCategories
  ///   - fitsInterests
  ///   - fitsRisk
  ///   - interestMatches
  ///   - interestSimilarity
  ///   - matchScore
  ///   - matchesPortfolio
  ///   - profile
  ///   - profileId
  ///   - riskSimilarity
  ///   - symbol
  ///   - updatedAt
  public init(categoryMatches: Swift.Optional<String?> = nil, categorySimilarity: Swift.Optional<float8?> = nil, fitsCategories: Swift.Optional<Int?> = nil, fitsInterests: Swift.Optional<Int?> = nil, fitsRisk: Swift.Optional<Int?> = nil, interestMatches: Swift.Optional<String?> = nil, interestSimilarity: Swift.Optional<float8?> = nil, matchScore: Swift.Optional<Int?> = nil, matchesPortfolio: Swift.Optional<Bool?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, riskSimilarity: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["category_matches": categoryMatches, "category_similarity": categorySimilarity, "fits_categories": fitsCategories, "fits_interests": fitsInterests, "fits_risk": fitsRisk, "interest_matches": interestMatches, "interest_similarity": interestSimilarity, "match_score": matchScore, "matches_portfolio": matchesPortfolio, "profile": profile, "profile_id": profileId, "risk_similarity": riskSimilarity, "symbol": symbol, "updated_at": updatedAt]
  }

  public var categoryMatches: Swift.Optional<String?> {
    get {
      return graphQLMap["category_matches"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_matches")
    }
  }

  public var categorySimilarity: Swift.Optional<float8?> {
    get {
      return graphQLMap["category_similarity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "category_similarity")
    }
  }

  public var fitsCategories: Swift.Optional<Int?> {
    get {
      return graphQLMap["fits_categories"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_categories")
    }
  }

  public var fitsInterests: Swift.Optional<Int?> {
    get {
      return graphQLMap["fits_interests"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_interests")
    }
  }

  public var fitsRisk: Swift.Optional<Int?> {
    get {
      return graphQLMap["fits_risk"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fits_risk")
    }
  }

  public var interestMatches: Swift.Optional<String?> {
    get {
      return graphQLMap["interest_matches"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_matches")
    }
  }

  public var interestSimilarity: Swift.Optional<float8?> {
    get {
      return graphQLMap["interest_similarity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "interest_similarity")
    }
  }

  public var matchScore: Swift.Optional<Int?> {
    get {
      return graphQLMap["match_score"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "match_score")
    }
  }

  public var matchesPortfolio: Swift.Optional<Bool?> {
    get {
      return graphQLMap["matches_portfolio"] as? Swift.Optional<Bool?> ?? Swift.Optional<Bool?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "matches_portfolio")
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

  public var riskSimilarity: Swift.Optional<float8?> {
    get {
      return graphQLMap["risk_similarity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_similarity")
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

  public var updatedAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// on conflict condition type for table "app.profile_ticker_match_score"
public struct app_profile_ticker_match_score_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_profile_ticker_match_score_constraint, updateColumns: [app_profile_ticker_match_score_update_column], `where`: Swift.Optional<app_profile_ticker_match_score_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_profile_ticker_match_score_constraint {
    get {
      return graphQLMap["constraint"] as! app_profile_ticker_match_score_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_profile_ticker_match_score_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_profile_ticker_match_score_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_profile_ticker_match_score_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_profile_ticker_match_score_bool_exp?> ?? Swift.Optional<app_profile_ticker_match_score_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.profile_ticker_match_score"
public enum app_profile_ticker_match_score_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case profileTickerMatchScorePkey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "profile_ticker_match_score_pkey": self = .profileTickerMatchScorePkey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .profileTickerMatchScorePkey: return "profile_ticker_match_score_pkey"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_ticker_match_score_constraint, rhs: app_profile_ticker_match_score_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.profileTickerMatchScorePkey, .profileTickerMatchScorePkey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_ticker_match_score_constraint] {
    return [
      .profileTickerMatchScorePkey,
    ]
  }
}

/// update columns of table "app.profile_ticker_match_score"
public enum app_profile_ticker_match_score_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case categoryMatches
  /// column name
  case categorySimilarity
  /// column name
  case fitsCategories
  /// column name
  case fitsInterests
  /// column name
  case fitsRisk
  /// column name
  case interestMatches
  /// column name
  case interestSimilarity
  /// column name
  case matchScore
  /// column name
  case matchesPortfolio
  /// column name
  case profileId
  /// column name
  case riskSimilarity
  /// column name
  case symbol
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "category_matches": self = .categoryMatches
      case "category_similarity": self = .categorySimilarity
      case "fits_categories": self = .fitsCategories
      case "fits_interests": self = .fitsInterests
      case "fits_risk": self = .fitsRisk
      case "interest_matches": self = .interestMatches
      case "interest_similarity": self = .interestSimilarity
      case "match_score": self = .matchScore
      case "matches_portfolio": self = .matchesPortfolio
      case "profile_id": self = .profileId
      case "risk_similarity": self = .riskSimilarity
      case "symbol": self = .symbol
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .categoryMatches: return "category_matches"
      case .categorySimilarity: return "category_similarity"
      case .fitsCategories: return "fits_categories"
      case .fitsInterests: return "fits_interests"
      case .fitsRisk: return "fits_risk"
      case .interestMatches: return "interest_matches"
      case .interestSimilarity: return "interest_similarity"
      case .matchScore: return "match_score"
      case .matchesPortfolio: return "matches_portfolio"
      case .profileId: return "profile_id"
      case .riskSimilarity: return "risk_similarity"
      case .symbol: return "symbol"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_ticker_match_score_update_column, rhs: app_profile_ticker_match_score_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.categoryMatches, .categoryMatches): return true
      case (.categorySimilarity, .categorySimilarity): return true
      case (.fitsCategories, .fitsCategories): return true
      case (.fitsInterests, .fitsInterests): return true
      case (.fitsRisk, .fitsRisk): return true
      case (.interestMatches, .interestMatches): return true
      case (.interestSimilarity, .interestSimilarity): return true
      case (.matchScore, .matchScore): return true
      case (.matchesPortfolio, .matchesPortfolio): return true
      case (.profileId, .profileId): return true
      case (.riskSimilarity, .riskSimilarity): return true
      case (.symbol, .symbol): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_profile_ticker_match_score_update_column] {
    return [
      .categoryMatches,
      .categorySimilarity,
      .fitsCategories,
      .fitsInterests,
      .fitsRisk,
      .interestMatches,
      .interestSimilarity,
      .matchScore,
      .matchesPortfolio,
      .profileId,
      .riskSimilarity,
      .symbol,
      .updatedAt,
    ]
  }
}

/// input type for inserting object relation for remote table "public_220413044555.ticker_realtime_metrics"
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

/// input type for inserting data into table "public_220413044555.ticker_realtime_metrics"
public struct ticker_realtime_metrics_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - absoluteDailyChange
  ///   - actualPrice
  ///   - dailyVolume
  ///   - lastKnownPrice
  ///   - lastKnownPriceDatetime
  ///   - previousDayClosePrice
  ///   - relativeDailyChange
  ///   - symbol
  ///   - time
  public init(absoluteDailyChange: Swift.Optional<float8?> = nil, actualPrice: Swift.Optional<float8?> = nil, dailyVolume: Swift.Optional<float8?> = nil, lastKnownPrice: Swift.Optional<float8?> = nil, lastKnownPriceDatetime: Swift.Optional<timestamp?> = nil, previousDayClosePrice: Swift.Optional<float8?> = nil, relativeDailyChange: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil, time: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "daily_volume": dailyVolume, "last_known_price": lastKnownPrice, "last_known_price_datetime": lastKnownPriceDatetime, "previous_day_close_price": previousDayClosePrice, "relative_daily_change": relativeDailyChange, "symbol": symbol, "time": time]
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

  public var lastKnownPrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["last_known_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_known_price")
    }
  }

  public var lastKnownPriceDatetime: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["last_known_price_datetime"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "last_known_price_datetime")
    }
  }

  public var previousDayClosePrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["previous_day_close_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "previous_day_close_price")
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

/// on conflict condition type for table "public_220413044555.ticker_realtime_metrics"
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

/// unique or primary key constraints on table "public_220413044555.ticker_realtime_metrics"
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

/// update columns of table "public_220413044555.ticker_realtime_metrics"
public enum ticker_realtime_metrics_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case absoluteDailyChange
  /// column name
  case actualPrice
  /// column name
  case dailyVolume
  /// column name
  case lastKnownPrice
  /// column name
  case lastKnownPriceDatetime
  /// column name
  case previousDayClosePrice
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
      case "last_known_price": self = .lastKnownPrice
      case "last_known_price_datetime": self = .lastKnownPriceDatetime
      case "previous_day_close_price": self = .previousDayClosePrice
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
      case .lastKnownPrice: return "last_known_price"
      case .lastKnownPriceDatetime: return "last_known_price_datetime"
      case .previousDayClosePrice: return "previous_day_close_price"
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
      case (.lastKnownPrice, .lastKnownPrice): return true
      case (.lastKnownPriceDatetime, .lastKnownPriceDatetime): return true
      case (.previousDayClosePrice, .previousDayClosePrice): return true
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
      .lastKnownPrice,
      .lastKnownPriceDatetime,
      .previousDayClosePrice,
      .relativeDailyChange,
      .symbol,
      .time,
    ]
  }
}

/// input type for inserting object relation for remote table "public_220413044555.analyst_ratings"
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

/// input type for inserting data into table "public_220413044555.analyst_ratings"
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

/// on conflict condition type for table "public_220413044555.analyst_ratings"
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

/// unique or primary key constraints on table "public_220413044555.analyst_ratings"
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

/// update columns of table "public_220413044555.analyst_ratings"
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

/// input type for inserting array relation for remote table "public_220413044555.ticker_categories"
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

/// input type for inserting data into table "public_220413044555.ticker_categories"
public struct ticker_categories_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - categories
  ///   - categoryId
  ///   - id
  ///   - symbol
  ///   - updatedAt
  public init(categories: Swift.Optional<categories_obj_rel_insert_input?> = nil, categoryId: Swift.Optional<Int?> = nil, id: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["categories": categories, "category_id": categoryId, "id": id, "symbol": symbol, "updated_at": updatedAt]
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

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// on conflict condition type for table "public_220413044555.ticker_categories"
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

/// unique or primary key constraints on table "public_220413044555.ticker_categories"
public enum ticker_categories_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case tickerCategoriesUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ticker_categories_unique_id": self = .tickerCategoriesUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .tickerCategoriesUniqueId: return "ticker_categories_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_categories_constraint, rhs: ticker_categories_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.tickerCategoriesUniqueId, .tickerCategoriesUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_categories_constraint] {
    return [
      .tickerCategoriesUniqueId,
    ]
  }
}

/// update columns of table "public_220413044555.ticker_categories"
public enum ticker_categories_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case categoryId
  /// column name
  case id
  /// column name
  case symbol
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "category_id": self = .categoryId
      case "id": self = .id
      case "symbol": self = .symbol
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .categoryId: return "category_id"
      case .id: return "id"
      case .symbol: return "symbol"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_categories_update_column, rhs: ticker_categories_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.categoryId, .categoryId): return true
      case (.id, .id): return true
      case (.symbol, .symbol): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_categories_update_column] {
    return [
      .categoryId,
      .id,
      .symbol,
      .updatedAt,
    ]
  }
}

/// input type for inserting array relation for remote table "public_220413044555.profile_ticker_collections"
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

/// input type for inserting data into table "public_220413044555.profile_ticker_collections"
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

/// input type for inserting array relation for remote table "public_220413044555.ticker_events"
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

/// input type for inserting data into table "public_220413044555.ticker_events"
public struct ticker_events_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - date
  ///   - description
  ///   - id
  ///   - symbol
  ///   - timestamp
  ///   - type
  public init(createdAt: Swift.Optional<timestamptz?> = nil, date: Swift.Optional<date?> = nil, description: Swift.Optional<String?> = nil, id: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil, timestamp: Swift.Optional<timestamptz?> = nil, type: Swift.Optional<String?> = nil) {
    graphQLMap = ["created_at": createdAt, "date": date, "description": description, "id": id, "symbol": symbol, "timestamp": timestamp, "type": type]
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

/// on conflict condition type for table "public_220413044555.ticker_events"
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

/// unique or primary key constraints on table "public_220413044555.ticker_events"
public enum ticker_events_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case tickerEventsUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ticker_events_unique_id": self = .tickerEventsUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .tickerEventsUniqueId: return "ticker_events_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_events_constraint, rhs: ticker_events_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.tickerEventsUniqueId, .tickerEventsUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_events_constraint] {
    return [
      .tickerEventsUniqueId,
    ]
  }
}

/// update columns of table "public_220413044555.ticker_events"
public enum ticker_events_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case createdAt
  /// column name
  case date
  /// column name
  case description
  /// column name
  case id
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
      case "id": self = .id
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
      case .id: return "id"
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
      case (.id, .id): return true
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
      .id,
      .symbol,
      .timestamp,
      .type,
    ]
  }
}

/// input type for inserting array relation for remote table "public_220413044555.ticker_highlights"
public struct ticker_highlights_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [ticker_highlights_insert_input], onConflict: Swift.Optional<ticker_highlights_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [ticker_highlights_insert_input] {
    get {
      return graphQLMap["data"] as! [ticker_highlights_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<ticker_highlights_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<ticker_highlights_on_conflict?> ?? Swift.Optional<ticker_highlights_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "public_220413044555.ticker_highlights"
public struct ticker_highlights_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - highlight
  ///   - id
  ///   - symbol
  ///   - ticker
  public init(createdAt: Swift.Optional<timestamptz?> = nil, highlight: Swift.Optional<String?> = nil, id: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil) {
    graphQLMap = ["created_at": createdAt, "highlight": highlight, "id": id, "symbol": symbol, "ticker": ticker]
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

  public var ticker: Swift.Optional<tickers_obj_rel_insert_input?> {
    get {
      return graphQLMap["ticker"] as? Swift.Optional<tickers_obj_rel_insert_input?> ?? Swift.Optional<tickers_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker")
    }
  }
}

/// on conflict condition type for table "public_220413044555.ticker_highlights"
public struct ticker_highlights_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: ticker_highlights_constraint, updateColumns: [ticker_highlights_update_column], `where`: Swift.Optional<ticker_highlights_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: ticker_highlights_constraint {
    get {
      return graphQLMap["constraint"] as! ticker_highlights_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [ticker_highlights_update_column] {
    get {
      return graphQLMap["update_columns"] as! [ticker_highlights_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<ticker_highlights_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<ticker_highlights_bool_exp?> ?? Swift.Optional<ticker_highlights_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "public_220413044555.ticker_highlights"
public enum ticker_highlights_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case tickerHighlightsUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ticker_highlights_unique_id": self = .tickerHighlightsUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .tickerHighlightsUniqueId: return "ticker_highlights_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_highlights_constraint, rhs: ticker_highlights_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.tickerHighlightsUniqueId, .tickerHighlightsUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_highlights_constraint] {
    return [
      .tickerHighlightsUniqueId,
    ]
  }
}

/// update columns of table "public_220413044555.ticker_highlights"
public enum ticker_highlights_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case createdAt
  /// column name
  case highlight
  /// column name
  case id
  /// column name
  case symbol
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "created_at": self = .createdAt
      case "highlight": self = .highlight
      case "id": self = .id
      case "symbol": self = .symbol
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .createdAt: return "created_at"
      case .highlight: return "highlight"
      case .id: return "id"
      case .symbol: return "symbol"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_highlights_update_column, rhs: ticker_highlights_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.createdAt, .createdAt): return true
      case (.highlight, .highlight): return true
      case (.id, .id): return true
      case (.symbol, .symbol): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_highlights_update_column] {
    return [
      .createdAt,
      .highlight,
      .id,
      .symbol,
    ]
  }
}

/// input type for inserting array relation for remote table "public_220413044555.ticker_industries"
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

/// input type for inserting data into table "public_220413044555.ticker_industries"
public struct ticker_industries_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - gainyIndustry
  ///   - id
  ///   - industryId
  ///   - industryOrder
  ///   - similarity
  ///   - symbol
  ///   - ticker
  ///   - updatedAt
  public init(gainyIndustry: Swift.Optional<gainy_industries_obj_rel_insert_input?> = nil, id: Swift.Optional<String?> = nil, industryId: Swift.Optional<bigint?> = nil, industryOrder: Swift.Optional<bigint?> = nil, similarity: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil, updatedAt: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["gainy_industry": gainyIndustry, "id": id, "industry_id": industryId, "industry_order": industryOrder, "similarity": similarity, "symbol": symbol, "ticker": ticker, "updated_at": updatedAt]
  }

  public var gainyIndustry: Swift.Optional<gainy_industries_obj_rel_insert_input?> {
    get {
      return graphQLMap["gainy_industry"] as? Swift.Optional<gainy_industries_obj_rel_insert_input?> ?? Swift.Optional<gainy_industries_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gainy_industry")
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

  public var industryId: Swift.Optional<bigint?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_id")
    }
  }

  public var industryOrder: Swift.Optional<bigint?> {
    get {
      return graphQLMap["industry_order"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "industry_order")
    }
  }

  public var similarity: Swift.Optional<float8?> {
    get {
      return graphQLMap["similarity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "similarity")
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

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// input type for inserting object relation for remote table "public_220413044555.gainy_industries"
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

/// input type for inserting data into table "public_220413044555.gainy_industries"
public struct gainy_industries_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - collectionId
  ///   - id
  ///   - industryStatsDailies
  ///   - industryStatsQuarterlies
  ///   - name
  ///   - tickerIndustries
  ///   - tickerIndustryMedian_1m
  ///   - tickerIndustryMedian_1w
  ///   - updatedAt
  public init(collectionId: Swift.Optional<Int?> = nil, id: Swift.Optional<Int?> = nil, industryStatsDailies: Swift.Optional<industry_stats_daily_arr_rel_insert_input?> = nil, industryStatsQuarterlies: Swift.Optional<industry_stats_quarterly_arr_rel_insert_input?> = nil, name: Swift.Optional<String?> = nil, tickerIndustries: Swift.Optional<ticker_industries_arr_rel_insert_input?> = nil, tickerIndustryMedian_1m: Swift.Optional<industry_median_1m_arr_rel_insert_input?> = nil, tickerIndustryMedian_1w: Swift.Optional<industry_median_1w_arr_rel_insert_input?> = nil, updatedAt: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["collection_id": collectionId, "id": id, "industry_stats_dailies": industryStatsDailies, "industry_stats_quarterlies": industryStatsQuarterlies, "name": name, "ticker_industries": tickerIndustries, "ticker_industry_median_1m": tickerIndustryMedian_1m, "ticker_industry_median_1w": tickerIndustryMedian_1w, "updated_at": updatedAt]
  }

  public var collectionId: Swift.Optional<Int?> {
    get {
      return graphQLMap["collection_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_id")
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

  public var updatedAt: Swift.Optional<timestamp?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamp?> ?? Swift.Optional<timestamp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// input type for inserting array relation for remote table "public_220413044555.industry_stats_daily"
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

/// input type for inserting data into table "public_220413044555.industry_stats_daily"
public struct industry_stats_daily_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - id
  ///   - industryId
  ///   - medianGrowthRate_1d
  ///   - medianPrice
  public init(date: Swift.Optional<timestamp?> = nil, id: Swift.Optional<String?> = nil, industryId: Swift.Optional<bigint?> = nil, medianGrowthRate_1d: Swift.Optional<float8?> = nil, medianPrice: Swift.Optional<float8?> = nil) {
    graphQLMap = ["date": date, "id": id, "industry_id": industryId, "median_growth_rate_1d": medianGrowthRate_1d, "median_price": medianPrice]
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

  public var industryId: Swift.Optional<bigint?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
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

  public var medianPrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["median_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "median_price")
    }
  }
}

/// on conflict condition type for table "public_220413044555.industry_stats_daily"
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

/// unique or primary key constraints on table "public_220413044555.industry_stats_daily"
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

/// update columns of table "public_220413044555.industry_stats_daily"
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
  case medianPrice
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "date": self = .date
      case "id": self = .id
      case "industry_id": self = .industryId
      case "median_growth_rate_1d": self = .medianGrowthRate_1d
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
      .medianPrice,
    ]
  }
}

/// input type for inserting array relation for remote table "public_220413044555.industry_stats_quarterly"
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

/// input type for inserting data into table "public_220413044555.industry_stats_quarterly"
public struct industry_stats_quarterly_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - id
  ///   - industryId
  ///   - medianNetIncome
  ///   - medianRevenue
  public init(date: Swift.Optional<timestamp?> = nil, id: Swift.Optional<String?> = nil, industryId: Swift.Optional<bigint?> = nil, medianNetIncome: Swift.Optional<float8?> = nil, medianRevenue: Swift.Optional<float8?> = nil) {
    graphQLMap = ["date": date, "id": id, "industry_id": industryId, "median_net_income": medianNetIncome, "median_revenue": medianRevenue]
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

  public var industryId: Swift.Optional<bigint?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
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

/// input type for inserting array relation for remote table "public_220413044555.industry_median_1m"
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

/// input type for inserting data into table "public_220413044555.industry_median_1m"
public struct industry_median_1m_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - industryId
  ///   - medianGrowthRate
  ///   - medianPrice
  public init(date: Swift.Optional<timestamp?> = nil, industryId: Swift.Optional<bigint?> = nil, medianGrowthRate: Swift.Optional<float8?> = nil, medianPrice: Swift.Optional<float8?> = nil) {
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

  public var industryId: Swift.Optional<bigint?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
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

/// input type for inserting array relation for remote table "public_220413044555.industry_median_1w"
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

/// input type for inserting data into table "public_220413044555.industry_median_1w"
public struct industry_median_1w_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - industryId
  ///   - medianGrowthRate
  ///   - medianPrice
  public init(date: Swift.Optional<timestamp?> = nil, industryId: Swift.Optional<bigint?> = nil, medianGrowthRate: Swift.Optional<float8?> = nil, medianPrice: Swift.Optional<float8?> = nil) {
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

  public var industryId: Swift.Optional<bigint?> {
    get {
      return graphQLMap["industry_id"] as? Swift.Optional<bigint?> ?? Swift.Optional<bigint?>.none
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

/// on conflict condition type for table "public_220413044555.gainy_industries"
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

/// unique or primary key constraints on table "public_220413044555.gainy_industries"
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

/// update columns of table "public_220413044555.gainy_industries"
public enum gainy_industries_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case collectionId
  /// column name
  case id
  /// column name
  case name
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "collection_id": self = .collectionId
      case "id": self = .id
      case "name": self = .name
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .collectionId: return "collection_id"
      case .id: return "id"
      case .name: return "name"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: gainy_industries_update_column, rhs: gainy_industries_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.collectionId, .collectionId): return true
      case (.id, .id): return true
      case (.name, .name): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [gainy_industries_update_column] {
    return [
      .collectionId,
      .id,
      .name,
      .updatedAt,
    ]
  }
}

/// on conflict condition type for table "public_220413044555.ticker_industries"
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

/// unique or primary key constraints on table "public_220413044555.ticker_industries"
public enum ticker_industries_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case industryIdSymbol
  /// unique or primary key constraint
  case tickerIndustriesUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "industry_id__symbol": self = .industryIdSymbol
      case "ticker_industries_unique_id": self = .tickerIndustriesUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .industryIdSymbol: return "industry_id__symbol"
      case .tickerIndustriesUniqueId: return "ticker_industries_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_industries_constraint, rhs: ticker_industries_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.industryIdSymbol, .industryIdSymbol): return true
      case (.tickerIndustriesUniqueId, .tickerIndustriesUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_industries_constraint] {
    return [
      .industryIdSymbol,
      .tickerIndustriesUniqueId,
    ]
  }
}

/// update columns of table "public_220413044555.ticker_industries"
public enum ticker_industries_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case id
  /// column name
  case industryId
  /// column name
  case industryOrder
  /// column name
  case similarity
  /// column name
  case symbol
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "id": self = .id
      case "industry_id": self = .industryId
      case "industry_order": self = .industryOrder
      case "similarity": self = .similarity
      case "symbol": self = .symbol
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .id: return "id"
      case .industryId: return "industry_id"
      case .industryOrder: return "industry_order"
      case .similarity: return "similarity"
      case .symbol: return "symbol"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_industries_update_column, rhs: ticker_industries_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.id, .id): return true
      case (.industryId, .industryId): return true
      case (.industryOrder, .industryOrder): return true
      case (.similarity, .similarity): return true
      case (.symbol, .symbol): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_industries_update_column] {
    return [
      .id,
      .industryId,
      .industryOrder,
      .similarity,
      .symbol,
      .updatedAt,
    ]
  }
}

/// input type for inserting object relation for remote table "public_220413044555.ticker_metrics"
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

/// input type for inserting data into table "public_220413044555.ticker_metrics"
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
  ///   - epsTtm
  ///   - exchangeName
  ///   - impliedVolatility
  ///   - marketCapitalization
  ///   - netDebt
  ///   - netIncome
  ///   - netIncomeTtm
  ///   - priceChange_1m
  ///   - priceChange_1w
  ///   - priceChange_1y
  ///   - priceChange_3m
  ///   - priceChange_5y
  ///   - priceChangeAll
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
  ///   - shortPercent
  ///   - shortPercentOutstanding
  ///   - shortRatio
  ///   - symbol
  ///   - ticker
  ///   - totalAssets
  ///   - yearsOfConsecutiveDividendGrowth
  public init(absoluteHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8?> = nil, absoluteHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8?> = nil, absoluteHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8?> = nil, addressCity: Swift.Optional<String?> = nil, addressCounty: Swift.Optional<String?> = nil, addressFull: Swift.Optional<String?> = nil, addressState: Swift.Optional<String?> = nil, assetCashAndEquivalents: Swift.Optional<float8?> = nil, avgVolume_10d: Swift.Optional<float8?> = nil, avgVolume_90d: Swift.Optional<float8?> = nil, beatenQuarterlyEpsEstimationCountTtm: Swift.Optional<Int?> = nil, beta: Swift.Optional<float8?> = nil, dividendFrequency: Swift.Optional<String?> = nil, dividendPayoutRatio: Swift.Optional<float8?> = nil, dividendYield: Swift.Optional<float8?> = nil, dividendsPerShare: Swift.Optional<float8?> = nil, ebitda: Swift.Optional<float8?> = nil, ebitdaGrowthYoy: Swift.Optional<float8?> = nil, ebitdaTtm: Swift.Optional<float8?> = nil, enterpriseValueToEbitda: Swift.Optional<float8?> = nil, enterpriseValueToSales: Swift.Optional<float8?> = nil, epsActual: Swift.Optional<float8?> = nil, epsDifference: Swift.Optional<float8?> = nil, epsEstimate: Swift.Optional<float8?> = nil, epsGrowthFwd: Swift.Optional<float8?> = nil, epsGrowthYoy: Swift.Optional<float8?> = nil, epsSurprise: Swift.Optional<float8?> = nil, epsTtm: Swift.Optional<float8?> = nil, exchangeName: Swift.Optional<String?> = nil, impliedVolatility: Swift.Optional<float8?> = nil, marketCapitalization: Swift.Optional<bigint?> = nil, netDebt: Swift.Optional<float8?> = nil, netIncome: Swift.Optional<float8?> = nil, netIncomeTtm: Swift.Optional<float8?> = nil, priceChange_1m: Swift.Optional<float8?> = nil, priceChange_1w: Swift.Optional<float8?> = nil, priceChange_1y: Swift.Optional<float8?> = nil, priceChange_3m: Swift.Optional<float8?> = nil, priceChange_5y: Swift.Optional<float8?> = nil, priceChangeAll: Swift.Optional<float8?> = nil, priceToBookValue: Swift.Optional<float8?> = nil, priceToEarningsTtm: Swift.Optional<float8?> = nil, priceToSalesTtm: Swift.Optional<float8?> = nil, profitMargin: Swift.Optional<float8?> = nil, relativeHistoricalVolatilityAdjustedCurrent: Swift.Optional<float8?> = nil, relativeHistoricalVolatilityAdjustedMax_1y: Swift.Optional<float8?> = nil, relativeHistoricalVolatilityAdjustedMin_1y: Swift.Optional<float8?> = nil, revenueActual: Swift.Optional<float8?> = nil, revenueEstimateAvg_0y: Swift.Optional<float8?> = nil, revenueGrowthFwd: Swift.Optional<float8?> = nil, revenueGrowthYoy: Swift.Optional<float8?> = nil, revenuePerShareTtm: Swift.Optional<float8?> = nil, revenueTtm: Swift.Optional<float8?> = nil, roa: Swift.Optional<float8?> = nil, roi: Swift.Optional<float8?> = nil, sharesFloat: Swift.Optional<bigint?> = nil, sharesOutstanding: Swift.Optional<bigint?> = nil, shortPercent: Swift.Optional<float8?> = nil, shortPercentOutstanding: Swift.Optional<float8?> = nil, shortRatio: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil, totalAssets: Swift.Optional<float8?> = nil, yearsOfConsecutiveDividendGrowth: Swift.Optional<Int?> = nil) {
    graphQLMap = ["absolute_historical_volatility_adjusted_current": absoluteHistoricalVolatilityAdjustedCurrent, "absolute_historical_volatility_adjusted_max_1y": absoluteHistoricalVolatilityAdjustedMax_1y, "absolute_historical_volatility_adjusted_min_1y": absoluteHistoricalVolatilityAdjustedMin_1y, "address_city": addressCity, "address_county": addressCounty, "address_full": addressFull, "address_state": addressState, "asset_cash_and_equivalents": assetCashAndEquivalents, "avg_volume_10d": avgVolume_10d, "avg_volume_90d": avgVolume_90d, "beaten_quarterly_eps_estimation_count_ttm": beatenQuarterlyEpsEstimationCountTtm, "beta": beta, "dividend_frequency": dividendFrequency, "dividend_payout_ratio": dividendPayoutRatio, "dividend_yield": dividendYield, "dividends_per_share": dividendsPerShare, "ebitda": ebitda, "ebitda_growth_yoy": ebitdaGrowthYoy, "ebitda_ttm": ebitdaTtm, "enterprise_value_to_ebitda": enterpriseValueToEbitda, "enterprise_value_to_sales": enterpriseValueToSales, "eps_actual": epsActual, "eps_difference": epsDifference, "eps_estimate": epsEstimate, "eps_growth_fwd": epsGrowthFwd, "eps_growth_yoy": epsGrowthYoy, "eps_surprise": epsSurprise, "eps_ttm": epsTtm, "exchange_name": exchangeName, "implied_volatility": impliedVolatility, "market_capitalization": marketCapitalization, "net_debt": netDebt, "net_income": netIncome, "net_income_ttm": netIncomeTtm, "price_change_1m": priceChange_1m, "price_change_1w": priceChange_1w, "price_change_1y": priceChange_1y, "price_change_3m": priceChange_3m, "price_change_5y": priceChange_5y, "price_change_all": priceChangeAll, "price_to_book_value": priceToBookValue, "price_to_earnings_ttm": priceToEarningsTtm, "price_to_sales_ttm": priceToSalesTtm, "profit_margin": profitMargin, "relative_historical_volatility_adjusted_current": relativeHistoricalVolatilityAdjustedCurrent, "relative_historical_volatility_adjusted_max_1y": relativeHistoricalVolatilityAdjustedMax_1y, "relative_historical_volatility_adjusted_min_1y": relativeHistoricalVolatilityAdjustedMin_1y, "revenue_actual": revenueActual, "revenue_estimate_avg_0y": revenueEstimateAvg_0y, "revenue_growth_fwd": revenueGrowthFwd, "revenue_growth_yoy": revenueGrowthYoy, "revenue_per_share_ttm": revenuePerShareTtm, "revenue_ttm": revenueTtm, "roa": roa, "roi": roi, "shares_float": sharesFloat, "shares_outstanding": sharesOutstanding, "short_percent": shortPercent, "short_percent_outstanding": shortPercentOutstanding, "short_ratio": shortRatio, "symbol": symbol, "ticker": ticker, "total_assets": totalAssets, "years_of_consecutive_dividend_growth": yearsOfConsecutiveDividendGrowth]
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

  public var epsTtm: Swift.Optional<float8?> {
    get {
      return graphQLMap["eps_ttm"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eps_ttm")
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

  public var priceChange_1w: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_1w"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_1w")
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

  public var priceChange_5y: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_5y"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_5y")
    }
  }

  public var priceChangeAll: Swift.Optional<float8?> {
    get {
      return graphQLMap["price_change_all"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "price_change_all")
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

  public var shortPercent: Swift.Optional<float8?> {
    get {
      return graphQLMap["short_percent"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "short_percent")
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

/// on conflict condition type for table "public_220413044555.ticker_metrics"
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

/// unique or primary key constraints on table "public_220413044555.ticker_metrics"
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

/// update columns of table "public_220413044555.ticker_metrics"
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
  case epsTtm
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
  case priceChange_1w
  /// column name
  case priceChange_1y
  /// column name
  case priceChange_3m
  /// column name
  case priceChange_5y
  /// column name
  case priceChangeAll
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
  case shortPercent
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
      case "eps_ttm": self = .epsTtm
      case "exchange_name": self = .exchangeName
      case "implied_volatility": self = .impliedVolatility
      case "market_capitalization": self = .marketCapitalization
      case "net_debt": self = .netDebt
      case "net_income": self = .netIncome
      case "net_income_ttm": self = .netIncomeTtm
      case "price_change_1m": self = .priceChange_1m
      case "price_change_1w": self = .priceChange_1w
      case "price_change_1y": self = .priceChange_1y
      case "price_change_3m": self = .priceChange_3m
      case "price_change_5y": self = .priceChange_5y
      case "price_change_all": self = .priceChangeAll
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
      case "short_percent": self = .shortPercent
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
      case .epsTtm: return "eps_ttm"
      case .exchangeName: return "exchange_name"
      case .impliedVolatility: return "implied_volatility"
      case .marketCapitalization: return "market_capitalization"
      case .netDebt: return "net_debt"
      case .netIncome: return "net_income"
      case .netIncomeTtm: return "net_income_ttm"
      case .priceChange_1m: return "price_change_1m"
      case .priceChange_1w: return "price_change_1w"
      case .priceChange_1y: return "price_change_1y"
      case .priceChange_3m: return "price_change_3m"
      case .priceChange_5y: return "price_change_5y"
      case .priceChangeAll: return "price_change_all"
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
      case .shortPercent: return "short_percent"
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
      case (.epsTtm, .epsTtm): return true
      case (.exchangeName, .exchangeName): return true
      case (.impliedVolatility, .impliedVolatility): return true
      case (.marketCapitalization, .marketCapitalization): return true
      case (.netDebt, .netDebt): return true
      case (.netIncome, .netIncome): return true
      case (.netIncomeTtm, .netIncomeTtm): return true
      case (.priceChange_1m, .priceChange_1m): return true
      case (.priceChange_1w, .priceChange_1w): return true
      case (.priceChange_1y, .priceChange_1y): return true
      case (.priceChange_3m, .priceChange_3m): return true
      case (.priceChange_5y, .priceChange_5y): return true
      case (.priceChangeAll, .priceChangeAll): return true
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
      case (.shortPercent, .shortPercent): return true
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
      .epsTtm,
      .exchangeName,
      .impliedVolatility,
      .marketCapitalization,
      .netDebt,
      .netIncome,
      .netIncomeTtm,
      .priceChange_1m,
      .priceChange_1w,
      .priceChange_1y,
      .priceChange_3m,
      .priceChange_5y,
      .priceChangeAll,
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
      .shortPercent,
      .shortPercentOutstanding,
      .shortRatio,
      .symbol,
      .totalAssets,
      .yearsOfConsecutiveDividendGrowth,
    ]
  }
}

/// on conflict condition type for table "public_220413044555.tickers"
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

/// unique or primary key constraints on table "public_220413044555.tickers"
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

/// update columns of table "public_220413044555.tickers"
public enum tickers_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case countryName
  /// column name
  case description
  /// column name
  case exchange
  /// column name
  case exchangeCanonical
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
      case "exchange": self = .exchange
      case "exchange_canonical": self = .exchangeCanonical
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
      case .exchange: return "exchange"
      case .exchangeCanonical: return "exchange_canonical"
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
      case (.exchange, .exchange): return true
      case (.exchangeCanonical, .exchangeCanonical): return true
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
      .exchange,
      .exchangeCanonical,
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

/// on conflict condition type for table "public_220413044555.ticker_interests"
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

/// unique or primary key constraints on table "public_220413044555.ticker_interests"
public enum ticker_interests_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case symbolInterestId
  /// unique or primary key constraint
  case tickerInterestsUniqueId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "symbol__interest_id": self = .symbolInterestId
      case "ticker_interests_unique_id": self = .tickerInterestsUniqueId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .symbolInterestId: return "symbol__interest_id"
      case .tickerInterestsUniqueId: return "ticker_interests_unique_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_interests_constraint, rhs: ticker_interests_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.symbolInterestId, .symbolInterestId): return true
      case (.tickerInterestsUniqueId, .tickerInterestsUniqueId): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_interests_constraint] {
    return [
      .symbolInterestId,
      .tickerInterestsUniqueId,
    ]
  }
}

/// update columns of table "public_220413044555.ticker_interests"
public enum ticker_interests_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case id
  /// column name
  case interestId
  /// column name
  case simDif
  /// column name
  case symbol
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "id": self = .id
      case "interest_id": self = .interestId
      case "sim_dif": self = .simDif
      case "symbol": self = .symbol
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .id: return "id"
      case .interestId: return "interest_id"
      case .simDif: return "sim_dif"
      case .symbol: return "symbol"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_interests_update_column, rhs: ticker_interests_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.id, .id): return true
      case (.interestId, .interestId): return true
      case (.simDif, .simDif): return true
      case (.symbol, .symbol): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_interests_update_column] {
    return [
      .id,
      .interestId,
      .simDif,
      .symbol,
      .updatedAt,
    ]
  }
}

/// on conflict condition type for table "public_220413044555.interests"
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

/// unique or primary key constraints on table "public_220413044555.interests"
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

/// update columns of table "public_220413044555.interests"
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
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "enabled": self = .enabled
      case "icon_url": self = .iconUrl
      case "id": self = .id
      case "name": self = .name
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .enabled: return "enabled"
      case .iconUrl: return "icon_url"
      case .id: return "id"
      case .name: return "name"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: interests_update_column, rhs: interests_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.enabled, .enabled): return true
      case (.iconUrl, .iconUrl): return true
      case (.id, .id): return true
      case (.name, .name): return true
      case (.updatedAt, .updatedAt): return true
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
      .updatedAt,
    ]
  }
}

/// input type for inserting object relation for remote table "public_220413044555.collection_metrics"
public struct collection_metrics_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: collection_metrics_insert_input) {
    graphQLMap = ["data": data]
  }

  public var data: collection_metrics_insert_input {
    get {
      return graphQLMap["data"] as! collection_metrics_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "public_220413044555.collection_metrics"
public struct collection_metrics_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - absoluteDailyChange
  ///   - actualPrice
  ///   - collectionUniqId
  ///   - profile
  ///   - profileId
  ///   - relativeDailyChange
  ///   - updatedAt
  public init(absoluteDailyChange: Swift.Optional<float8?> = nil, actualPrice: Swift.Optional<float8?> = nil, collectionUniqId: Swift.Optional<String?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, relativeDailyChange: Swift.Optional<float8?> = nil, updatedAt: Swift.Optional<timestamp?> = nil) {
    graphQLMap = ["absolute_daily_change": absoluteDailyChange, "actual_price": actualPrice, "collection_uniq_id": collectionUniqId, "profile": profile, "profile_id": profileId, "relative_daily_change": relativeDailyChange, "updated_at": updatedAt]
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

  public var collectionUniqId: Swift.Optional<String?> {
    get {
      return graphQLMap["collection_uniq_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "collection_uniq_id")
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

  public var relativeDailyChange: Swift.Optional<float8?> {
    get {
      return graphQLMap["relative_daily_change"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "relative_daily_change")
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
  ///   - accessToken
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
  public init(accessToken: Swift.Optional<app_profile_plaid_access_tokens_obj_rel_insert_input?> = nil, account: Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> = nil, accountId: Swift.Optional<Int?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, holdingDetails: Swift.Optional<portfolio_holding_details_obj_rel_insert_input?> = nil, holdingTransactions: Swift.Optional<app_profile_portfolio_transactions_arr_rel_insert_input?> = nil, id: Swift.Optional<Int?> = nil, isoCurrencyCode: Swift.Optional<String?> = nil, plaidAccessTokenId: Swift.Optional<Int?> = nil, portfolioHoldingGains: Swift.Optional<portfolio_holding_gains_obj_rel_insert_input?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, quantity: Swift.Optional<float8?> = nil, refId: Swift.Optional<String?> = nil, security: Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> = nil, securityId: Swift.Optional<Int?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["access_token": accessToken, "account": account, "account_id": accountId, "created_at": createdAt, "holding_details": holdingDetails, "holding_transactions": holdingTransactions, "id": id, "iso_currency_code": isoCurrencyCode, "plaid_access_token_id": plaidAccessTokenId, "portfolio_holding_gains": portfolioHoldingGains, "profile": profile, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "updated_at": updatedAt]
  }

  public var accessToken: Swift.Optional<app_profile_plaid_access_tokens_obj_rel_insert_input?> {
    get {
      return graphQLMap["access_token"] as? Swift.Optional<app_profile_plaid_access_tokens_obj_rel_insert_input?> ?? Swift.Optional<app_profile_plaid_access_tokens_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "access_token")
    }
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

/// input type for inserting object relation for remote table "app.profile_plaid_access_tokens"
public struct app_profile_plaid_access_tokens_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_profile_plaid_access_tokens_insert_input, onConflict: Swift.Optional<app_profile_plaid_access_tokens_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_profile_plaid_access_tokens_insert_input {
    get {
      return graphQLMap["data"] as! app_profile_plaid_access_tokens_insert_input
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
  ///   - institution
  ///   - institutionId
  ///   - itemId
  ///   - needsReauthSince
  ///   - profile
  ///   - profileId
  public init(accessToken: Swift.Optional<String?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, id: Swift.Optional<Int?> = nil, institution: Swift.Optional<app_plaid_institutions_obj_rel_insert_input?> = nil, institutionId: Swift.Optional<Int?> = nil, itemId: Swift.Optional<String?> = nil, needsReauthSince: Swift.Optional<timestamptz?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil) {
    graphQLMap = ["access_token": accessToken, "created_at": createdAt, "id": id, "institution": institution, "institution_id": institutionId, "item_id": itemId, "needs_reauth_since": needsReauthSince, "profile": profile, "profile_id": profileId]
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

  public var institution: Swift.Optional<app_plaid_institutions_obj_rel_insert_input?> {
    get {
      return graphQLMap["institution"] as? Swift.Optional<app_plaid_institutions_obj_rel_insert_input?> ?? Swift.Optional<app_plaid_institutions_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution")
    }
  }

  public var institutionId: Swift.Optional<Int?> {
    get {
      return graphQLMap["institution_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "institution_id")
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

  public var needsReauthSince: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["needs_reauth_since"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "needs_reauth_since")
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

/// input type for inserting object relation for remote table "app.plaid_institutions"
public struct app_plaid_institutions_obj_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: app_plaid_institutions_insert_input, onConflict: Swift.Optional<app_plaid_institutions_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: app_plaid_institutions_insert_input {
    get {
      return graphQLMap["data"] as! app_plaid_institutions_insert_input
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<app_plaid_institutions_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<app_plaid_institutions_on_conflict?> ?? Swift.Optional<app_plaid_institutions_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "app.plaid_institutions"
public struct app_plaid_institutions_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - createdAt
  ///   - id
  ///   - name
  ///   - refId
  ///   - updatedAt
  public init(createdAt: Swift.Optional<timestamptz?> = nil, id: Swift.Optional<Int?> = nil, name: Swift.Optional<String?> = nil, refId: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["created_at": createdAt, "id": id, "name": name, "ref_id": refId, "updated_at": updatedAt]
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

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
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

  public var updatedAt: Swift.Optional<timestamptz?> {
    get {
      return graphQLMap["updated_at"] as? Swift.Optional<timestamptz?> ?? Swift.Optional<timestamptz?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updated_at")
    }
  }
}

/// on conflict condition type for table "app.plaid_institutions"
public struct app_plaid_institutions_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: app_plaid_institutions_constraint, updateColumns: [app_plaid_institutions_update_column], `where`: Swift.Optional<app_plaid_institutions_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: app_plaid_institutions_constraint {
    get {
      return graphQLMap["constraint"] as! app_plaid_institutions_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [app_plaid_institutions_update_column] {
    get {
      return graphQLMap["update_columns"] as! [app_plaid_institutions_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<app_plaid_institutions_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<app_plaid_institutions_bool_exp?> ?? Swift.Optional<app_plaid_institutions_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "app.plaid_institutions"
public enum app_plaid_institutions_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case plaidInstitutionsPkey
  /// unique or primary key constraint
  case plaidInstitutionsRefIdKey
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "plaid_institutions_pkey": self = .plaidInstitutionsPkey
      case "plaid_institutions_ref_id_key": self = .plaidInstitutionsRefIdKey
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .plaidInstitutionsPkey: return "plaid_institutions_pkey"
      case .plaidInstitutionsRefIdKey: return "plaid_institutions_ref_id_key"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_plaid_institutions_constraint, rhs: app_plaid_institutions_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.plaidInstitutionsPkey, .plaidInstitutionsPkey): return true
      case (.plaidInstitutionsRefIdKey, .plaidInstitutionsRefIdKey): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_plaid_institutions_constraint] {
    return [
      .plaidInstitutionsPkey,
      .plaidInstitutionsRefIdKey,
    ]
  }
}

/// update columns of table "app.plaid_institutions"
public enum app_plaid_institutions_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case createdAt
  /// column name
  case id
  /// column name
  case name
  /// column name
  case refId
  /// column name
  case updatedAt
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "created_at": self = .createdAt
      case "id": self = .id
      case "name": self = .name
      case "ref_id": self = .refId
      case "updated_at": self = .updatedAt
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .createdAt: return "created_at"
      case .id: return "id"
      case .name: return "name"
      case .refId: return "ref_id"
      case .updatedAt: return "updated_at"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_plaid_institutions_update_column, rhs: app_plaid_institutions_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.createdAt, .createdAt): return true
      case (.id, .id): return true
      case (.name, .name): return true
      case (.refId, .refId): return true
      case (.updatedAt, .updatedAt): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [app_plaid_institutions_update_column] {
    return [
      .createdAt,
      .id,
      .name,
      .refId,
      .updatedAt,
    ]
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
  case institutionId
  /// column name
  case itemId
  /// column name
  case needsReauthSince
  /// column name
  case profileId
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "access_token": self = .accessToken
      case "created_at": self = .createdAt
      case "id": self = .id
      case "institution_id": self = .institutionId
      case "item_id": self = .itemId
      case "needs_reauth_since": self = .needsReauthSince
      case "profile_id": self = .profileId
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .accessToken: return "access_token"
      case .createdAt: return "created_at"
      case .id: return "id"
      case .institutionId: return "institution_id"
      case .itemId: return "item_id"
      case .needsReauthSince: return "needs_reauth_since"
      case .profileId: return "profile_id"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: app_profile_plaid_access_tokens_update_column, rhs: app_profile_plaid_access_tokens_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.accessToken, .accessToken): return true
      case (.createdAt, .createdAt): return true
      case (.id, .id): return true
      case (.institutionId, .institutionId): return true
      case (.itemId, .itemId): return true
      case (.needsReauthSince, .needsReauthSince): return true
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
      .institutionId,
      .itemId,
      .needsReauthSince,
      .profileId,
    ]
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

/// input type for inserting object relation for remote table "public_220413044555.portfolio_holding_details"
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

/// input type for inserting data into table "public_220413044555.portfolio_holding_details"
public struct portfolio_holding_details_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - accountId
  ///   - avgCost
  ///   - holding
  ///   - holdingId
  ///   - lttQuantityTotal
  ///   - marketCapitalization
  ///   - name
  ///   - nextEarningsDate
  ///   - purchaseDate
  ///   - quantity
  ///   - relativeGain_1d
  ///   - relativeGainTotal
  ///   - securityType
  ///   - ticker
  ///   - tickerName
  ///   - tickerSymbol
  ///   - valueToPortfolioValue
  public init(accountId: Swift.Optional<Int?> = nil, avgCost: Swift.Optional<float8?> = nil, holding: Swift.Optional<app_profile_holdings_obj_rel_insert_input?> = nil, holdingId: Swift.Optional<Int?> = nil, lttQuantityTotal: Swift.Optional<float8?> = nil, marketCapitalization: Swift.Optional<bigint?> = nil, name: Swift.Optional<String?> = nil, nextEarningsDate: Swift.Optional<timestamp?> = nil, purchaseDate: Swift.Optional<timestamp?> = nil, quantity: Swift.Optional<float8?> = nil, relativeGain_1d: Swift.Optional<float8?> = nil, relativeGainTotal: Swift.Optional<float8?> = nil, securityType: Swift.Optional<String?> = nil, ticker: Swift.Optional<tickers_obj_rel_insert_input?> = nil, tickerName: Swift.Optional<String?> = nil, tickerSymbol: Swift.Optional<String?> = nil, valueToPortfolioValue: Swift.Optional<float8?> = nil) {
    graphQLMap = ["account_id": accountId, "avg_cost": avgCost, "holding": holding, "holding_id": holdingId, "ltt_quantity_total": lttQuantityTotal, "market_capitalization": marketCapitalization, "name": name, "next_earnings_date": nextEarningsDate, "purchase_date": purchaseDate, "quantity": quantity, "relative_gain_1d": relativeGain_1d, "relative_gain_total": relativeGainTotal, "security_type": securityType, "ticker": ticker, "ticker_name": tickerName, "ticker_symbol": tickerSymbol, "value_to_portfolio_value": valueToPortfolioValue]
  }

  public var accountId: Swift.Optional<Int?> {
    get {
      return graphQLMap["account_id"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "account_id")
    }
  }

  public var avgCost: Swift.Optional<float8?> {
    get {
      return graphQLMap["avg_cost"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "avg_cost")
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

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
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

  public var quantity: Swift.Optional<float8?> {
    get {
      return graphQLMap["quantity"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "quantity")
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

/// on conflict condition type for table "public_220413044555.portfolio_holding_details"
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

/// unique or primary key constraints on table "public_220413044555.portfolio_holding_details"
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

/// update columns of table "public_220413044555.portfolio_holding_details"
public enum portfolio_holding_details_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case accountId
  /// column name
  case avgCost
  /// column name
  case holdingId
  /// column name
  case lttQuantityTotal
  /// column name
  case marketCapitalization
  /// column name
  case name
  /// column name
  case nextEarningsDate
  /// column name
  case purchaseDate
  /// column name
  case quantity
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
      case "avg_cost": self = .avgCost
      case "holding_id": self = .holdingId
      case "ltt_quantity_total": self = .lttQuantityTotal
      case "market_capitalization": self = .marketCapitalization
      case "name": self = .name
      case "next_earnings_date": self = .nextEarningsDate
      case "purchase_date": self = .purchaseDate
      case "quantity": self = .quantity
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
      case .avgCost: return "avg_cost"
      case .holdingId: return "holding_id"
      case .lttQuantityTotal: return "ltt_quantity_total"
      case .marketCapitalization: return "market_capitalization"
      case .name: return "name"
      case .nextEarningsDate: return "next_earnings_date"
      case .purchaseDate: return "purchase_date"
      case .quantity: return "quantity"
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
      case (.avgCost, .avgCost): return true
      case (.holdingId, .holdingId): return true
      case (.lttQuantityTotal, .lttQuantityTotal): return true
      case (.marketCapitalization, .marketCapitalization): return true
      case (.name, .name): return true
      case (.nextEarningsDate, .nextEarningsDate): return true
      case (.purchaseDate, .purchaseDate): return true
      case (.quantity, .quantity): return true
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
      .avgCost,
      .holdingId,
      .lttQuantityTotal,
      .marketCapitalization,
      .name,
      .nextEarningsDate,
      .purchaseDate,
      .quantity,
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
  public init(account: Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> = nil, accountId: Swift.Optional<Int?> = nil, amount: Swift.Optional<float8?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, date: Swift.Optional<date?> = nil, fees: Swift.Optional<float8?> = nil, id: Swift.Optional<Int?> = nil, isoCurrencyCode: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, plaidAccessTokenId: Swift.Optional<Int?> = nil, price: Swift.Optional<float8?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, quantity: Swift.Optional<float8?> = nil, refId: Swift.Optional<String?> = nil, security: Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> = nil, securityId: Swift.Optional<Int?> = nil, subtype: Swift.Optional<String?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["account": account, "account_id": accountId, "amount": amount, "created_at": createdAt, "date": date, "fees": fees, "id": id, "iso_currency_code": isoCurrencyCode, "name": name, "plaid_access_token_id": plaidAccessTokenId, "price": price, "profile": profile, "profile_id": profileId, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "subtype": subtype, "type": type, "updated_at": updatedAt]
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

/// input type for inserting object relation for remote table "public_220413044555.portfolio_holding_gains"
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

/// input type for inserting data into table "public_220413044555.portfolio_holding_gains"
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

/// on conflict condition type for table "public_220413044555.portfolio_holding_gains"
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

/// unique or primary key constraints on table "public_220413044555.portfolio_holding_gains"
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

/// update columns of table "public_220413044555.portfolio_holding_gains"
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
  ///   - riskScore
  ///   - stockMarketRiskLevel
  ///   - tradingExperience
  ///   - unexpectedPurchasesSource
  public init(averageMarketReturn: Swift.Optional<Int?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, damageOfFailure: Swift.Optional<Double?> = nil, ifMarketDrops_20IWillBuy: Swift.Optional<Double?> = nil, ifMarketDrops_40IWillBuy: Swift.Optional<Double?> = nil, investmentHorizon: Swift.Optional<Double?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, riskLevel: Swift.Optional<Double?> = nil, riskScore: Swift.Optional<Int?> = nil, stockMarketRiskLevel: Swift.Optional<String?> = nil, tradingExperience: Swift.Optional<String?> = nil, unexpectedPurchasesSource: Swift.Optional<String?> = nil) {
    graphQLMap = ["average_market_return": averageMarketReturn, "created_at": createdAt, "damage_of_failure": damageOfFailure, "if_market_drops_20_i_will_buy": ifMarketDrops_20IWillBuy, "if_market_drops_40_i_will_buy": ifMarketDrops_40IWillBuy, "investment_horizon": investmentHorizon, "profile": profile, "profile_id": profileId, "risk_level": riskLevel, "risk_score": riskScore, "stock_market_risk_level": stockMarketRiskLevel, "trading_experience": tradingExperience, "unexpected_purchases_source": unexpectedPurchasesSource]
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

  public var riskScore: Swift.Optional<Int?> {
    get {
      return graphQLMap["risk_score"] as? Swift.Optional<Int?> ?? Swift.Optional<Int?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "risk_score")
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
  case riskScore
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
      case "risk_score": self = .riskScore
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
      case .riskScore: return "risk_score"
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
      case (.riskScore, .riskScore): return true
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
      .riskScore,
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
