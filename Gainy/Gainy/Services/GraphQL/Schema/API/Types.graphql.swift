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
  ///   - portfolioSecurities
  ///   - profileCategories
  ///   - profileFavoriteCollections
  ///   - profileHoldings
  ///   - profileInterests
  ///   - profileScoringSetting
  ///   - profileWatchlistTickers
  ///   - userId
  public init(avatarUrl: Swift.Optional<String?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, email: Swift.Optional<String?> = nil, firstName: Swift.Optional<String?> = nil, gender: Swift.Optional<Int?> = nil, id: Swift.Optional<Int?> = nil, lastName: Swift.Optional<String?> = nil, legalAddress: Swift.Optional<String?> = nil, portfolioSecurities: Swift.Optional<app_portfolio_securities_arr_rel_insert_input?> = nil, profileCategories: Swift.Optional<app_profile_categories_arr_rel_insert_input?> = nil, profileFavoriteCollections: Swift.Optional<app_profile_favorite_collections_arr_rel_insert_input?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> = nil, profileInterests: Swift.Optional<app_profile_interests_arr_rel_insert_input?> = nil, profileScoringSetting: Swift.Optional<app_profile_scoring_settings_obj_rel_insert_input?> = nil, profileWatchlistTickers: Swift.Optional<app_profile_watchlist_tickers_arr_rel_insert_input?> = nil, userId: Swift.Optional<String?> = nil) {
    graphQLMap = ["avatar_url": avatarUrl, "created_at": createdAt, "email": email, "first_name": firstName, "gender": gender, "id": id, "last_name": lastName, "legal_address": legalAddress, "portfolio_securities": portfolioSecurities, "profile_categories": profileCategories, "profile_favorite_collections": profileFavoriteCollections, "profile_holdings": profileHoldings, "profile_interests": profileInterests, "profile_scoring_setting": profileScoringSetting, "profile_watchlist_tickers": profileWatchlistTickers, "user_id": userId]
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

  public var portfolioSecurities: Swift.Optional<app_portfolio_securities_arr_rel_insert_input?> {
    get {
      return graphQLMap["portfolio_securities"] as? Swift.Optional<app_portfolio_securities_arr_rel_insert_input?> ?? Swift.Optional<app_portfolio_securities_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_securities")
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

/// input type for inserting array relation for remote table "app.portfolio_securities"
public struct app_portfolio_securities_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [app_portfolio_securities_insert_input], onConflict: Swift.Optional<app_portfolio_securities_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [app_portfolio_securities_insert_input] {
    get {
      return graphQLMap["data"] as! [app_portfolio_securities_insert_input]
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
  ///   - profile
  ///   - profileHoldings
  ///   - profileId
  ///   - refId
  ///   - tickerSymbol
  ///   - tickers
  ///   - type
  ///   - updatedAt
  public init(closePrice: Swift.Optional<float8?> = nil, closePriceAsOf: Swift.Optional<date?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, id: Swift.Optional<Int?> = nil, isoCurrencyCode: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, refId: Swift.Optional<String?> = nil, tickerSymbol: Swift.Optional<String?> = nil, tickers: Swift.Optional<tickers_obj_rel_insert_input?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["close_price": closePrice, "close_price_as_of": closePriceAsOf, "created_at": createdAt, "id": id, "iso_currency_code": isoCurrencyCode, "name": name, "profile": profile, "profile_holdings": profileHoldings, "profile_id": profileId, "ref_id": refId, "ticker_symbol": tickerSymbol, "tickers": tickers, "type": type, "updated_at": updatedAt]
  }

  public var closePrice: Swift.Optional<float8?> {
    get {
      return graphQLMap["close_price"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close_price")
    }
  }

  public var closePriceAsOf: Swift.Optional<date?> {
    get {
      return graphQLMap["close_price_as_of"] as? Swift.Optional<date?> ?? Swift.Optional<date?>.none
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
  ///   - accountId
  ///   - createdAt
  ///   - id
  ///   - isoCurrencyCode
  ///   - profile
  ///   - profileId
  ///   - profilePortfolioAccount
  ///   - quantity
  ///   - refId
  ///   - security
  ///   - securityId
  ///   - updatedAt
  public init(accountId: Swift.Optional<Int?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, id: Swift.Optional<Int?> = nil, isoCurrencyCode: Swift.Optional<String?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, profilePortfolioAccount: Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> = nil, quantity: Swift.Optional<float8?> = nil, refId: Swift.Optional<String?> = nil, security: Swift.Optional<app_portfolio_securities_obj_rel_insert_input?> = nil, securityId: Swift.Optional<Int?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["account_id": accountId, "created_at": createdAt, "id": id, "iso_currency_code": isoCurrencyCode, "profile": profile, "profile_id": profileId, "profile_portfolio_account": profilePortfolioAccount, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "updated_at": updatedAt]
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

  public var profilePortfolioAccount: Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> {
    get {
      return graphQLMap["profile_portfolio_account"] as? Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?> ?? Swift.Optional<app_profile_portfolio_accounts_obj_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_portfolio_account")
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
  ///   - profile
  ///   - profileHoldings
  ///   - profileId
  ///   - refId
  ///   - subtype
  ///   - type
  ///   - updatedAt
  public init(balanceAvailable: Swift.Optional<float8?> = nil, balanceCurrent: Swift.Optional<float8?> = nil, balanceIsoCurrencyCode: Swift.Optional<String?> = nil, balanceLimit: Swift.Optional<float8?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, id: Swift.Optional<Int?> = nil, mask: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, officialName: Swift.Optional<String?> = nil, profile: Swift.Optional<app_profiles_obj_rel_insert_input?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_arr_rel_insert_input?> = nil, profileId: Swift.Optional<Int?> = nil, refId: Swift.Optional<String?> = nil, subtype: Swift.Optional<String?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamptz?> = nil) {
    graphQLMap = ["balance_available": balanceAvailable, "balance_current": balanceCurrent, "balance_iso_currency_code": balanceIsoCurrencyCode, "balance_limit": balanceLimit, "created_at": createdAt, "id": id, "mask": mask, "name": name, "official_name": officialName, "profile": profile, "profile_holdings": profileHoldings, "profile_id": profileId, "ref_id": refId, "subtype": subtype, "type": type, "updated_at": updatedAt]
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
      .profileId,
      .refId,
      .subtype,
      .type,
      .updatedAt,
    ]
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
  ///   - profile
  ///   - profileHoldings
  ///   - profileId
  ///   - refId
  ///   - subtype
  ///   - type
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?> = nil, _not: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> = nil, _or: Swift.Optional<[app_profile_portfolio_accounts_bool_exp]?> = nil, balanceAvailable: Swift.Optional<float8_comparison_exp?> = nil, balanceCurrent: Swift.Optional<float8_comparison_exp?> = nil, balanceIsoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, balanceLimit: Swift.Optional<float8_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, mask: Swift.Optional<String_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, officialName: Swift.Optional<String_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, subtype: Swift.Optional<String_comparison_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "balance_available": balanceAvailable, "balance_current": balanceCurrent, "balance_iso_currency_code": balanceIsoCurrencyCode, "balance_limit": balanceLimit, "created_at": createdAt, "id": id, "mask": mask, "name": name, "official_name": officialName, "profile": profile, "profile_holdings": profileHoldings, "profile_id": profileId, "ref_id": refId, "subtype": subtype, "type": type, "updated_at": updatedAt]
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
  ///   - portfolioSecurities
  ///   - profileCategories
  ///   - profileFavoriteCollections
  ///   - profileHoldings
  ///   - profileInterests
  ///   - profileScoringSetting
  ///   - profileWatchlistTickers
  ///   - userId
  public init(_and: Swift.Optional<[app_profiles_bool_exp]?> = nil, _not: Swift.Optional<app_profiles_bool_exp?> = nil, _or: Swift.Optional<[app_profiles_bool_exp]?> = nil, avatarUrl: Swift.Optional<String_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, email: Swift.Optional<String_comparison_exp?> = nil, firstName: Swift.Optional<String_comparison_exp?> = nil, gender: Swift.Optional<Int_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, lastName: Swift.Optional<String_comparison_exp?> = nil, legalAddress: Swift.Optional<String_comparison_exp?> = nil, portfolioSecurities: Swift.Optional<app_portfolio_securities_bool_exp?> = nil, profileCategories: Swift.Optional<app_profile_categories_bool_exp?> = nil, profileFavoriteCollections: Swift.Optional<app_profile_favorite_collections_bool_exp?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> = nil, profileInterests: Swift.Optional<app_profile_interests_bool_exp?> = nil, profileScoringSetting: Swift.Optional<app_profile_scoring_settings_bool_exp?> = nil, profileWatchlistTickers: Swift.Optional<app_profile_watchlist_tickers_bool_exp?> = nil, userId: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "avatar_url": avatarUrl, "created_at": createdAt, "email": email, "first_name": firstName, "gender": gender, "id": id, "last_name": lastName, "legal_address": legalAddress, "portfolio_securities": portfolioSecurities, "profile_categories": profileCategories, "profile_favorite_collections": profileFavoriteCollections, "profile_holdings": profileHoldings, "profile_interests": profileInterests, "profile_scoring_setting": profileScoringSetting, "profile_watchlist_tickers": profileWatchlistTickers, "user_id": userId]
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

  public var portfolioSecurities: Swift.Optional<app_portfolio_securities_bool_exp?> {
    get {
      return graphQLMap["portfolio_securities"] as? Swift.Optional<app_portfolio_securities_bool_exp?> ?? Swift.Optional<app_portfolio_securities_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "portfolio_securities")
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
  ///   - profile
  ///   - profileHoldings
  ///   - profileId
  ///   - refId
  ///   - tickerSymbol
  ///   - tickers
  ///   - type
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_portfolio_securities_bool_exp]?> = nil, _not: Swift.Optional<app_portfolio_securities_bool_exp?> = nil, _or: Swift.Optional<[app_portfolio_securities_bool_exp]?> = nil, closePrice: Swift.Optional<float8_comparison_exp?> = nil, closePriceAsOf: Swift.Optional<date_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, isoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileHoldings: Swift.Optional<app_profile_holdings_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, tickerSymbol: Swift.Optional<String_comparison_exp?> = nil, tickers: Swift.Optional<tickers_bool_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "close_price": closePrice, "close_price_as_of": closePriceAsOf, "created_at": createdAt, "id": id, "iso_currency_code": isoCurrencyCode, "name": name, "profile": profile, "profile_holdings": profileHoldings, "profile_id": profileId, "ref_id": refId, "ticker_symbol": tickerSymbol, "tickers": tickers, "type": type, "updated_at": updatedAt]
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

  public var closePriceAsOf: Swift.Optional<date_comparison_exp?> {
    get {
      return graphQLMap["close_price_as_of"] as? Swift.Optional<date_comparison_exp?> ?? Swift.Optional<date_comparison_exp?>.none
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

/// Boolean expression to filter rows from the table "app.profile_holdings". All fields are combined with a logical 'AND'.
public struct app_profile_holdings_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - accountId
  ///   - createdAt
  ///   - id
  ///   - isoCurrencyCode
  ///   - profile
  ///   - profileId
  ///   - profilePortfolioAccount
  ///   - quantity
  ///   - refId
  ///   - security
  ///   - securityId
  ///   - updatedAt
  public init(_and: Swift.Optional<[app_profile_holdings_bool_exp]?> = nil, _not: Swift.Optional<app_profile_holdings_bool_exp?> = nil, _or: Swift.Optional<[app_profile_holdings_bool_exp]?> = nil, accountId: Swift.Optional<Int_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, isoCurrencyCode: Swift.Optional<String_comparison_exp?> = nil, profile: Swift.Optional<app_profiles_bool_exp?> = nil, profileId: Swift.Optional<Int_comparison_exp?> = nil, profilePortfolioAccount: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> = nil, quantity: Swift.Optional<float8_comparison_exp?> = nil, refId: Swift.Optional<String_comparison_exp?> = nil, security: Swift.Optional<app_portfolio_securities_bool_exp?> = nil, securityId: Swift.Optional<Int_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamptz_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "account_id": accountId, "created_at": createdAt, "id": id, "iso_currency_code": isoCurrencyCode, "profile": profile, "profile_id": profileId, "profile_portfolio_account": profilePortfolioAccount, "quantity": quantity, "ref_id": refId, "security": security, "security_id": securityId, "updated_at": updatedAt]
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

  public var profilePortfolioAccount: Swift.Optional<app_profile_portfolio_accounts_bool_exp?> {
    get {
      return graphQLMap["profile_portfolio_account"] as? Swift.Optional<app_profile_portfolio_accounts_bool_exp?> ?? Swift.Optional<app_profile_portfolio_accounts_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "profile_portfolio_account")
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
  ///   - historicalPrices
  ///   - industry
  ///   - ipoDate
  ///   - logoUrl
  ///   - name
  ///   - phone
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
  ///   - tickerHistoricalPrices_1m
  ///   - tickerHistoricalPrices_1w
  ///   - tickerIndustries
  ///   - tickerInterests
  ///   - type
  ///   - updatedAt
  ///   - webUrl
  public init(_and: Swift.Optional<[tickers_bool_exp]?> = nil, _not: Swift.Optional<tickers_bool_exp?> = nil, _or: Swift.Optional<[tickers_bool_exp]?> = nil, countryName: Swift.Optional<String_comparison_exp?> = nil, description: Swift.Optional<String_comparison_exp?> = nil, gicGroup: Swift.Optional<String_comparison_exp?> = nil, gicIndustry: Swift.Optional<String_comparison_exp?> = nil, gicSector: Swift.Optional<String_comparison_exp?> = nil, gicSubIndustry: Swift.Optional<String_comparison_exp?> = nil, historicalGrowthRates: Swift.Optional<historical_growth_rate_bool_exp?> = nil, historicalPrices: Swift.Optional<historical_prices_bool_exp?> = nil, industry: Swift.Optional<String_comparison_exp?> = nil, ipoDate: Swift.Optional<date_comparison_exp?> = nil, logoUrl: Swift.Optional<String_comparison_exp?> = nil, name: Swift.Optional<String_comparison_exp?> = nil, phone: Swift.Optional<String_comparison_exp?> = nil, sector: Swift.Optional<String_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil, tickerAnalystRatings: Swift.Optional<analyst_ratings_bool_exp?> = nil, tickerCategories: Swift.Optional<ticker_categories_bool_exp?> = nil, tickerCollections: Swift.Optional<ticker_collections_bool_exp?> = nil, tickerEvents: Swift.Optional<ticker_events_bool_exp?> = nil, tickerFinancials: Swift.Optional<ticker_financials_bool_exp?> = nil, tickerGrowthRate_1m: Swift.Optional<growth_rate_1m_bool_exp?> = nil, tickerGrowthRate_1w: Swift.Optional<growth_rate_1w_bool_exp?> = nil, tickerHighlights: Swift.Optional<ticker_highlights_bool_exp?> = nil, tickerHistoricalPrices_1m: Swift.Optional<historical_prices_1m_bool_exp?> = nil, tickerHistoricalPrices_1w: Swift.Optional<historical_prices_1w_bool_exp?> = nil, tickerIndustries: Swift.Optional<ticker_industries_bool_exp?> = nil, tickerInterests: Swift.Optional<ticker_interests_bool_exp?> = nil, type: Swift.Optional<String_comparison_exp?> = nil, updatedAt: Swift.Optional<timestamp_comparison_exp?> = nil, webUrl: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "country_name": countryName, "description": description, "gic_group": gicGroup, "gic_industry": gicIndustry, "gic_sector": gicSector, "gic_sub_industry": gicSubIndustry, "historical_growth_rates": historicalGrowthRates, "historical_prices": historicalPrices, "industry": industry, "ipo_date": ipoDate, "logo_url": logoUrl, "name": name, "phone": phone, "sector": sector, "symbol": symbol, "ticker_analyst_ratings": tickerAnalystRatings, "ticker_categories": tickerCategories, "ticker_collections": tickerCollections, "ticker_events": tickerEvents, "ticker_financials": tickerFinancials, "ticker_growth_rate_1m": tickerGrowthRate_1m, "ticker_growth_rate_1w": tickerGrowthRate_1w, "ticker_highlights": tickerHighlights, "ticker_historical_prices_1m": tickerHistoricalPrices_1m, "ticker_historical_prices_1w": tickerHistoricalPrices_1w, "ticker_industries": tickerIndustries, "ticker_interests": tickerInterests, "type": type, "updated_at": updatedAt, "web_url": webUrl]
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

  public var historicalPrices: Swift.Optional<historical_prices_bool_exp?> {
    get {
      return graphQLMap["historical_prices"] as? Swift.Optional<historical_prices_bool_exp?> ?? Swift.Optional<historical_prices_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "historical_prices")
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

  public var tickerHistoricalPrices_1m: Swift.Optional<historical_prices_1m_bool_exp?> {
    get {
      return graphQLMap["ticker_historical_prices_1m"] as? Swift.Optional<historical_prices_1m_bool_exp?> ?? Swift.Optional<historical_prices_1m_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_historical_prices_1m")
    }
  }

  public var tickerHistoricalPrices_1w: Swift.Optional<historical_prices_1w_bool_exp?> {
    get {
      return graphQLMap["ticker_historical_prices_1w"] as? Swift.Optional<historical_prices_1w_bool_exp?> ?? Swift.Optional<historical_prices_1w_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_historical_prices_1w")
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
  ///   - symbol
  public init(_and: Swift.Optional<[historical_growth_rate_bool_exp]?> = nil, _not: Swift.Optional<historical_growth_rate_bool_exp?> = nil, _or: Swift.Optional<[historical_growth_rate_bool_exp]?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, growthRate_1d: Swift.Optional<float8_comparison_exp?> = nil, growthRate_1m: Swift.Optional<float8_comparison_exp?> = nil, growthRate_1w: Swift.Optional<float8_comparison_exp?> = nil, growthRate_1y: Swift.Optional<float8_comparison_exp?> = nil, growthRate_3m: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "growth_rate_1d": growthRate_1d, "growth_rate_1m": growthRate_1m, "growth_rate_1w": growthRate_1w, "growth_rate_1y": growthRate_1y, "growth_rate_3m": growthRate_3m, "symbol": symbol]
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

  public var symbol: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// Boolean expression to filter rows from the table "historical_prices". All fields are combined with a logical 'AND'.
public struct historical_prices_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - adjustedClose
  ///   - close
  ///   - code
  ///   - date
  ///   - high
  ///   - low
  ///   - open
  ///   - volume
  public init(_and: Swift.Optional<[historical_prices_bool_exp]?> = nil, _not: Swift.Optional<historical_prices_bool_exp?> = nil, _or: Swift.Optional<[historical_prices_bool_exp]?> = nil, adjustedClose: Swift.Optional<float8_comparison_exp?> = nil, close: Swift.Optional<float8_comparison_exp?> = nil, code: Swift.Optional<String_comparison_exp?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, high: Swift.Optional<float8_comparison_exp?> = nil, low: Swift.Optional<float8_comparison_exp?> = nil, `open`: Swift.Optional<float8_comparison_exp?> = nil, volume: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "adjusted_close": adjustedClose, "close": close, "code": code, "date": date, "high": high, "low": low, "open": `open`, "volume": volume]
  }

  public var _and: Swift.Optional<[historical_prices_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[historical_prices_bool_exp]?> ?? Swift.Optional<[historical_prices_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<historical_prices_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<historical_prices_bool_exp?> ?? Swift.Optional<historical_prices_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[historical_prices_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[historical_prices_bool_exp]?> ?? Swift.Optional<[historical_prices_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var adjustedClose: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["adjusted_close"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "adjusted_close")
    }
  }

  public var close: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["close"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close")
    }
  }

  public var code: Swift.Optional<String_comparison_exp?> {
    get {
      return graphQLMap["code"] as? Swift.Optional<String_comparison_exp?> ?? Swift.Optional<String_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "code")
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

  public var high: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["high"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "high")
    }
  }

  public var low: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["low"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "low")
    }
  }

  public var `open`: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["open"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "open")
    }
  }

  public var volume: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["volume"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "volume")
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

/// Boolean expression to filter rows from the table "app.profile_ticker_collections". All fields are combined with a logical 'AND'.
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

/// Boolean expression to filter rows from the table "historical_prices_1m". All fields are combined with a logical 'AND'.
public struct historical_prices_1m_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - adjustedClose
  ///   - close
  ///   - date
  ///   - open
  ///   - symbol
  public init(_and: Swift.Optional<[historical_prices_1m_bool_exp]?> = nil, _not: Swift.Optional<historical_prices_1m_bool_exp?> = nil, _or: Swift.Optional<[historical_prices_1m_bool_exp]?> = nil, adjustedClose: Swift.Optional<float8_comparison_exp?> = nil, close: Swift.Optional<float8_comparison_exp?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, `open`: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "adjusted_close": adjustedClose, "close": close, "date": date, "open": `open`, "symbol": symbol]
  }

  public var _and: Swift.Optional<[historical_prices_1m_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[historical_prices_1m_bool_exp]?> ?? Swift.Optional<[historical_prices_1m_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<historical_prices_1m_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<historical_prices_1m_bool_exp?> ?? Swift.Optional<historical_prices_1m_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[historical_prices_1m_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[historical_prices_1m_bool_exp]?> ?? Swift.Optional<[historical_prices_1m_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var adjustedClose: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["adjusted_close"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "adjusted_close")
    }
  }

  public var close: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["close"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close")
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

  public var `open`: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["open"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "open")
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

/// Boolean expression to filter rows from the table "historical_prices_1w". All fields are combined with a logical 'AND'.
public struct historical_prices_1w_bool_exp: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - _and
  ///   - _not
  ///   - _or
  ///   - adjustedClose
  ///   - close
  ///   - date
  ///   - open
  ///   - symbol
  public init(_and: Swift.Optional<[historical_prices_1w_bool_exp]?> = nil, _not: Swift.Optional<historical_prices_1w_bool_exp?> = nil, _or: Swift.Optional<[historical_prices_1w_bool_exp]?> = nil, adjustedClose: Swift.Optional<float8_comparison_exp?> = nil, close: Swift.Optional<float8_comparison_exp?> = nil, date: Swift.Optional<date_comparison_exp?> = nil, `open`: Swift.Optional<float8_comparison_exp?> = nil, symbol: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "adjusted_close": adjustedClose, "close": close, "date": date, "open": `open`, "symbol": symbol]
  }

  public var _and: Swift.Optional<[historical_prices_1w_bool_exp]?> {
    get {
      return graphQLMap["_and"] as? Swift.Optional<[historical_prices_1w_bool_exp]?> ?? Swift.Optional<[historical_prices_1w_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_and")
    }
  }

  public var _not: Swift.Optional<historical_prices_1w_bool_exp?> {
    get {
      return graphQLMap["_not"] as? Swift.Optional<historical_prices_1w_bool_exp?> ?? Swift.Optional<historical_prices_1w_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_not")
    }
  }

  public var _or: Swift.Optional<[historical_prices_1w_bool_exp]?> {
    get {
      return graphQLMap["_or"] as? Swift.Optional<[historical_prices_1w_bool_exp]?> ?? Swift.Optional<[historical_prices_1w_bool_exp]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "_or")
    }
  }

  public var adjustedClose: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["adjusted_close"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "adjusted_close")
    }
  }

  public var close: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["close"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close")
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

  public var `open`: Swift.Optional<float8_comparison_exp?> {
    get {
      return graphQLMap["open"] as? Swift.Optional<float8_comparison_exp?> ?? Swift.Optional<float8_comparison_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "open")
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
  ///   - industryId
  ///   - medianGrowthRate_1d
  ///   - medianGrowthRate_1m
  ///   - medianGrowthRate_1w
  ///   - medianGrowthRate_1y
  ///   - medianGrowthRate_3m
  ///   - medianPrice
  public init(_and: Swift.Optional<[industry_stats_daily_bool_exp]?> = nil, _not: Swift.Optional<industry_stats_daily_bool_exp?> = nil, _or: Swift.Optional<[industry_stats_daily_bool_exp]?> = nil, date: Swift.Optional<timestamp_comparison_exp?> = nil, industryId: Swift.Optional<Int_comparison_exp?> = nil, medianGrowthRate_1d: Swift.Optional<float8_comparison_exp?> = nil, medianGrowthRate_1m: Swift.Optional<float8_comparison_exp?> = nil, medianGrowthRate_1w: Swift.Optional<float8_comparison_exp?> = nil, medianGrowthRate_1y: Swift.Optional<float8_comparison_exp?> = nil, medianGrowthRate_3m: Swift.Optional<float8_comparison_exp?> = nil, medianPrice: Swift.Optional<float8_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "date": date, "industry_id": industryId, "median_growth_rate_1d": medianGrowthRate_1d, "median_growth_rate_1m": medianGrowthRate_1m, "median_growth_rate_1w": medianGrowthRate_1w, "median_growth_rate_1y": medianGrowthRate_1y, "median_growth_rate_3m": medianGrowthRate_3m, "median_price": medianPrice]
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
  case profileId
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
      case "profile_id": self = .profileId
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
      case .profileId: return "profile_id"
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
      case (.profileId, .profileId): return true
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
      .profileId,
      .refId,
      .tickerSymbol,
      .type,
      .updatedAt,
    ]
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
  ///   - historicalPrices
  ///   - industry
  ///   - ipoDate
  ///   - logoUrl
  ///   - name
  ///   - phone
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
  ///   - tickerHistoricalPrices_1m
  ///   - tickerHistoricalPrices_1w
  ///   - tickerIndustries
  ///   - tickerInterests
  ///   - type
  ///   - updatedAt
  ///   - webUrl
  public init(countryName: Swift.Optional<String?> = nil, description: Swift.Optional<String?> = nil, gicGroup: Swift.Optional<String?> = nil, gicIndustry: Swift.Optional<String?> = nil, gicSector: Swift.Optional<String?> = nil, gicSubIndustry: Swift.Optional<String?> = nil, historicalGrowthRates: Swift.Optional<historical_growth_rate_arr_rel_insert_input?> = nil, historicalPrices: Swift.Optional<historical_prices_arr_rel_insert_input?> = nil, industry: Swift.Optional<String?> = nil, ipoDate: Swift.Optional<date?> = nil, logoUrl: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, phone: Swift.Optional<String?> = nil, sector: Swift.Optional<String?> = nil, symbol: Swift.Optional<String?> = nil, tickerAnalystRatings: Swift.Optional<analyst_ratings_obj_rel_insert_input?> = nil, tickerCategories: Swift.Optional<ticker_categories_arr_rel_insert_input?> = nil, tickerCollections: Swift.Optional<ticker_collections_arr_rel_insert_input?> = nil, tickerEvents: Swift.Optional<ticker_events_arr_rel_insert_input?> = nil, tickerFinancials: Swift.Optional<ticker_financials_arr_rel_insert_input?> = nil, tickerGrowthRate_1m: Swift.Optional<growth_rate_1m_arr_rel_insert_input?> = nil, tickerGrowthRate_1w: Swift.Optional<growth_rate_1w_arr_rel_insert_input?> = nil, tickerHighlights: Swift.Optional<ticker_highlights_arr_rel_insert_input?> = nil, tickerHistoricalPrices_1m: Swift.Optional<historical_prices_1m_arr_rel_insert_input?> = nil, tickerHistoricalPrices_1w: Swift.Optional<historical_prices_1w_arr_rel_insert_input?> = nil, tickerIndustries: Swift.Optional<ticker_industries_arr_rel_insert_input?> = nil, tickerInterests: Swift.Optional<ticker_interests_arr_rel_insert_input?> = nil, type: Swift.Optional<String?> = nil, updatedAt: Swift.Optional<timestamp?> = nil, webUrl: Swift.Optional<String?> = nil) {
    graphQLMap = ["country_name": countryName, "description": description, "gic_group": gicGroup, "gic_industry": gicIndustry, "gic_sector": gicSector, "gic_sub_industry": gicSubIndustry, "historical_growth_rates": historicalGrowthRates, "historical_prices": historicalPrices, "industry": industry, "ipo_date": ipoDate, "logo_url": logoUrl, "name": name, "phone": phone, "sector": sector, "symbol": symbol, "ticker_analyst_ratings": tickerAnalystRatings, "ticker_categories": tickerCategories, "ticker_collections": tickerCollections, "ticker_events": tickerEvents, "ticker_financials": tickerFinancials, "ticker_growth_rate_1m": tickerGrowthRate_1m, "ticker_growth_rate_1w": tickerGrowthRate_1w, "ticker_highlights": tickerHighlights, "ticker_historical_prices_1m": tickerHistoricalPrices_1m, "ticker_historical_prices_1w": tickerHistoricalPrices_1w, "ticker_industries": tickerIndustries, "ticker_interests": tickerInterests, "type": type, "updated_at": updatedAt, "web_url": webUrl]
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

  public var historicalPrices: Swift.Optional<historical_prices_arr_rel_insert_input?> {
    get {
      return graphQLMap["historical_prices"] as? Swift.Optional<historical_prices_arr_rel_insert_input?> ?? Swift.Optional<historical_prices_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "historical_prices")
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

  public var tickerHistoricalPrices_1m: Swift.Optional<historical_prices_1m_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_historical_prices_1m"] as? Swift.Optional<historical_prices_1m_arr_rel_insert_input?> ?? Swift.Optional<historical_prices_1m_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_historical_prices_1m")
    }
  }

  public var tickerHistoricalPrices_1w: Swift.Optional<historical_prices_1w_arr_rel_insert_input?> {
    get {
      return graphQLMap["ticker_historical_prices_1w"] as? Swift.Optional<historical_prices_1w_arr_rel_insert_input?> ?? Swift.Optional<historical_prices_1w_arr_rel_insert_input?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ticker_historical_prices_1w")
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
  public init(data: [historical_growth_rate_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [historical_growth_rate_insert_input] {
    get {
      return graphQLMap["data"] as! [historical_growth_rate_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
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
  ///   - symbol
  public init(date: Swift.Optional<date?> = nil, growthRate_1d: Swift.Optional<float8?> = nil, growthRate_1m: Swift.Optional<float8?> = nil, growthRate_1w: Swift.Optional<float8?> = nil, growthRate_1y: Swift.Optional<float8?> = nil, growthRate_3m: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["date": date, "growth_rate_1d": growthRate_1d, "growth_rate_1m": growthRate_1m, "growth_rate_1w": growthRate_1w, "growth_rate_1y": growthRate_1y, "growth_rate_3m": growthRate_3m, "symbol": symbol]
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

  public var symbol: Swift.Optional<String?> {
    get {
      return graphQLMap["symbol"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "symbol")
    }
  }
}

/// input type for inserting array relation for remote table "historical_prices"
public struct historical_prices_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  ///   - onConflict: on conflict condition
  public init(data: [historical_prices_insert_input], onConflict: Swift.Optional<historical_prices_on_conflict?> = nil) {
    graphQLMap = ["data": data, "on_conflict": onConflict]
  }

  public var data: [historical_prices_insert_input] {
    get {
      return graphQLMap["data"] as! [historical_prices_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }

  /// on conflict condition
  public var onConflict: Swift.Optional<historical_prices_on_conflict?> {
    get {
      return graphQLMap["on_conflict"] as? Swift.Optional<historical_prices_on_conflict?> ?? Swift.Optional<historical_prices_on_conflict?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "on_conflict")
    }
  }
}

/// input type for inserting data into table "historical_prices"
public struct historical_prices_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - adjustedClose
  ///   - close
  ///   - code
  ///   - date
  ///   - high
  ///   - low
  ///   - open
  ///   - volume
  public init(adjustedClose: Swift.Optional<float8?> = nil, close: Swift.Optional<float8?> = nil, code: Swift.Optional<String?> = nil, date: Swift.Optional<date?> = nil, high: Swift.Optional<float8?> = nil, low: Swift.Optional<float8?> = nil, `open`: Swift.Optional<float8?> = nil, volume: Swift.Optional<float8?> = nil) {
    graphQLMap = ["adjusted_close": adjustedClose, "close": close, "code": code, "date": date, "high": high, "low": low, "open": `open`, "volume": volume]
  }

  public var adjustedClose: Swift.Optional<float8?> {
    get {
      return graphQLMap["adjusted_close"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "adjusted_close")
    }
  }

  public var close: Swift.Optional<float8?> {
    get {
      return graphQLMap["close"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close")
    }
  }

  public var code: Swift.Optional<String?> {
    get {
      return graphQLMap["code"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "code")
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

  public var high: Swift.Optional<float8?> {
    get {
      return graphQLMap["high"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "high")
    }
  }

  public var low: Swift.Optional<float8?> {
    get {
      return graphQLMap["low"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "low")
    }
  }

  public var `open`: Swift.Optional<float8?> {
    get {
      return graphQLMap["open"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "open")
    }
  }

  public var volume: Swift.Optional<float8?> {
    get {
      return graphQLMap["volume"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "volume")
    }
  }
}

/// on conflict condition type for table "historical_prices"
public struct historical_prices_on_conflict: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - constraint
  ///   - updateColumns
  ///   - where
  public init(constraint: historical_prices_constraint, updateColumns: [historical_prices_update_column], `where`: Swift.Optional<historical_prices_bool_exp?> = nil) {
    graphQLMap = ["constraint": constraint, "update_columns": updateColumns, "where": `where`]
  }

  public var constraint: historical_prices_constraint {
    get {
      return graphQLMap["constraint"] as! historical_prices_constraint
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "constraint")
    }
  }

  public var updateColumns: [historical_prices_update_column] {
    get {
      return graphQLMap["update_columns"] as! [historical_prices_update_column]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "update_columns")
    }
  }

  public var `where`: Swift.Optional<historical_prices_bool_exp?> {
    get {
      return graphQLMap["where"] as? Swift.Optional<historical_prices_bool_exp?> ?? Swift.Optional<historical_prices_bool_exp?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "where")
    }
  }
}

/// unique or primary key constraints on table "historical_prices"
public enum historical_prices_constraint: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// unique or primary key constraint
  case publicHistoricalPricesCodeDate_20211109_210542
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_historical_prices_code__date_20211109_210542": self = .publicHistoricalPricesCodeDate_20211109_210542
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicHistoricalPricesCodeDate_20211109_210542: return "public_historical_prices_code__date_20211109_210542"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: historical_prices_constraint, rhs: historical_prices_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicHistoricalPricesCodeDate_20211109_210542, .publicHistoricalPricesCodeDate_20211109_210542): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [historical_prices_constraint] {
    return [
      .publicHistoricalPricesCodeDate_20211109_210542,
    ]
  }
}

/// update columns of table "historical_prices"
public enum historical_prices_update_column: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// column name
  case adjustedClose
  /// column name
  case close
  /// column name
  case code
  /// column name
  case date
  /// column name
  case high
  /// column name
  case low
  /// column name
  case `open`
  /// column name
  case volume
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "adjusted_close": self = .adjustedClose
      case "close": self = .close
      case "code": self = .code
      case "date": self = .date
      case "high": self = .high
      case "low": self = .low
      case "open": self = .open
      case "volume": self = .volume
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .adjustedClose: return "adjusted_close"
      case .close: return "close"
      case .code: return "code"
      case .date: return "date"
      case .high: return "high"
      case .low: return "low"
      case .open: return "open"
      case .volume: return "volume"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: historical_prices_update_column, rhs: historical_prices_update_column) -> Bool {
    switch (lhs, rhs) {
      case (.adjustedClose, .adjustedClose): return true
      case (.close, .close): return true
      case (.code, .code): return true
      case (.date, .date): return true
      case (.high, .high): return true
      case (.low, .low): return true
      case (.open, .open): return true
      case (.volume, .volume): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [historical_prices_update_column] {
    return [
      .adjustedClose,
      .close,
      .code,
      .date,
      .high,
      .low,
      .open,
      .volume,
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
  case publicTickerCategoriesSymbolCategoryId_20211109_210542
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_ticker_categories_symbol__category_id_20211109_210542": self = .publicTickerCategoriesSymbolCategoryId_20211109_210542
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicTickerCategoriesSymbolCategoryId_20211109_210542: return "public_ticker_categories_symbol__category_id_20211109_210542"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_categories_constraint, rhs: ticker_categories_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicTickerCategoriesSymbolCategoryId_20211109_210542, .publicTickerCategoriesSymbolCategoryId_20211109_210542): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_categories_constraint] {
    return [
      .publicTickerCategoriesSymbolCategoryId_20211109_210542,
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

/// input type for inserting array relation for remote table "app.profile_ticker_collections"
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

/// input type for inserting data into table "app.profile_ticker_collections"
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
  case publicTickerEventsSymbol_20211109_210542
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_ticker_events_symbol_20211109_210542": self = .publicTickerEventsSymbol_20211109_210542
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicTickerEventsSymbol_20211109_210542: return "public_ticker_events_symbol_20211109_210542"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_events_constraint, rhs: ticker_events_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicTickerEventsSymbol_20211109_210542, .publicTickerEventsSymbol_20211109_210542): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_events_constraint] {
    return [
      .publicTickerEventsSymbol_20211109_210542,
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

/// input type for inserting array relation for remote table "historical_prices_1m"
public struct historical_prices_1m_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [historical_prices_1m_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [historical_prices_1m_insert_input] {
    get {
      return graphQLMap["data"] as! [historical_prices_1m_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "historical_prices_1m"
public struct historical_prices_1m_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - adjustedClose
  ///   - close
  ///   - date
  ///   - open
  ///   - symbol
  public init(adjustedClose: Swift.Optional<float8?> = nil, close: Swift.Optional<float8?> = nil, date: Swift.Optional<date?> = nil, `open`: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["adjusted_close": adjustedClose, "close": close, "date": date, "open": `open`, "symbol": symbol]
  }

  public var adjustedClose: Swift.Optional<float8?> {
    get {
      return graphQLMap["adjusted_close"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "adjusted_close")
    }
  }

  public var close: Swift.Optional<float8?> {
    get {
      return graphQLMap["close"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close")
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

  public var `open`: Swift.Optional<float8?> {
    get {
      return graphQLMap["open"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "open")
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

/// input type for inserting array relation for remote table "historical_prices_1w"
public struct historical_prices_1w_arr_rel_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - data
  public init(data: [historical_prices_1w_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [historical_prices_1w_insert_input] {
    get {
      return graphQLMap["data"] as! [historical_prices_1w_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "historical_prices_1w"
public struct historical_prices_1w_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - adjustedClose
  ///   - close
  ///   - date
  ///   - open
  ///   - symbol
  public init(adjustedClose: Swift.Optional<float8?> = nil, close: Swift.Optional<float8?> = nil, date: Swift.Optional<date?> = nil, `open`: Swift.Optional<float8?> = nil, symbol: Swift.Optional<String?> = nil) {
    graphQLMap = ["adjusted_close": adjustedClose, "close": close, "date": date, "open": `open`, "symbol": symbol]
  }

  public var adjustedClose: Swift.Optional<float8?> {
    get {
      return graphQLMap["adjusted_close"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "adjusted_close")
    }
  }

  public var close: Swift.Optional<float8?> {
    get {
      return graphQLMap["close"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "close")
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

  public var `open`: Swift.Optional<float8?> {
    get {
      return graphQLMap["open"] as? Swift.Optional<float8?> ?? Swift.Optional<float8?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "open")
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
  public init(data: [industry_stats_daily_insert_input]) {
    graphQLMap = ["data": data]
  }

  public var data: [industry_stats_daily_insert_input] {
    get {
      return graphQLMap["data"] as! [industry_stats_daily_insert_input]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "data")
    }
  }
}

/// input type for inserting data into table "industry_stats_daily"
public struct industry_stats_daily_insert_input: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - industryId
  ///   - medianGrowthRate_1d
  ///   - medianGrowthRate_1m
  ///   - medianGrowthRate_1w
  ///   - medianGrowthRate_1y
  ///   - medianGrowthRate_3m
  ///   - medianPrice
  public init(date: Swift.Optional<timestamp?> = nil, industryId: Swift.Optional<Int?> = nil, medianGrowthRate_1d: Swift.Optional<float8?> = nil, medianGrowthRate_1m: Swift.Optional<float8?> = nil, medianGrowthRate_1w: Swift.Optional<float8?> = nil, medianGrowthRate_1y: Swift.Optional<float8?> = nil, medianGrowthRate_3m: Swift.Optional<float8?> = nil, medianPrice: Swift.Optional<float8?> = nil) {
    graphQLMap = ["date": date, "industry_id": industryId, "median_growth_rate_1d": medianGrowthRate_1d, "median_growth_rate_1m": medianGrowthRate_1m, "median_growth_rate_1w": medianGrowthRate_1w, "median_growth_rate_1y": medianGrowthRate_1y, "median_growth_rate_3m": medianGrowthRate_3m, "median_price": medianPrice]
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
  case publicTickerIndustriesIndustryIdSymbol_20211109_210542
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_ticker_industries_industry_id__symbol_20211109_210542": self = .publicTickerIndustriesIndustryIdSymbol_20211109_210542
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicTickerIndustriesIndustryIdSymbol_20211109_210542: return "public_ticker_industries_industry_id__symbol_20211109_210542"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_industries_constraint, rhs: ticker_industries_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicTickerIndustriesIndustryIdSymbol_20211109_210542, .publicTickerIndustriesIndustryIdSymbol_20211109_210542): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_industries_constraint] {
    return [
      .publicTickerIndustriesIndustryIdSymbol_20211109_210542,
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
  case publicTickerInterestsSymbolInterestId_20211109_210542
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "public_ticker_interests_symbol__interest_id_20211109_210542": self = .publicTickerInterestsSymbolInterestId_20211109_210542
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .publicTickerInterestsSymbolInterestId_20211109_210542: return "public_ticker_interests_symbol__interest_id_20211109_210542"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ticker_interests_constraint, rhs: ticker_interests_constraint) -> Bool {
    switch (lhs, rhs) {
      case (.publicTickerInterestsSymbolInterestId_20211109_210542, .publicTickerInterestsSymbolInterestId_20211109_210542): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ticker_interests_constraint] {
    return [
      .publicTickerInterestsSymbolInterestId_20211109_210542,
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
