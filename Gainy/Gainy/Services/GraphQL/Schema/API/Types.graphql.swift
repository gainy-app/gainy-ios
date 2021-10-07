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
  ///   - profileCategories
  ///   - profileFavoriteCollections
  ///   - profileInterests
  ///   - profileScoringSetting
  ///   - userId
  public init(avatarUrl: Swift.Optional<String?> = nil, createdAt: Swift.Optional<timestamptz?> = nil, email: Swift.Optional<String?> = nil, firstName: Swift.Optional<String?> = nil, gender: Swift.Optional<Int?> = nil, id: Swift.Optional<Int?> = nil, lastName: Swift.Optional<String?> = nil, legalAddress: Swift.Optional<String?> = nil, profileCategories: Swift.Optional<app_profile_categories_arr_rel_insert_input?> = nil, profileFavoriteCollections: Swift.Optional<app_profile_favorite_collections_arr_rel_insert_input?> = nil, profileInterests: Swift.Optional<app_profile_interests_arr_rel_insert_input?> = nil, profileScoringSetting: Swift.Optional<app_profile_scoring_settings_obj_rel_insert_input?> = nil, userId: Swift.Optional<String?> = nil) {
    graphQLMap = ["avatar_url": avatarUrl, "created_at": createdAt, "email": email, "first_name": firstName, "gender": gender, "id": id, "last_name": lastName, "legal_address": legalAddress, "profile_categories": profileCategories, "profile_favorite_collections": profileFavoriteCollections, "profile_interests": profileInterests, "profile_scoring_setting": profileScoringSetting, "user_id": userId]
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

  public var userId: Swift.Optional<String?> {
    get {
      return graphQLMap["user_id"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "user_id")
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
  ///   - profileCategories
  ///   - profileFavoriteCollections
  ///   - profileInterests
  ///   - profileScoringSetting
  ///   - userId
  public init(_and: Swift.Optional<[app_profiles_bool_exp]?> = nil, _not: Swift.Optional<app_profiles_bool_exp?> = nil, _or: Swift.Optional<[app_profiles_bool_exp]?> = nil, avatarUrl: Swift.Optional<String_comparison_exp?> = nil, createdAt: Swift.Optional<timestamptz_comparison_exp?> = nil, email: Swift.Optional<String_comparison_exp?> = nil, firstName: Swift.Optional<String_comparison_exp?> = nil, gender: Swift.Optional<Int_comparison_exp?> = nil, id: Swift.Optional<Int_comparison_exp?> = nil, lastName: Swift.Optional<String_comparison_exp?> = nil, legalAddress: Swift.Optional<String_comparison_exp?> = nil, profileCategories: Swift.Optional<app_profile_categories_bool_exp?> = nil, profileFavoriteCollections: Swift.Optional<app_profile_favorite_collections_bool_exp?> = nil, profileInterests: Swift.Optional<app_profile_interests_bool_exp?> = nil, profileScoringSetting: Swift.Optional<app_profile_scoring_settings_bool_exp?> = nil, userId: Swift.Optional<String_comparison_exp?> = nil) {
    graphQLMap = ["_and": _and, "_not": _not, "_or": _or, "avatar_url": avatarUrl, "created_at": createdAt, "email": email, "first_name": firstName, "gender": gender, "id": id, "last_name": lastName, "legal_address": legalAddress, "profile_categories": profileCategories, "profile_favorite_collections": profileFavoriteCollections, "profile_interests": profileInterests, "profile_scoring_setting": profileScoringSetting, "user_id": userId]
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
