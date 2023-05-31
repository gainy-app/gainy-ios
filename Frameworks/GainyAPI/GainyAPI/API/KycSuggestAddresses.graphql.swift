// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class KycSuggestAddressesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query KycSuggestAddresses($query: String!, $limit: Int!) {
      kyc_suggest_addresses(query: $query, limit: $limit) {
        __typename
        formatted_address
        street1
        city
        province
        postal_code
        country
      }
    }
    """

  public let operationName: String = "KycSuggestAddresses"

  public var query: String
  public var limit: Int

  public init(query: String, limit: Int) {
    self.query = query
    self.limit = limit
  }

  public var variables: GraphQLMap? {
    return ["query": query, "limit": limit]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("kyc_suggest_addresses", arguments: ["query": GraphQLVariable("query"), "limit": GraphQLVariable("limit")], type: .list(.object(KycSuggestAddress.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(kycSuggestAddresses: [KycSuggestAddress?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "kyc_suggest_addresses": kycSuggestAddresses.flatMap { (value: [KycSuggestAddress?]) -> [ResultMap?] in value.map { (value: KycSuggestAddress?) -> ResultMap? in value.flatMap { (value: KycSuggestAddress) -> ResultMap in value.resultMap } } }])
    }

    public var kycSuggestAddresses: [KycSuggestAddress?]? {
      get {
        return (resultMap["kyc_suggest_addresses"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [KycSuggestAddress?] in value.map { (value: ResultMap?) -> KycSuggestAddress? in value.flatMap { (value: ResultMap) -> KycSuggestAddress in KycSuggestAddress(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [KycSuggestAddress?]) -> [ResultMap?] in value.map { (value: KycSuggestAddress?) -> ResultMap? in value.flatMap { (value: KycSuggestAddress) -> ResultMap in value.resultMap } } }, forKey: "kyc_suggest_addresses")
      }
    }

    public struct KycSuggestAddress: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SuggestedAddressOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("formatted_address", type: .scalar(String.self)),
          GraphQLField("street1", type: .scalar(String.self)),
          GraphQLField("city", type: .scalar(String.self)),
          GraphQLField("province", type: .scalar(String.self)),
          GraphQLField("postal_code", type: .scalar(String.self)),
          GraphQLField("country", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(formattedAddress: String? = nil, street1: String? = nil, city: String? = nil, province: String? = nil, postalCode: String? = nil, country: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "SuggestedAddressOutput", "formatted_address": formattedAddress, "street1": street1, "city": city, "province": province, "postal_code": postalCode, "country": country])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var formattedAddress: String? {
        get {
          return resultMap["formatted_address"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "formatted_address")
        }
      }

      public var street1: String? {
        get {
          return resultMap["street1"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "street1")
        }
      }

      public var city: String? {
        get {
          return resultMap["city"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "city")
        }
      }

      public var province: String? {
        get {
          return resultMap["province"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "province")
        }
      }

      public var postalCode: String? {
        get {
          return resultMap["postal_code"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "postal_code")
        }
      }

      public var country: String? {
        get {
          return resultMap["country"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "country")
        }
      }
    }
  }
}
