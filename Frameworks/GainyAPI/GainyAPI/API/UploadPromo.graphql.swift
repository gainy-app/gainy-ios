// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class UploadPromoMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UploadPromo($profile_id: Int!, $promocode: String!, $tariff: String!) {
      apply_promocode(profile_id: $profile_id, promocode: $promocode, tariff: $tariff) {
        __typename
        subscription_end_date
      }
    }
    """

  public let operationName: String = "UploadPromo"

  public var profile_id: Int
  public var promocode: String
  public var tariff: String

  public init(profile_id: Int, promocode: String, tariff: String) {
    self.profile_id = profile_id
    self.promocode = promocode
    self.tariff = tariff
  }

  public var variables: GraphQLMap? {
    return ["profile_id": profile_id, "promocode": promocode, "tariff": tariff]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("apply_promocode", arguments: ["profile_id": GraphQLVariable("profile_id"), "promocode": GraphQLVariable("promocode"), "tariff": GraphQLVariable("tariff")], type: .object(ApplyPromocode.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(applyPromocode: ApplyPromocode? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "apply_promocode": applyPromocode.flatMap { (value: ApplyPromocode) -> ResultMap in value.resultMap }])
    }

    public var applyPromocode: ApplyPromocode? {
      get {
        return (resultMap["apply_promocode"] as? ResultMap).flatMap { ApplyPromocode(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "apply_promocode")
      }
    }

    public struct ApplyPromocode: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UpdatePurchasesOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("subscription_end_date", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(subscriptionEndDate: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UpdatePurchasesOutput", "subscription_end_date": subscriptionEndDate])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var subscriptionEndDate: String? {
        get {
          return resultMap["subscription_end_date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "subscription_end_date")
        }
      }
    }
  }
}
