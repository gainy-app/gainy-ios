// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UpdateProfileMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateProfile($profileID: Int!, $firstName: String!, $lastName: String!, $email: String!, $legalAddress: String!) {
      update_app_profiles(
        where: {id: {_eq: $profileID}}
        _set: {first_name: $firstName, last_name: $lastName, legal_address: $legalAddress, email: $email}
      ) {
        __typename
        returning {
          __typename
          first_name
          email
          id
          last_name
          legal_address
          profile_categories {
            __typename
            category_id
          }
          profile_interests {
            __typename
            interest_id
          }
        }
      }
    }
    """

  public let operationName: String = "UpdateProfile"

  public var profileID: Int
  public var firstName: String
  public var lastName: String
  public var email: String
  public var legalAddress: String

  public init(profileID: Int, firstName: String, lastName: String, email: String, legalAddress: String) {
    self.profileID = profileID
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.legalAddress = legalAddress
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "firstName": firstName, "lastName": lastName, "email": email, "legalAddress": legalAddress]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("update_app_profiles", arguments: ["where": ["id": ["_eq": GraphQLVariable("profileID")]], "_set": ["first_name": GraphQLVariable("firstName"), "last_name": GraphQLVariable("lastName"), "legal_address": GraphQLVariable("legalAddress"), "email": GraphQLVariable("email")]], type: .object(UpdateAppProfile.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateAppProfiles: UpdateAppProfile? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "update_app_profiles": updateAppProfiles.flatMap { (value: UpdateAppProfile) -> ResultMap in value.resultMap }])
    }

    /// update data of the table: "app.profiles"
    public var updateAppProfiles: UpdateAppProfile? {
      get {
        return (resultMap["update_app_profiles"] as? ResultMap).flatMap { UpdateAppProfile(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "update_app_profiles")
      }
    }

    public struct UpdateAppProfile: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profiles_mutation_response"]

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
        self.init(unsafeResultMap: ["__typename": "app_profiles_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
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
        public static let possibleTypes: [String] = ["app_profiles"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("first_name", type: .nonNull(.scalar(String.self))),
            GraphQLField("email", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("last_name", type: .nonNull(.scalar(String.self))),
            GraphQLField("legal_address", type: .scalar(String.self)),
            GraphQLField("profile_categories", type: .nonNull(.list(.nonNull(.object(ProfileCategory.selections))))),
            GraphQLField("profile_interests", type: .nonNull(.list(.nonNull(.object(ProfileInterest.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(firstName: String, email: String, id: Int, lastName: String, legalAddress: String? = nil, profileCategories: [ProfileCategory], profileInterests: [ProfileInterest]) {
          self.init(unsafeResultMap: ["__typename": "app_profiles", "first_name": firstName, "email": email, "id": id, "last_name": lastName, "legal_address": legalAddress, "profile_categories": profileCategories.map { (value: ProfileCategory) -> ResultMap in value.resultMap }, "profile_interests": profileInterests.map { (value: ProfileInterest) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var email: String {
          get {
            return resultMap["email"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
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
        public var profileInterests: [ProfileInterest] {
          get {
            return (resultMap["profile_interests"] as! [ResultMap]).map { (value: ResultMap) -> ProfileInterest in ProfileInterest(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: ProfileInterest) -> ResultMap in value.resultMap }, forKey: "profile_interests")
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
      }
    }
  }
}
