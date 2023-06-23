// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetInvitationHistoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetInvitationHistory($profile_id: Int!) {
      invitation_history(
        where: {profile_id: {_eq: $profile_id}}
        order_by: {invited_at: desc}
      ) {
        __typename
        name
        step1_signed_up
        step2_brokerate_account_open
        step3_deposited_enough
        is_complete
        invited_profile_id
      }
    }
    """

  public let operationName: String = "GetInvitationHistory"

  public var profile_id: Int

  public init(profile_id: Int) {
    self.profile_id = profile_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("invitation_history", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")]], "order_by": ["invited_at": "desc"]], type: .nonNull(.list(.nonNull(.object(InvitationHistory.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(invitationHistory: [InvitationHistory]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "invitation_history": invitationHistory.map { (value: InvitationHistory) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "public_230623092519.invitation_history"
    public var invitationHistory: [InvitationHistory] {
      get {
        return (resultMap["invitation_history"] as! [ResultMap]).map { (value: ResultMap) -> InvitationHistory in InvitationHistory(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: InvitationHistory) -> ResultMap in value.resultMap }, forKey: "invitation_history")
      }
    }

    public struct InvitationHistory: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["invitation_history"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("step1_signed_up", type: .scalar(Bool.self)),
          GraphQLField("step2_brokerate_account_open", type: .scalar(Bool.self)),
          GraphQLField("step3_deposited_enough", type: .scalar(Bool.self)),
          GraphQLField("is_complete", type: .scalar(Bool.self)),
          GraphQLField("invited_profile_id", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, step1SignedUp: Bool? = nil, step2BrokerateAccountOpen: Bool? = nil, step3DepositedEnough: Bool? = nil, isComplete: Bool? = nil, invitedProfileId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "invitation_history", "name": name, "step1_signed_up": step1SignedUp, "step2_brokerate_account_open": step2BrokerateAccountOpen, "step3_deposited_enough": step3DepositedEnough, "is_complete": isComplete, "invited_profile_id": invitedProfileId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var step1SignedUp: Bool? {
        get {
          return resultMap["step1_signed_up"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "step1_signed_up")
        }
      }

      public var step2BrokerateAccountOpen: Bool? {
        get {
          return resultMap["step2_brokerate_account_open"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "step2_brokerate_account_open")
        }
      }

      public var step3DepositedEnough: Bool? {
        get {
          return resultMap["step3_deposited_enough"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "step3_deposited_enough")
        }
      }

      public var isComplete: Bool? {
        get {
          return resultMap["is_complete"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "is_complete")
        }
      }

      public var invitedProfileId: Int? {
        get {
          return resultMap["invited_profile_id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "invited_profile_id")
        }
      }
    }
  }
}
