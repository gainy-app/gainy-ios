// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class KycGetStatusQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query KycGetStatus($profile_id: Int!) {
      kyc_get_status(profile_id: $profile_id) {
        __typename
        message
        status
        updated_at
      }
    }
    """

  public let operationName: String = "KycGetStatus"

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
        GraphQLField("kyc_get_status", arguments: ["profile_id": GraphQLVariable("profile_id")], type: .object(KycGetStatus.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(kycGetStatus: KycGetStatus? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "kyc_get_status": kycGetStatus.flatMap { (value: KycGetStatus) -> ResultMap in value.resultMap }])
    }

    public var kycGetStatus: KycGetStatus? {
      get {
        return (resultMap["kyc_get_status"] as? ResultMap).flatMap { KycGetStatus(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "kyc_get_status")
      }
    }

    public struct KycGetStatus: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["KycStatus"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(String.self)),
          GraphQLField("updated_at", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(message: String? = nil, status: String? = nil, updatedAt: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "KycStatus", "message": message, "status": status, "updated_at": updatedAt])
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

      public var updatedAt: String? {
        get {
          return resultMap["updated_at"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "updated_at")
        }
      }
    }
  }
}
