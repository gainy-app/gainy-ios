// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class KycValidateAddressQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query KycValidateAddress($street1: String!, $street2: String, $city: String!, $province: String!, $postal_code: String!, $country: String) {
      kyc_validate_address(
        street1: $street1
        street2: $street2
        city: $city
        province: $province
        postal_code: $postal_code
        country: $country
      ) {
        __typename
        ok
        suggested {
          __typename
          street1
          street2
          city
          province
          postal_code
          country
        }
      }
    }
    """

  public let operationName: String = "KycValidateAddress"

  public var street1: String
  public var street2: String?
  public var city: String
  public var province: String
  public var postal_code: String
  public var country: String?

  public init(street1: String, street2: String? = nil, city: String, province: String, postal_code: String, country: String? = nil) {
    self.street1 = street1
    self.street2 = street2
    self.city = city
    self.province = province
    self.postal_code = postal_code
    self.country = country
  }

  public var variables: GraphQLMap? {
    return ["street1": street1, "street2": street2, "city": city, "province": province, "postal_code": postal_code, "country": country]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("kyc_validate_address", arguments: ["street1": GraphQLVariable("street1"), "street2": GraphQLVariable("street2"), "city": GraphQLVariable("city"), "province": GraphQLVariable("province"), "postal_code": GraphQLVariable("postal_code"), "country": GraphQLVariable("country")], type: .object(KycValidateAddress.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(kycValidateAddress: KycValidateAddress? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "kyc_validate_address": kycValidateAddress.flatMap { (value: KycValidateAddress) -> ResultMap in value.resultMap }])
    }

    public var kycValidateAddress: KycValidateAddress? {
      get {
        return (resultMap["kyc_validate_address"] as? ResultMap).flatMap { KycValidateAddress(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "kyc_validate_address")
      }
    }

    public struct KycValidateAddress: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["KycValidateAddressOutput"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("ok", type: .scalar(Bool.self)),
          GraphQLField("suggested", type: .object(Suggested.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(ok: Bool? = nil, suggested: Suggested? = nil) {
        self.init(unsafeResultMap: ["__typename": "KycValidateAddressOutput", "ok": ok, "suggested": suggested.flatMap { (value: Suggested) -> ResultMap in value.resultMap }])
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

      public var suggested: Suggested? {
        get {
          return (resultMap["suggested"] as? ResultMap).flatMap { Suggested(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "suggested")
        }
      }

      public struct Suggested: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["SuggestedAddressOutput"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("street1", type: .scalar(String.self)),
            GraphQLField("street2", type: .scalar(String.self)),
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

        public init(street1: String? = nil, street2: String? = nil, city: String? = nil, province: String? = nil, postalCode: String? = nil, country: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "SuggestedAddressOutput", "street1": street1, "street2": street2, "city": city, "province": province, "postal_code": postalCode, "country": country])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var street2: String? {
          get {
            return resultMap["street2"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "street2")
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
}
