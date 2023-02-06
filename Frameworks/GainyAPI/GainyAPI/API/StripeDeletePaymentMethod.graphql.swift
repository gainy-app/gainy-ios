// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DeletePaymentMethodMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation DeletePaymentMethod($payment_method_id: Int!) {
      delete_app_payment_methods_by_pk(id: $payment_method_id) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "DeletePaymentMethod"

  public var payment_method_id: Int

  public init(payment_method_id: Int) {
    self.payment_method_id = payment_method_id
  }

  public var variables: GraphQLMap? {
    return ["payment_method_id": payment_method_id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("delete_app_payment_methods_by_pk", arguments: ["id": GraphQLVariable("payment_method_id")], type: .object(DeleteAppPaymentMethodsByPk.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteAppPaymentMethodsByPk: DeleteAppPaymentMethodsByPk? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "delete_app_payment_methods_by_pk": deleteAppPaymentMethodsByPk.flatMap { (value: DeleteAppPaymentMethodsByPk) -> ResultMap in value.resultMap }])
    }

    /// delete single row from the table: "app.payment_methods"
    public var deleteAppPaymentMethodsByPk: DeleteAppPaymentMethodsByPk? {
      get {
        return (resultMap["delete_app_payment_methods_by_pk"] as? ResultMap).flatMap { DeleteAppPaymentMethodsByPk(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "delete_app_payment_methods_by_pk")
      }
    }

    public struct DeleteAppPaymentMethodsByPk: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_payment_methods"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int) {
        self.init(unsafeResultMap: ["__typename": "app_payment_methods", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}
