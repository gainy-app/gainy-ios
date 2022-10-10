// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetPaymentMethodsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetPaymentMethods($profile_id: Int!) {
      app_payment_methods(
        where: {profile_id: {_eq: $profile_id}}
        order_by: [{set_active_at: desc_nulls_last}, {created_at: desc}]
      ) {
        __typename
        id
        name
      }
    }
    """

  public let operationName: String = "GetPaymentMethods"

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
        GraphQLField("app_payment_methods", arguments: ["where": ["profile_id": ["_eq": GraphQLVariable("profile_id")]], "order_by": [["set_active_at": "desc_nulls_last"], ["created_at": "desc"]]], type: .nonNull(.list(.nonNull(.object(AppPaymentMethod.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appPaymentMethods: [AppPaymentMethod]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_payment_methods": appPaymentMethods.map { (value: AppPaymentMethod) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.payment_methods"
    public var appPaymentMethods: [AppPaymentMethod] {
      get {
        return (resultMap["app_payment_methods"] as! [ResultMap]).map { (value: ResultMap) -> AppPaymentMethod in AppPaymentMethod(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AppPaymentMethod) -> ResultMap in value.resultMap }, forKey: "app_payment_methods")
      }
    }

    public struct AppPaymentMethod: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_payment_methods"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String) {
        self.init(unsafeResultMap: ["__typename": "app_payment_methods", "id": id, "name": name])
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

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}
