// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetKycFormQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetKycForm($profile_id: Int!) {
      app_kyc_form_by_pk(profile_id: $profile_id) {
        __typename
        address_city
        address_country
        address_postal_code
        address_province
        address_street1
        address_street2
        birthdate
        citizenship
        country
        disclosures_drivewealth_customer_agreement
        disclosures_drivewealth_data_sharing
        disclosures_drivewealth_ira_agreement
        disclosures_drivewealth_market_data_agreement
        disclosures_drivewealth_privacy_policy
        disclosures_drivewealth_terms_of_use
        disclosures_extended_hours_agreement
        disclosures_rule14b
        disclosures_signed_by
        email_address
        employment_affiliated_with_a_broker
        employment_company_name
        employment_is_director_of_a_public_company
        employment_position
        employment_status
        employment_type
        first_name
        gender
        investor_profile_annual_income
        investor_profile_experience
        investor_profile_net_worth_liquid
        investor_profile_net_worth_total
        investor_profile_objectives
        investor_profile_risk_tolerance
        tax_treaty_with_us
        tax_id_value
        tax_id_type
        profile_id
        politically_exposed_names
        phone_number
        marital_status
        last_name
        language
        is_us_tax_payer
        irs_backup_withholdings_notified
      }
    }
    """

  public let operationName: String = "GetKycForm"

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
        GraphQLField("app_kyc_form_by_pk", arguments: ["profile_id": GraphQLVariable("profile_id")], type: .object(AppKycFormByPk.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(appKycFormByPk: AppKycFormByPk? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "app_kyc_form_by_pk": appKycFormByPk.flatMap { (value: AppKycFormByPk) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "app.kyc_form" using primary key columns
    public var appKycFormByPk: AppKycFormByPk? {
      get {
        return (resultMap["app_kyc_form_by_pk"] as? ResultMap).flatMap { AppKycFormByPk(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "app_kyc_form_by_pk")
      }
    }

    public struct AppKycFormByPk: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["app_kyc_form"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("address_city", type: .scalar(String.self)),
          GraphQLField("address_country", type: .scalar(String.self)),
          GraphQLField("address_postal_code", type: .scalar(String.self)),
          GraphQLField("address_province", type: .scalar(String.self)),
          GraphQLField("address_street1", type: .scalar(String.self)),
          GraphQLField("address_street2", type: .scalar(String.self)),
          GraphQLField("birthdate", type: .scalar(date.self)),
          GraphQLField("citizenship", type: .scalar(String.self)),
          GraphQLField("country", type: .scalar(String.self)),
          GraphQLField("disclosures_drivewealth_customer_agreement", type: .scalar(Bool.self)),
          GraphQLField("disclosures_drivewealth_data_sharing", type: .scalar(Bool.self)),
          GraphQLField("disclosures_drivewealth_ira_agreement", type: .scalar(Bool.self)),
          GraphQLField("disclosures_drivewealth_market_data_agreement", type: .scalar(Bool.self)),
          GraphQLField("disclosures_drivewealth_privacy_policy", type: .scalar(Bool.self)),
          GraphQLField("disclosures_drivewealth_terms_of_use", type: .scalar(Bool.self)),
          GraphQLField("disclosures_extended_hours_agreement", type: .scalar(Bool.self)),
          GraphQLField("disclosures_rule14b", type: .scalar(Bool.self)),
          GraphQLField("disclosures_signed_by", type: .scalar(String.self)),
          GraphQLField("email_address", type: .scalar(String.self)),
          GraphQLField("employment_affiliated_with_a_broker", type: .scalar(Bool.self)),
          GraphQLField("employment_company_name", type: .scalar(String.self)),
          GraphQLField("employment_is_director_of_a_public_company", type: .scalar(String.self)),
          GraphQLField("employment_position", type: .scalar(String.self)),
          GraphQLField("employment_status", type: .scalar(String.self)),
          GraphQLField("employment_type", type: .scalar(String.self)),
          GraphQLField("first_name", type: .scalar(String.self)),
          GraphQLField("gender", type: .scalar(String.self)),
          GraphQLField("investor_profile_annual_income", type: .scalar(bigint.self)),
          GraphQLField("investor_profile_experience", type: .scalar(String.self)),
          GraphQLField("investor_profile_net_worth_liquid", type: .scalar(bigint.self)),
          GraphQLField("investor_profile_net_worth_total", type: .scalar(bigint.self)),
          GraphQLField("investor_profile_objectives", type: .scalar(String.self)),
          GraphQLField("investor_profile_risk_tolerance", type: .scalar(String.self)),
          GraphQLField("tax_treaty_with_us", type: .scalar(Bool.self)),
          GraphQLField("tax_id_value", type: .scalar(String.self)),
          GraphQLField("tax_id_type", type: .scalar(String.self)),
          GraphQLField("profile_id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("politically_exposed_names", type: .scalar(String.self)),
          GraphQLField("phone_number", type: .scalar(String.self)),
          GraphQLField("marital_status", type: .scalar(String.self)),
          GraphQLField("last_name", type: .scalar(String.self)),
          GraphQLField("language", type: .scalar(String.self)),
          GraphQLField("is_us_tax_payer", type: .scalar(Bool.self)),
          GraphQLField("irs_backup_withholdings_notified", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(addressCity: String? = nil, addressCountry: String? = nil, addressPostalCode: String? = nil, addressProvince: String? = nil, addressStreet1: String? = nil, addressStreet2: String? = nil, birthdate: date? = nil, citizenship: String? = nil, country: String? = nil, disclosuresDrivewealthCustomerAgreement: Bool? = nil, disclosuresDrivewealthDataSharing: Bool? = nil, disclosuresDrivewealthIraAgreement: Bool? = nil, disclosuresDrivewealthMarketDataAgreement: Bool? = nil, disclosuresDrivewealthPrivacyPolicy: Bool? = nil, disclosuresDrivewealthTermsOfUse: Bool? = nil, disclosuresExtendedHoursAgreement: Bool? = nil, disclosuresRule14b: Bool? = nil, disclosuresSignedBy: String? = nil, emailAddress: String? = nil, employmentAffiliatedWithABroker: Bool? = nil, employmentCompanyName: String? = nil, employmentIsDirectorOfAPublicCompany: String? = nil, employmentPosition: String? = nil, employmentStatus: String? = nil, employmentType: String? = nil, firstName: String? = nil, gender: String? = nil, investorProfileAnnualIncome: bigint? = nil, investorProfileExperience: String? = nil, investorProfileNetWorthLiquid: bigint? = nil, investorProfileNetWorthTotal: bigint? = nil, investorProfileObjectives: String? = nil, investorProfileRiskTolerance: String? = nil, taxTreatyWithUs: Bool? = nil, taxIdValue: String? = nil, taxIdType: String? = nil, profileId: Int, politicallyExposedNames: String? = nil, phoneNumber: String? = nil, maritalStatus: String? = nil, lastName: String? = nil, language: String? = nil, isUsTaxPayer: Bool? = nil, irsBackupWithholdingsNotified: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "app_kyc_form", "address_city": addressCity, "address_country": addressCountry, "address_postal_code": addressPostalCode, "address_province": addressProvince, "address_street1": addressStreet1, "address_street2": addressStreet2, "birthdate": birthdate, "citizenship": citizenship, "country": country, "disclosures_drivewealth_customer_agreement": disclosuresDrivewealthCustomerAgreement, "disclosures_drivewealth_data_sharing": disclosuresDrivewealthDataSharing, "disclosures_drivewealth_ira_agreement": disclosuresDrivewealthIraAgreement, "disclosures_drivewealth_market_data_agreement": disclosuresDrivewealthMarketDataAgreement, "disclosures_drivewealth_privacy_policy": disclosuresDrivewealthPrivacyPolicy, "disclosures_drivewealth_terms_of_use": disclosuresDrivewealthTermsOfUse, "disclosures_extended_hours_agreement": disclosuresExtendedHoursAgreement, "disclosures_rule14b": disclosuresRule14b, "disclosures_signed_by": disclosuresSignedBy, "email_address": emailAddress, "employment_affiliated_with_a_broker": employmentAffiliatedWithABroker, "employment_company_name": employmentCompanyName, "employment_is_director_of_a_public_company": employmentIsDirectorOfAPublicCompany, "employment_position": employmentPosition, "employment_status": employmentStatus, "employment_type": employmentType, "first_name": firstName, "gender": gender, "investor_profile_annual_income": investorProfileAnnualIncome, "investor_profile_experience": investorProfileExperience, "investor_profile_net_worth_liquid": investorProfileNetWorthLiquid, "investor_profile_net_worth_total": investorProfileNetWorthTotal, "investor_profile_objectives": investorProfileObjectives, "investor_profile_risk_tolerance": investorProfileRiskTolerance, "tax_treaty_with_us": taxTreatyWithUs, "tax_id_value": taxIdValue, "tax_id_type": taxIdType, "profile_id": profileId, "politically_exposed_names": politicallyExposedNames, "phone_number": phoneNumber, "marital_status": maritalStatus, "last_name": lastName, "language": language, "is_us_tax_payer": isUsTaxPayer, "irs_backup_withholdings_notified": irsBackupWithholdingsNotified])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var addressCity: String? {
        get {
          return resultMap["address_city"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address_city")
        }
      }

      public var addressCountry: String? {
        get {
          return resultMap["address_country"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address_country")
        }
      }

      public var addressPostalCode: String? {
        get {
          return resultMap["address_postal_code"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address_postal_code")
        }
      }

      public var addressProvince: String? {
        get {
          return resultMap["address_province"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address_province")
        }
      }

      public var addressStreet1: String? {
        get {
          return resultMap["address_street1"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address_street1")
        }
      }

      public var addressStreet2: String? {
        get {
          return resultMap["address_street2"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "address_street2")
        }
      }

      public var birthdate: date? {
        get {
          return resultMap["birthdate"] as? date
        }
        set {
          resultMap.updateValue(newValue, forKey: "birthdate")
        }
      }

      public var citizenship: String? {
        get {
          return resultMap["citizenship"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "citizenship")
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

      public var disclosuresDrivewealthCustomerAgreement: Bool? {
        get {
          return resultMap["disclosures_drivewealth_customer_agreement"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_drivewealth_customer_agreement")
        }
      }

      public var disclosuresDrivewealthDataSharing: Bool? {
        get {
          return resultMap["disclosures_drivewealth_data_sharing"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_drivewealth_data_sharing")
        }
      }

      public var disclosuresDrivewealthIraAgreement: Bool? {
        get {
          return resultMap["disclosures_drivewealth_ira_agreement"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_drivewealth_ira_agreement")
        }
      }

      public var disclosuresDrivewealthMarketDataAgreement: Bool? {
        get {
          return resultMap["disclosures_drivewealth_market_data_agreement"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_drivewealth_market_data_agreement")
        }
      }

      public var disclosuresDrivewealthPrivacyPolicy: Bool? {
        get {
          return resultMap["disclosures_drivewealth_privacy_policy"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_drivewealth_privacy_policy")
        }
      }

      public var disclosuresDrivewealthTermsOfUse: Bool? {
        get {
          return resultMap["disclosures_drivewealth_terms_of_use"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_drivewealth_terms_of_use")
        }
      }

      public var disclosuresExtendedHoursAgreement: Bool? {
        get {
          return resultMap["disclosures_extended_hours_agreement"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_extended_hours_agreement")
        }
      }

      public var disclosuresRule14b: Bool? {
        get {
          return resultMap["disclosures_rule14b"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_rule14b")
        }
      }

      public var disclosuresSignedBy: String? {
        get {
          return resultMap["disclosures_signed_by"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "disclosures_signed_by")
        }
      }

      public var emailAddress: String? {
        get {
          return resultMap["email_address"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email_address")
        }
      }

      public var employmentAffiliatedWithABroker: Bool? {
        get {
          return resultMap["employment_affiliated_with_a_broker"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "employment_affiliated_with_a_broker")
        }
      }

      public var employmentCompanyName: String? {
        get {
          return resultMap["employment_company_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "employment_company_name")
        }
      }

      public var employmentIsDirectorOfAPublicCompany: String? {
        get {
          return resultMap["employment_is_director_of_a_public_company"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "employment_is_director_of_a_public_company")
        }
      }

      public var employmentPosition: String? {
        get {
          return resultMap["employment_position"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "employment_position")
        }
      }

      public var employmentStatus: String? {
        get {
          return resultMap["employment_status"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "employment_status")
        }
      }

      public var employmentType: String? {
        get {
          return resultMap["employment_type"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "employment_type")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["first_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "first_name")
        }
      }

      public var gender: String? {
        get {
          return resultMap["gender"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "gender")
        }
      }

      public var investorProfileAnnualIncome: bigint? {
        get {
          return resultMap["investor_profile_annual_income"] as? bigint
        }
        set {
          resultMap.updateValue(newValue, forKey: "investor_profile_annual_income")
        }
      }

      public var investorProfileExperience: String? {
        get {
          return resultMap["investor_profile_experience"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "investor_profile_experience")
        }
      }

      public var investorProfileNetWorthLiquid: bigint? {
        get {
          return resultMap["investor_profile_net_worth_liquid"] as? bigint
        }
        set {
          resultMap.updateValue(newValue, forKey: "investor_profile_net_worth_liquid")
        }
      }

      public var investorProfileNetWorthTotal: bigint? {
        get {
          return resultMap["investor_profile_net_worth_total"] as? bigint
        }
        set {
          resultMap.updateValue(newValue, forKey: "investor_profile_net_worth_total")
        }
      }

      public var investorProfileObjectives: String? {
        get {
          return resultMap["investor_profile_objectives"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "investor_profile_objectives")
        }
      }

      public var investorProfileRiskTolerance: String? {
        get {
          return resultMap["investor_profile_risk_tolerance"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "investor_profile_risk_tolerance")
        }
      }

      public var taxTreatyWithUs: Bool? {
        get {
          return resultMap["tax_treaty_with_us"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "tax_treaty_with_us")
        }
      }

      public var taxIdValue: String? {
        get {
          return resultMap["tax_id_value"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "tax_id_value")
        }
      }

      public var taxIdType: String? {
        get {
          return resultMap["tax_id_type"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "tax_id_type")
        }
      }

      public var profileId: Int {
        get {
          return resultMap["profile_id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "profile_id")
        }
      }

      public var politicallyExposedNames: String? {
        get {
          return resultMap["politically_exposed_names"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "politically_exposed_names")
        }
      }

      public var phoneNumber: String? {
        get {
          return resultMap["phone_number"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "phone_number")
        }
      }

      public var maritalStatus: String? {
        get {
          return resultMap["marital_status"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "marital_status")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["last_name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "last_name")
        }
      }

      public var language: String? {
        get {
          return resultMap["language"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "language")
        }
      }

      public var isUsTaxPayer: Bool? {
        get {
          return resultMap["is_us_tax_payer"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "is_us_tax_payer")
        }
      }

      public var irsBackupWithholdingsNotified: Bool? {
        get {
          return resultMap["irs_backup_withholdings_notified"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "irs_backup_withholdings_notified")
        }
      }
    }
  }
}
