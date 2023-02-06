// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class KycAddDocumentMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation KycAddDocument($profile_id: Int!, $uploaded_file_id: Int!, $type: String!, $side: String!) {
      kyc_add_document(
        profile_id: $profile_id
        uploaded_file_id: $uploaded_file_id
        type: $type
        side: $side
      ) {
        __typename
        ok
      }
    }
    """

  public let operationName: String = "KycAddDocument"

  public var profile_id: Int
  public var uploaded_file_id: Int
  public var type: String
  public var side: String

  public init(profile_id: Int, uploaded_file_id: Int, type: String, side: String) {
    self.profile_id = profile_id
    self.uploaded_file_id = uploaded_file_id
    self.type = type
    self.side = side
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "uploaded_file_id": uploaded_file_id, "type": type, "side": side]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("kyc_add_document", arguments: ["profile_id": GraphQLVariable("profile_id"), "uploaded_file_id": GraphQLVariable("uploaded_file_id"), "type": GraphQLVariable("type"), "side": GraphQLVariable("side")], type: .object(KycAddDocument.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(kycAddDocument: KycAddDocument? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "kyc_add_document": kycAddDocument.flatMap { (value: KycAddDocument) -> ResultMap in value.resultMap }])
    }

    public var kycAddDocument: KycAddDocument? {
      get {
        return (resultMap["kyc_add_document"] as? ResultMap).flatMap { KycAddDocument(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "kyc_add_document")
      }
    }

    public struct KycAddDocument: GraphQLSelectionSet {
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
