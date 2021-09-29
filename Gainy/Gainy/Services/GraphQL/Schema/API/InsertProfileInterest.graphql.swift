// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class InsertProfileInterestMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation InsertProfileInterest($profileID: Int!, $interestID: Int!) {
      insert_app_profile_interests(
        objects: {interest_id: $interestID, profile_id: $profileID}
      ) {
        __typename
        returning {
          __typename
          interest_id
        }
      }
    }
    """

  public let operationName: String = "InsertProfileInterest"

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
        GraphQLField("insert_app_profile_interests", arguments: ["objects": ["interest_id": GraphQLVariable("interestID"), "profile_id": GraphQLVariable("profileID")]], type: .object(InsertAppProfileInterest.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertAppProfileInterests: InsertAppProfileInterest? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_app_profile_interests": insertAppProfileInterests.flatMap { (value: InsertAppProfileInterest) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "app.profile_interests"
    public var insertAppProfileInterests: InsertAppProfileInterest? {
      get {
        return (resultMap["insert_app_profile_interests"] as? ResultMap).flatMap { InsertAppProfileInterest(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_app_profile_interests")
      }
    }

    public struct InsertAppProfileInterest: GraphQLSelectionSet {
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
