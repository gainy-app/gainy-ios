// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class KycGetFormConfigQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query KycGetFormConfig($profile_id: Int!) {
      kyc_get_form_config(profile_id: $profile_id) {
        __typename
        first_name {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        last_name {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        country {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        email_address {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        language {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        employment_status {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        employment_type {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        employment_position {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        investor_profile_experience {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        investor_profile_risk_tolerance {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        investor_profile_objectives {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        investor_profile_annual_income {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        investor_profile_net_worth_total {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        investor_profile_net_worth_liquid {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        disclosures_drivewealth_terms_of_use {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        disclosures_drivewealth_customer_agreement {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        disclosures_drivewealth_market_data_agreement {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        disclosures_rule14b {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        disclosures_drivewealth_privacy_policy {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        disclosures_signed_by {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        tax_id_value {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        tax_id_type {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        citizenship {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        gender {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        marital_status {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        birthdate {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        address_street1 {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        address_city {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        address_postal_code {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
        address_country {
          __typename
          choices {
            __typename
            value
            name
          }
          placeholder
          required
        }
      }
    }
    """

  public let operationName: String = "KycGetFormConfig"

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
        GraphQLField("kyc_get_form_config", arguments: ["profile_id": GraphQLVariable("profile_id")], type: .object(KycGetFormConfig.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(kycGetFormConfig: KycGetFormConfig? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "kyc_get_form_config": kycGetFormConfig.flatMap { (value: KycGetFormConfig) -> ResultMap in value.resultMap }])
    }

    public var kycGetFormConfig: KycGetFormConfig? {
      get {
        return (resultMap["kyc_get_form_config"] as? ResultMap).flatMap { KycGetFormConfig(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "kyc_get_form_config")
      }
    }

    public struct KycGetFormConfig: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["KycFormConfig"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("first_name", type: .object(FirstName.selections)),
          GraphQLField("last_name", type: .object(LastName.selections)),
          GraphQLField("country", type: .object(Country.selections)),
          GraphQLField("email_address", type: .object(EmailAddress.selections)),
          GraphQLField("language", type: .object(Language.selections)),
          GraphQLField("employment_status", type: .object(EmploymentStatus.selections)),
          GraphQLField("employment_type", type: .object(EmploymentType.selections)),
          GraphQLField("employment_position", type: .object(EmploymentPosition.selections)),
          GraphQLField("investor_profile_experience", type: .object(InvestorProfileExperience.selections)),
          GraphQLField("investor_profile_risk_tolerance", type: .object(InvestorProfileRiskTolerance.selections)),
          GraphQLField("investor_profile_objectives", type: .object(InvestorProfileObjective.selections)),
          GraphQLField("investor_profile_annual_income", type: .object(InvestorProfileAnnualIncome.selections)),
          GraphQLField("investor_profile_net_worth_total", type: .object(InvestorProfileNetWorthTotal.selections)),
          GraphQLField("investor_profile_net_worth_liquid", type: .object(InvestorProfileNetWorthLiquid.selections)),
          GraphQLField("disclosures_drivewealth_terms_of_use", type: .object(DisclosuresDrivewealthTermsOfUse.selections)),
          GraphQLField("disclosures_drivewealth_customer_agreement", type: .object(DisclosuresDrivewealthCustomerAgreement.selections)),
          GraphQLField("disclosures_drivewealth_market_data_agreement", type: .object(DisclosuresDrivewealthMarketDataAgreement.selections)),
          GraphQLField("disclosures_rule14b", type: .object(DisclosuresRule14b.selections)),
          GraphQLField("disclosures_drivewealth_privacy_policy", type: .object(DisclosuresDrivewealthPrivacyPolicy.selections)),
          GraphQLField("disclosures_signed_by", type: .object(DisclosuresSignedBy.selections)),
          GraphQLField("tax_id_value", type: .object(TaxIdValue.selections)),
          GraphQLField("tax_id_type", type: .object(TaxIdType.selections)),
          GraphQLField("citizenship", type: .object(Citizenship.selections)),
          GraphQLField("gender", type: .object(Gender.selections)),
          GraphQLField("marital_status", type: .object(MaritalStatus.selections)),
          GraphQLField("birthdate", type: .object(Birthdate.selections)),
          GraphQLField("address_street1", type: .object(AddressStreet1.selections)),
          GraphQLField("address_city", type: .object(AddressCity.selections)),
          GraphQLField("address_postal_code", type: .object(AddressPostalCode.selections)),
          GraphQLField("address_country", type: .object(AddressCountry.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(firstName: FirstName? = nil, lastName: LastName? = nil, country: Country? = nil, emailAddress: EmailAddress? = nil, language: Language? = nil, employmentStatus: EmploymentStatus? = nil, employmentType: EmploymentType? = nil, employmentPosition: EmploymentPosition? = nil, investorProfileExperience: InvestorProfileExperience? = nil, investorProfileRiskTolerance: InvestorProfileRiskTolerance? = nil, investorProfileObjectives: InvestorProfileObjective? = nil, investorProfileAnnualIncome: InvestorProfileAnnualIncome? = nil, investorProfileNetWorthTotal: InvestorProfileNetWorthTotal? = nil, investorProfileNetWorthLiquid: InvestorProfileNetWorthLiquid? = nil, disclosuresDrivewealthTermsOfUse: DisclosuresDrivewealthTermsOfUse? = nil, disclosuresDrivewealthCustomerAgreement: DisclosuresDrivewealthCustomerAgreement? = nil, disclosuresDrivewealthMarketDataAgreement: DisclosuresDrivewealthMarketDataAgreement? = nil, disclosuresRule14b: DisclosuresRule14b? = nil, disclosuresDrivewealthPrivacyPolicy: DisclosuresDrivewealthPrivacyPolicy? = nil, disclosuresSignedBy: DisclosuresSignedBy? = nil, taxIdValue: TaxIdValue? = nil, taxIdType: TaxIdType? = nil, citizenship: Citizenship? = nil, gender: Gender? = nil, maritalStatus: MaritalStatus? = nil, birthdate: Birthdate? = nil, addressStreet1: AddressStreet1? = nil, addressCity: AddressCity? = nil, addressPostalCode: AddressPostalCode? = nil, addressCountry: AddressCountry? = nil) {
        self.init(unsafeResultMap: ["__typename": "KycFormConfig", "first_name": firstName.flatMap { (value: FirstName) -> ResultMap in value.resultMap }, "last_name": lastName.flatMap { (value: LastName) -> ResultMap in value.resultMap }, "country": country.flatMap { (value: Country) -> ResultMap in value.resultMap }, "email_address": emailAddress.flatMap { (value: EmailAddress) -> ResultMap in value.resultMap }, "language": language.flatMap { (value: Language) -> ResultMap in value.resultMap }, "employment_status": employmentStatus.flatMap { (value: EmploymentStatus) -> ResultMap in value.resultMap }, "employment_type": employmentType.flatMap { (value: EmploymentType) -> ResultMap in value.resultMap }, "employment_position": employmentPosition.flatMap { (value: EmploymentPosition) -> ResultMap in value.resultMap }, "investor_profile_experience": investorProfileExperience.flatMap { (value: InvestorProfileExperience) -> ResultMap in value.resultMap }, "investor_profile_risk_tolerance": investorProfileRiskTolerance.flatMap { (value: InvestorProfileRiskTolerance) -> ResultMap in value.resultMap }, "investor_profile_objectives": investorProfileObjectives.flatMap { (value: InvestorProfileObjective) -> ResultMap in value.resultMap }, "investor_profile_annual_income": investorProfileAnnualIncome.flatMap { (value: InvestorProfileAnnualIncome) -> ResultMap in value.resultMap }, "investor_profile_net_worth_total": investorProfileNetWorthTotal.flatMap { (value: InvestorProfileNetWorthTotal) -> ResultMap in value.resultMap }, "investor_profile_net_worth_liquid": investorProfileNetWorthLiquid.flatMap { (value: InvestorProfileNetWorthLiquid) -> ResultMap in value.resultMap }, "disclosures_drivewealth_terms_of_use": disclosuresDrivewealthTermsOfUse.flatMap { (value: DisclosuresDrivewealthTermsOfUse) -> ResultMap in value.resultMap }, "disclosures_drivewealth_customer_agreement": disclosuresDrivewealthCustomerAgreement.flatMap { (value: DisclosuresDrivewealthCustomerAgreement) -> ResultMap in value.resultMap }, "disclosures_drivewealth_market_data_agreement": disclosuresDrivewealthMarketDataAgreement.flatMap { (value: DisclosuresDrivewealthMarketDataAgreement) -> ResultMap in value.resultMap }, "disclosures_rule14b": disclosuresRule14b.flatMap { (value: DisclosuresRule14b) -> ResultMap in value.resultMap }, "disclosures_drivewealth_privacy_policy": disclosuresDrivewealthPrivacyPolicy.flatMap { (value: DisclosuresDrivewealthPrivacyPolicy) -> ResultMap in value.resultMap }, "disclosures_signed_by": disclosuresSignedBy.flatMap { (value: DisclosuresSignedBy) -> ResultMap in value.resultMap }, "tax_id_value": taxIdValue.flatMap { (value: TaxIdValue) -> ResultMap in value.resultMap }, "tax_id_type": taxIdType.flatMap { (value: TaxIdType) -> ResultMap in value.resultMap }, "citizenship": citizenship.flatMap { (value: Citizenship) -> ResultMap in value.resultMap }, "gender": gender.flatMap { (value: Gender) -> ResultMap in value.resultMap }, "marital_status": maritalStatus.flatMap { (value: MaritalStatus) -> ResultMap in value.resultMap }, "birthdate": birthdate.flatMap { (value: Birthdate) -> ResultMap in value.resultMap }, "address_street1": addressStreet1.flatMap { (value: AddressStreet1) -> ResultMap in value.resultMap }, "address_city": addressCity.flatMap { (value: AddressCity) -> ResultMap in value.resultMap }, "address_postal_code": addressPostalCode.flatMap { (value: AddressPostalCode) -> ResultMap in value.resultMap }, "address_country": addressCountry.flatMap { (value: AddressCountry) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var firstName: FirstName? {
        get {
          return (resultMap["first_name"] as? ResultMap).flatMap { FirstName(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "first_name")
        }
      }

      public var lastName: LastName? {
        get {
          return (resultMap["last_name"] as? ResultMap).flatMap { LastName(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "last_name")
        }
      }

      public var country: Country? {
        get {
          return (resultMap["country"] as? ResultMap).flatMap { Country(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "country")
        }
      }

      public var emailAddress: EmailAddress? {
        get {
          return (resultMap["email_address"] as? ResultMap).flatMap { EmailAddress(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "email_address")
        }
      }

      public var language: Language? {
        get {
          return (resultMap["language"] as? ResultMap).flatMap { Language(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "language")
        }
      }

      public var employmentStatus: EmploymentStatus? {
        get {
          return (resultMap["employment_status"] as? ResultMap).flatMap { EmploymentStatus(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "employment_status")
        }
      }

      public var employmentType: EmploymentType? {
        get {
          return (resultMap["employment_type"] as? ResultMap).flatMap { EmploymentType(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "employment_type")
        }
      }

      public var employmentPosition: EmploymentPosition? {
        get {
          return (resultMap["employment_position"] as? ResultMap).flatMap { EmploymentPosition(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "employment_position")
        }
      }

      public var investorProfileExperience: InvestorProfileExperience? {
        get {
          return (resultMap["investor_profile_experience"] as? ResultMap).flatMap { InvestorProfileExperience(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "investor_profile_experience")
        }
      }

      public var investorProfileRiskTolerance: InvestorProfileRiskTolerance? {
        get {
          return (resultMap["investor_profile_risk_tolerance"] as? ResultMap).flatMap { InvestorProfileRiskTolerance(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "investor_profile_risk_tolerance")
        }
      }

      public var investorProfileObjectives: InvestorProfileObjective? {
        get {
          return (resultMap["investor_profile_objectives"] as? ResultMap).flatMap { InvestorProfileObjective(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "investor_profile_objectives")
        }
      }

      public var investorProfileAnnualIncome: InvestorProfileAnnualIncome? {
        get {
          return (resultMap["investor_profile_annual_income"] as? ResultMap).flatMap { InvestorProfileAnnualIncome(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "investor_profile_annual_income")
        }
      }

      public var investorProfileNetWorthTotal: InvestorProfileNetWorthTotal? {
        get {
          return (resultMap["investor_profile_net_worth_total"] as? ResultMap).flatMap { InvestorProfileNetWorthTotal(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "investor_profile_net_worth_total")
        }
      }

      public var investorProfileNetWorthLiquid: InvestorProfileNetWorthLiquid? {
        get {
          return (resultMap["investor_profile_net_worth_liquid"] as? ResultMap).flatMap { InvestorProfileNetWorthLiquid(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "investor_profile_net_worth_liquid")
        }
      }

      public var disclosuresDrivewealthTermsOfUse: DisclosuresDrivewealthTermsOfUse? {
        get {
          return (resultMap["disclosures_drivewealth_terms_of_use"] as? ResultMap).flatMap { DisclosuresDrivewealthTermsOfUse(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "disclosures_drivewealth_terms_of_use")
        }
      }

      public var disclosuresDrivewealthCustomerAgreement: DisclosuresDrivewealthCustomerAgreement? {
        get {
          return (resultMap["disclosures_drivewealth_customer_agreement"] as? ResultMap).flatMap { DisclosuresDrivewealthCustomerAgreement(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "disclosures_drivewealth_customer_agreement")
        }
      }

      public var disclosuresDrivewealthMarketDataAgreement: DisclosuresDrivewealthMarketDataAgreement? {
        get {
          return (resultMap["disclosures_drivewealth_market_data_agreement"] as? ResultMap).flatMap { DisclosuresDrivewealthMarketDataAgreement(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "disclosures_drivewealth_market_data_agreement")
        }
      }

      public var disclosuresRule14b: DisclosuresRule14b? {
        get {
          return (resultMap["disclosures_rule14b"] as? ResultMap).flatMap { DisclosuresRule14b(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "disclosures_rule14b")
        }
      }

      public var disclosuresDrivewealthPrivacyPolicy: DisclosuresDrivewealthPrivacyPolicy? {
        get {
          return (resultMap["disclosures_drivewealth_privacy_policy"] as? ResultMap).flatMap { DisclosuresDrivewealthPrivacyPolicy(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "disclosures_drivewealth_privacy_policy")
        }
      }

      public var disclosuresSignedBy: DisclosuresSignedBy? {
        get {
          return (resultMap["disclosures_signed_by"] as? ResultMap).flatMap { DisclosuresSignedBy(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "disclosures_signed_by")
        }
      }

      public var taxIdValue: TaxIdValue? {
        get {
          return (resultMap["tax_id_value"] as? ResultMap).flatMap { TaxIdValue(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "tax_id_value")
        }
      }

      public var taxIdType: TaxIdType? {
        get {
          return (resultMap["tax_id_type"] as? ResultMap).flatMap { TaxIdType(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "tax_id_type")
        }
      }

      public var citizenship: Citizenship? {
        get {
          return (resultMap["citizenship"] as? ResultMap).flatMap { Citizenship(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "citizenship")
        }
      }

      public var gender: Gender? {
        get {
          return (resultMap["gender"] as? ResultMap).flatMap { Gender(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "gender")
        }
      }

      public var maritalStatus: MaritalStatus? {
        get {
          return (resultMap["marital_status"] as? ResultMap).flatMap { MaritalStatus(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "marital_status")
        }
      }

      public var birthdate: Birthdate? {
        get {
          return (resultMap["birthdate"] as? ResultMap).flatMap { Birthdate(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "birthdate")
        }
      }

      public var addressStreet1: AddressStreet1? {
        get {
          return (resultMap["address_street1"] as? ResultMap).flatMap { AddressStreet1(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "address_street1")
        }
      }

      public var addressCity: AddressCity? {
        get {
          return (resultMap["address_city"] as? ResultMap).flatMap { AddressCity(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "address_city")
        }
      }

      public var addressPostalCode: AddressPostalCode? {
        get {
          return (resultMap["address_postal_code"] as? ResultMap).flatMap { AddressPostalCode(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "address_postal_code")
        }
      }

      public var addressCountry: AddressCountry? {
        get {
          return (resultMap["address_country"] as? ResultMap).flatMap { AddressCountry(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "address_country")
        }
      }

      public struct FirstName: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct LastName: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct Country: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct EmailAddress: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct Language: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct EmploymentStatus: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct EmploymentType: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct EmploymentPosition: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct InvestorProfileExperience: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct InvestorProfileRiskTolerance: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct InvestorProfileObjective: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct InvestorProfileAnnualIncome: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct InvestorProfileNetWorthTotal: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct InvestorProfileNetWorthLiquid: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct DisclosuresDrivewealthTermsOfUse: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct DisclosuresDrivewealthCustomerAgreement: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct DisclosuresDrivewealthMarketDataAgreement: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct DisclosuresRule14b: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct DisclosuresDrivewealthPrivacyPolicy: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct DisclosuresSignedBy: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct TaxIdValue: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct TaxIdType: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct Citizenship: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct Gender: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct MaritalStatus: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct Birthdate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct AddressStreet1: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct AddressCity: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct AddressPostalCode: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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

      public struct AddressCountry: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["KycFormFieldConfig"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("choices", type: .list(.object(Choice.selections))),
            GraphQLField("placeholder", type: .scalar(String.self)),
            GraphQLField("required", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(choices: [Choice?]? = nil, placeholder: String? = nil, `required`: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "KycFormFieldConfig", "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, "placeholder": placeholder, "required": `required`])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public var placeholder: String? {
          get {
            return resultMap["placeholder"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeholder")
          }
        }

        public var `required`: Bool? {
          get {
            return resultMap["required"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "required")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KycFormChoicesFieldConfig"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: String, name: String) {
            self.init(unsafeResultMap: ["__typename": "KycFormChoicesFieldConfig", "value": value, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var value: String {
            get {
              return resultMap["value"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
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
  }
}
