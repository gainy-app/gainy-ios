// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ValidatePromoCodeQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ValidatePromoCode($code: String!) {
      get_promocode(code: $code) {
        __typename
        id
        name
        description
        config
      }
    }
    """

  public let operationName: String = "ValidatePromoCode"

  public var code: String

  public init(code: String) {
    self.code = code
  }

  public var variables: GraphQLMap? {
    return ["code": code]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("get_promocode", arguments: ["code": GraphQLVariable("code")], type: .object(GetPromocode.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPromocode: GetPromocode? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "get_promocode": getPromocode.flatMap { (value: GetPromocode) -> ResultMap in value.resultMap }])
    }

    public var getPromocode: GetPromocode? {
      get {
        return (resultMap["get_promocode"] as? ResultMap).flatMap { GetPromocode(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "get_promocode")
      }
    }

    public struct GetPromocode: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Promocode"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("config", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String? = nil, description: String? = nil, config: String) {
        self.init(unsafeResultMap: ["__typename": "Promocode", "id": id, "name": name, "description": description, "config": config])
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

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var config: String {
        get {
          return resultMap["config"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "config")
        }
      }
    }
  }
}
