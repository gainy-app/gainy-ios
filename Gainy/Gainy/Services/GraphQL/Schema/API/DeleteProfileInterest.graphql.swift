// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DeleteProfileInterestMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeleteProfileInterest($profileID: Int!, $interestID: Int!) {
      delete_app_profile_interests(
        where: {interest_id: {_eq: $interestID}, profile_id: {_eq: $profileID}}
      ) {
        __typename
        returning {
          __typename
          interest_id
        }
      }
    }
    """

  public let operationName: String = "DeleteProfileInterest"

  public var profileID: Int
  public var interestID: Int

  public init(profileID: Int, interestID: Int) {
    self.profileID = profileID
    self.interestID = interestID
  }

  public var variables: GraphQLMap? {
    return ["profileID": profileID, "interestID": interestID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("delete_app_profile_interests", arguments: ["where": ["interest_id": ["_eq": GraphQLVariable("interestID")], "profile_id": ["_eq": GraphQLVariable("profileID")]]], type: .object(DeleteAppProfileInterest.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteAppProfileInterests: DeleteAppProfileInterest? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "delete_app_profile_interests": deleteAppProfileInterests.flatMap { (value: DeleteAppProfileInterest) -> ResultMap in value.resultMap }])
    }

    /// delete data from the table: "app.profile_interests"
    public var deleteAppProfileInterests: DeleteAppProfileInterest? {
      get {
        return (resultMap["delete_app_profile_interests"] as? ResultMap).flatMap { DeleteAppProfileInterest(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "delete_app_profile_interests")
      }
    }

    public struct DeleteAppProfileInterest: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_profile_interests_mutation_response"]

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
        self.init(unsafeResultMap: ["__typename": "app_profile_interests_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
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
