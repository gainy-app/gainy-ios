// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class KycSendFormMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation KycSendForm($profile_id: Int!) {
      kyc_send_form(profile_id: $profile_id) {
        __typename
        message
        status
      }
    }
    """

  public let operationName: String = "KycSendForm"

  public var profile_id: Int

  public init(profile_id: Int) {
    self.profile_id = profile_id
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("kyc_send_form", arguments: ["profile_id": GraphQLVariable("profile_id")], type: .object(KycSendForm.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(kycSendForm: KycSendForm? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "kyc_send_form": kycSendForm.flatMap { (value: KycSendForm) -> ResultMap in value.resultMap }])
    }

    public var kycSendForm: KycSendForm? {
      get {
        return (resultMap["kyc_send_form"] as? ResultMap).flatMap { KycSendForm(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "kyc_send_form")
      }
    }

    public struct KycSendForm: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["KycStatus"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(message: String? = nil, status: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "KycStatus", "message": message, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var status: String? {
        get {
          return resultMap["status"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }
    }
  }
}
