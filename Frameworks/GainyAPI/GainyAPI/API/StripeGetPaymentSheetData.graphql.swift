// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class StripeGetPaymentSheetDataQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query StripeGetPaymentSheetData($profile_id: Int!) {
      stripe_get_payment_sheet_data(profile_id: $profile_id) {
        __typename
        customer_id
        setup_intent_client_secret
        ephemeral_key
        publishable_key
      }
    }
    """

  public let operationName: String = "StripeGetPaymentSheetData"

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
        GraphQLField("stripe_get_payment_sheet_data", arguments: ["profile_id": GraphQLVariable("profile_id")], type: .object(StripeGetPaymentSheetDatum.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(stripeGetPaymentSheetData: StripeGetPaymentSheetDatum? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "stripe_get_payment_sheet_data": stripeGetPaymentSheetData.flatMap { (value: StripeGetPaymentSheetDatum) -> ResultMap in value.resultMap }])
    }

    public var stripeGetPaymentSheetData: StripeGetPaymentSheetDatum? {
      get {
        return (resultMap["stripe_get_payment_sheet_data"] as? ResultMap).flatMap { StripeGetPaymentSheetDatum(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "stripe_get_payment_sheet_data")
      }
    }

    public struct StripeGetPaymentSheetDatum: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["StripeGetPaymentSheetDataOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("customer_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("setup_intent_client_secret", type: .nonNull(.scalar(String.self))),
          GraphQLField("ephemeral_key", type: .nonNull(.scalar(String.self))),
          GraphQLField("publishable_key", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(customerId: String, setupIntentClientSecret: String, ephemeralKey: String, publishableKey: String) {
        self.init(unsafeResultMap: ["__typename": "StripeGetPaymentSheetDataOutput", "customer_id": customerId, "setup_intent_client_secret": setupIntentClientSecret, "ephemeral_key": ephemeralKey, "publishable_key": publishableKey])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var customerId: String {
        get {
          return resultMap["customer_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "customer_id")
        }
      }

      public var setupIntentClientSecret: String {
        get {
          return resultMap["setup_intent_client_secret"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "setup_intent_client_secret")
        }
      }

      public var ephemeralKey: String {
        get {
          return resultMap["ephemeral_key"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "ephemeral_key")
        }
      }

      public var publishableKey: String {
        get {
          return resultMap["publishable_key"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "publishable_key")
        }
      }
    }
  }
}
