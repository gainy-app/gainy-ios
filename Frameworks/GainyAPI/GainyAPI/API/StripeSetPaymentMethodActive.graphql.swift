// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SetPaymentMethodActiveMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation SetPaymentMethodActive($payment_method_id: Int!) {
      update_app_payment_methods_by_pk(
        pk_columns: {id: $payment_method_id}
        _set: {set_active_at: now}
      ) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "SetPaymentMethodActive"

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
        GraphQLField("update_app_payment_methods_by_pk", arguments: ["pk_columns": ["id": GraphQLVariable("payment_method_id")], "_set": ["set_active_at": "now"]], type: .object(UpdateAppPaymentMethodsByPk.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateAppPaymentMethodsByPk: UpdateAppPaymentMethodsByPk? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "update_app_payment_methods_by_pk": updateAppPaymentMethodsByPk.flatMap { (value: UpdateAppPaymentMethodsByPk) -> ResultMap in value.resultMap }])
    }

    /// update single row of the table: "app.payment_methods"
    public var updateAppPaymentMethodsByPk: UpdateAppPaymentMethodsByPk? {
      get {
        return (resultMap["update_app_payment_methods_by_pk"] as? ResultMap).flatMap { UpdateAppPaymentMethodsByPk(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "update_app_payment_methods_by_pk")
      }
    }

    public struct UpdateAppPaymentMethodsByPk: GraphQLSelectionSet {
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
