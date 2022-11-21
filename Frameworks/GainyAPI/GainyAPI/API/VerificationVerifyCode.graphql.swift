// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class VerificationVerifyCodeMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation VerificationVerifyCode($verification_code_id: String!, $user_input: String!) {
      verification_verify_code(
        verification_code_id: $verification_code_id
        user_input: $user_input
      ) {
        __typename
        ok
      }
    }
    """

  public let operationName: String = "VerificationVerifyCode"

  public var verification_code_id: String
  public var user_input: String

  public init(verification_code_id: String, user_input: String) {
    self.verification_code_id = verification_code_id
    self.user_input = user_input
  }

  public var variables: GraphQLMap? {
    return ["verification_code_id": verification_code_id, "user_input": user_input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("verification_verify_code", arguments: ["verification_code_id": GraphQLVariable("verification_code_id"), "user_input": GraphQLVariable("user_input")], type: .object(VerificationVerifyCode.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(verificationVerifyCode: VerificationVerifyCode? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "verification_verify_code": verificationVerifyCode.flatMap { (value: VerificationVerifyCode) -> ResultMap in value.resultMap }])
    }

    public var verificationVerifyCode: VerificationVerifyCode? {
      get {
        return (resultMap["verification_verify_code"] as? ResultMap).flatMap { VerificationVerifyCode(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "verification_verify_code")
      }
    }

    public struct VerificationVerifyCode: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["OkOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ok", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(ok: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "OkOutput", "ok": ok])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var ok: Bool? {
        get {
          return resultMap["ok"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "ok")
        }
      }
    }
  }
}
