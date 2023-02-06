// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class CreateAppProfileNoOnboardingMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateAppProfileNoOnboarding($email: String!, $firstName: String!, $lastName: String!, $userID: String!) {
      insert_app_profiles(
        objects: {email: $email, first_name: $firstName, last_name: $lastName, user_id: $userID}
      ) {
        __typename
        returning {
          __typename
          id
        }
      }
    }
    """

  public let operationName: String = "CreateAppProfileNoOnboarding"

  public var email: String
  public var firstName: String
  public var lastName: String
  public var userID: String

  public init(email: String, firstName: String, lastName: String, userID: String) {
    self.email = email
    self.firstName = firstName
    self.lastName = lastName
    self.userID = userID
  }

  public var variables: GraphQLMap? {
    return ["email": email, "firstName": firstName, "lastName": lastName, "userID": userID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("insert_app_profiles", arguments: ["objects": ["email": GraphQLVariable("email"), "first_name": GraphQLVariable("firstName"), "last_name": GraphQLVariable("lastName"), "user_id": GraphQLVariable("userID")]], type: .object(InsertAppProfile.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfiles: InsertAppProfile? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profiles": insertAppProfiles.flatMap { (value: InsertAppProfile) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.profiles"
    public var insertAppProfiles: InsertAppProfile? {
      get {
        return (resultMap["insert_app_profiles"] as? ResultMap).flatMap { InsertAppProfile(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profiles")
      }
    }

    public struct InsertAppProfile: GraphQLSelectionSet {
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
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int) {
          self.init(unsafeResultMap: ["__typename": "app_profiles", "id": id])
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
      }
    }
  }
}
