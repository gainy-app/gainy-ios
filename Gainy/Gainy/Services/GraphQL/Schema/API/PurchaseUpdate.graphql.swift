// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PurchaseUpdateMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation PurchaseUpdate($profileId: Int!) {
      update_purchases(profile_id: $profileId) {
        __typename
        subscription_end_date
      }
    }
    """

  public let operationName: String = "PurchaseUpdate"

  public var profileId: Int

  public init(profileId: Int) {
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("update_purchases", arguments: ["profile_id": GraphQLVariable("profileId")], type: .object(UpdatePurchase.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updatePurchases: UpdatePurchase? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "update_purchases": updatePurchases.flatMap { (value: UpdatePurchase) -> ResultMap in value.resultMap }])
    }

    /// update_purchases
    public var updatePurchases: UpdatePurchase? {
      get {
        return (resultMap["update_purchases"] as? ResultMap).flatMap { UpdatePurchase(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "update_purchases")
      }
    }

    public struct UpdatePurchase: GraphQLSelectionSet {
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
