// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class VerificationSendCodeMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation VerificationSendCode($profile_id: Int!, $channel: String!, $address: String!) {
      verification_send_code(
        profile_id: $profile_id
        channel: $channel
        address: $address
      ) {
        __typename
        verification_code_id
      }
    }
    """

  public let operationName: String = "VerificationSendCode"

  public var profile_id: Int
  public var channel: String
  public var address: String

  public init(profile_id: Int, channel: String, address: String) {
    self.profile_id = profile_id
    self.channel = channel
    self.address = address
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "channel": channel, "address": address]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("verification_send_code", arguments: ["profile_id": GraphQLVariable("profile_id"), "channel": GraphQLVariable("channel"), "address": GraphQLVariable("address")], type: .object(VerificationSendCode.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(verificationSendCode: VerificationSendCode? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "verification_send_code": verificationSendCode.flatMap { (value: VerificationSendCode) -> ResultMap in value.resultMap }])
    }

    public var verificationSendCode: VerificationSendCode? {
      get {
        return (resultMap["verification_send_code"] as? ResultMap).flatMap { VerificationSendCode(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "verification_send_code")
      }
    }

    public struct VerificationSendCode: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["VerificationSendCodeOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("verification_code_id", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(verificationCodeId: String) {
        self.init(unsafeResultMap: ["__typename": "VerificationSendCodeOutput", "verification_code_id": verificationCodeId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var verificationCodeId: String {
        get {
          return resultMap["verification_code_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "verification_code_id")
        }
      }
    }
  }
}
