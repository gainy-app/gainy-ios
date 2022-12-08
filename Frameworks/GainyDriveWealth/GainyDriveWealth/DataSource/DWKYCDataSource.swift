//
//  DWKYCDataSource.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 10/31/22.
//

import GainyCommon
import GainyAPI


class DWKYCDataSource {
    
    unowned var dwAPI: DWAPI!
    internal var profileID: Int? = nil
    
    @KeychainString("passcodeSHA256")
    internal var passcodeSHA256: String?
    
    @UserDefaultBool("useFaceID")
    internal var useFaceID: Bool
    
    typealias FormCache = [Int : DWKYCDataCache]
    @UserDefault<FormCache>("kycFormCache")
    private var kycFormCacheInternal: FormCache?
    
    private (set) var kycFormConfig: KycGetFormConfigQuery.Data.KycGetFormConfig? = nil
    private (set) var kycFormValues: GetKycFormQuery.Data.AppKycFormByPk? = nil
    
    public var kycFormCache: DWKYCDataCache? {
        get {
            guard let profileID = self.profileID else {
                return nil
            }
            let result = self.kycFormCacheInternal?[profileID]
            return result
        }
        set {
            guard let profileID = self.profileID else {
                return
            }
            if self.kycFormCacheInternal == nil {
                self.kycFormCacheInternal = [:]
            }
            self.kycFormCacheInternal?[profileID] = newValue
        }
    }
    
    func updateKYCCacheFromFormValues() {
        guard let values = self.kycFormValues else { return }
        guard var cache = self.kycFormCache else { return }
        
        if let value = values.addressCity {cache.address_city = value}
        if let value = values.addressCountry {cache.country = value}
        if let value = values.addressPostalCode {cache.address_postal_code = value}
        if let value = values.addressProvince {cache.address_province = value}
        if let value = values.addressStreet1 {cache.address_street1 = value}
        if let value = values.addressStreet2 {cache.address_street2 = value}
        if let value = values.birthdate {cache.birthdate = value}
        if let value = values.citizenship {cache.citizenship = value}
        if let value = values.country {cache.country = value}
//        if let value = values.disclosuresDrivewealthCustomerAgreement {cache.disclosures_drivewealth_customer_agreement = value}
//        if let value = values.disclosuresDrivewealthDataSharing {cache.disclosures_drivewealth_data_sharing = value}
        if let value = values.disclosuresDrivewealthIraAgreement {cache.disclosures_drivewealth_ira_agreement = value}
        if let value = values.disclosuresDrivewealthMarketDataAgreement {cache.disclosures_drivewealth_market_data_agreement = value}
//        if let value = values.disclosuresDrivewealthPrivacyPolicy {cache.disclosures_drivewealth_privacy_policy = value}
        if let value = values.disclosuresDrivewealthTermsOfUse {cache.disclosures_drivewealth_terms_of_use = value}
//        if let value = values.disclosuresExtendedHoursAgreement {cache.disclosures_extended_hours_agreement = value}
//        if let value = values.disclosuresRule14b {cache.disclosures_rule14b = value}
//        if let value = values.disclosuresSignedBy {cache.disclosures_signed_by = value}
        if let value = values.emailAddress {cache.email_address = value}
        if let value = values.employmentAffiliatedWithABroker {cache.employment_affiliated_with_a_broker = value}
        if let value = values.employmentCompanyName {cache.employment_company_name = value}
        if let value = values.employmentIsDirectorOfAPublicCompany {cache.employment_is_director_of_a_public_company = value}
        if let value = values.employmentPosition {cache.employment_position = value}
        if let value = values.employmentStatus {cache.employment_status = value}
        if let value = values.employmentType {cache.employment_type = value}
        if let value = values.firstName {cache.first_name = value}
//        if let value = values.gender {cache.gender = value}
        if let value = values.investorProfileAnnualIncome {cache.investor_profile_annual_income = value}
        if let value = values.investorProfileExperience {cache.investor_profile_experience = value}
        if let value = values.investorProfileNetWorthLiquid {cache.investor_profile_net_worth_liquid = value}
        if let value = values.investorProfileNetWorthTotal {cache.investor_profile_net_worth_total = value}
        if let value = values.investorProfileObjectives {cache.investor_profile_objectives = value}
        if let value = values.investorProfileRiskTolerance {cache.investor_profile_risk_tolerance = value}
//        if let value = values.taxTreatyWithUs {cache.tax_treaty_with_us = value}
        if let value = values.taxIdValue {cache.tax_id_value = value}
        if let value = values.taxIdType {cache.tax_id_type = value}
//        if let value = values.profileId {cache.profile_id = value}
        if let value = values.politicallyExposedNames {cache.politically_exposed_names = value}
        if let value = values.phoneNumber {cache.phone_number = value}
//        if let value = values.maritalStatus {cache.marital_status = value}
        if let value = values.lastName {cache.last_name = value}
//        if let value = values.language {cache.language = value}
        if let value = values.isUsTaxPayer {cache.is_us_tax_payer = value}
        if let value = values.irsBackupWithholdingsNotified {cache.irs_backup_withholdings_notified = value}
        
        cache.updateAccountFilled()
        cache.updateIdentityFilled()
        cache.updateInvestorProfileFilled()
        
        self.kycFormCache = cache
    }
    
    func loadKYCFormConfig(forceReload: Bool = false, _ completion: @escaping (Bool) -> Void) {
        guard self.kycFormConfig == nil else {
            completion(true)
            return
        }
        
        Task {
            async let formConfig = self.dwAPI.getKycFormConfig()
            do {
                let formConfigRes = try await formConfig
                await MainActor.run {
                    self.kycFormConfig = formConfigRes
                    completion(true)
                }
            } catch {
                completion(false)
            }
        }
    }
    
    func loadKYCFormValues(forceReload: Bool = false, _ completion: @escaping (Bool) -> Void) {
        Task {
            async let formValues = self.dwAPI.getKycForm()
            do {
                let formValuesRes = try await formValues
                await MainActor.run {
                    self.kycFormValues = formValuesRes
                    completion(true)
                }
            } catch {
                completion(false)
            }
        }
    }
    
    func sendKYCForm(_ completion: @escaping (Bool) -> Void) {
        
        Task {
            async let res = self.dwAPI.kycSendForm()
            do {
                _ = try await res
                await MainActor.run {
                    completion(true)
                }
            } catch {
                await MainActor.run {
                    completion(false)
                }
            }
        }
    }
    
    func upsertKycFormFromCache(_ completion: @escaping (Bool) -> Void) {
        
        Task {
            guard let cache = self.kycFormCache else {
                await MainActor.run {
                    completion(false)
                }
                return
            }
            
            let disclosures_drivewealth_ira_agreement = cache.disclosures_all_agreements_qccepted
            let disclosures_drivewealth_terms_of_use = cache.disclosures_all_agreements_qccepted
            let disclosures_drivewealth_customer_agreement = cache.disclosures_all_agreements_qccepted
            let disclosures_drivewealth_market_data_agreement = cache.disclosures_all_agreements_qccepted
            
            let disclosures_drivewealth_privacy_policy = cache.disclosures_all_agreements_qccepted
            let disclosures_rule14b = cache.disclosures_all_agreements_qccepted
                        
            let address_country = cache.country
            
            var valueCitizenship = cache.citizenship
            if let value = valueCitizenship, let alpha3 = self.alpha2ToAlpha3[value] {
                valueCitizenship = alpha3
            }
            let citizenship = valueCitizenship
            
            let disclosures_signed_by = cache.first_name
            let province = cache.address_province ?? ""
            let provinceCode = String(province.prefix(2))
            
            async let res = self.dwAPI.upsertKycForm(
                address_city: cache.address_city,
                address_country: address_country,
                address_postal_code: cache.address_postal_code,
                address_province: provinceCode,
                address_street1: cache.address_street1,
                address_street2: cache.address_street2,
                birthdate: cache.birthdate,
                citizenship: citizenship,
                country: cache.country,
                disclosures_drivewealth_customer_agreement: disclosures_drivewealth_customer_agreement,
                disclosures_drivewealth_data_sharing: nil,
                disclosures_drivewealth_ira_agreement: disclosures_drivewealth_ira_agreement,
                disclosures_drivewealth_market_data_agreement: disclosures_drivewealth_market_data_agreement,
                disclosures_drivewealth_privacy_policy: disclosures_drivewealth_privacy_policy,
                disclosures_drivewealth_terms_of_use: disclosures_drivewealth_terms_of_use,
                disclosures_extended_hours_agreement: nil,
                disclosures_rule14b: disclosures_rule14b,
                disclosures_signed_by: disclosures_signed_by,
                email_address: cache.email_address,
                employment_affiliated_with_a_broker: cache.employment_affiliated_with_a_broker,
                employment_company_name: cache.employment_company_name,
                employment_is_director_of_a_public_company: cache.employment_is_director_of_a_public_company,
                employment_position: cache.employment_position,
                employment_status: cache.employment_status,
                employment_type: cache.employment_type,
                first_name: cache.first_name,
                gender: nil,
                investor_profile_annual_income: cache.investor_profile_annual_income,
                investor_profile_experience: cache.investor_profile_experience,
                investor_profile_net_worth_liquid: cache.investor_profile_net_worth_liquid,
                investor_profile_net_worth_total: cache.investor_profile_net_worth_total,
                investor_profile_objectives: cache.investor_profile_objectives,
                investor_profile_risk_tolerance: cache.investor_profile_risk_tolerance,
                tax_treaty_with_us: nil,
                tax_id_value: cache.tax_id_value,
                tax_id_type: cache.tax_id_type,
                politically_exposed_names: cache.politically_exposed_names,
                phone_number: cache.phone_number,
                marital_status: nil,
                last_name: cache.last_name,
                language: nil,
                is_us_tax_payer: cache.is_us_tax_payer,
                irs_backup_withholdings_notified: cache.irs_backup_withholdings_notified)
            do {
                _ = try await res
                await MainActor.run {
                    completion(true)
                }
            } catch {
                await MainActor.run {
                    completion(false)
                }
            }
        }
    }
    
    public lazy var alpha2ToAlpha3: [String : String] = {
        let result = [
            "MV": "MDV",
            "DM": "DMA",
            "BM": "BMU",
            "MQ": "MTQ",
            "MG": "MDG",
            "ST": "STP",
            "TT": "TTO",
            "SA": "SAU",
            "RO": "ROU",
            "NG": "NGA",
            "SG": "SGP",
            "PA": "PAN",
            "VI": "VIR",
            "KZ": "KAZ",
            "TZ": "TZA",
            "TK": "TKL",
            "KP": "PRK",
            "CN": "CHN",
            "FR": "FRA",
            "VG": "VGB",
            "NA": "NAM",
            "PR": "PRI",
            "BI": "BDI",
            "SZ": "SWZ",
            "TL": "TLS",
            "TG": "TGO",
            "NR": "NRU",
            "AU": "AUS",
            "GB": "GBR",
            "CV": "CPV",
            "KH": "KHM",
            "CM": "CMR",
            "MR": "MRT",
            "CH": "CHE",
            "CL": "CHL",
            "PL": "POL",
            "NZ": "NZL",
            "HT": "HTI",
            "CF": "CAF",
            "MC": "MCO",
            "US": "USA",
            "NC": "NCL",
            "PS": "PSE",
            "IE": "IRL",
            "GA": "GAB",
            "DE": "DEU",
            "AL": "ALB",
            "HU": "HUN",
            "IS": "ISL",
            "AF": "AFG",
            "GG": "GGY",
            "UG": "UGA",
            "MA": "MAR",
            "GE": "GEO",
            "GT": "GTM",
            "FK": "FLK",
            "UY": "URY",
            "PE": "PER",
            "PH": "PHL",
            "TM": "TKM",
            "BW": "BWA",
            "BV": "BVT",
            "AW": "ABW",
            "TC": "TCA",
            "TV": "TUV",
            "TR": "TUR",
            "NP": "NPL",
            "PF": "PYF",
            "UZ": "UZB",
            "DO": "DOM",
            "EC": "ECU",
            "AT": "AUT",
            "LS": "LSO",
            "CD": "COD",
            "MO": "MAC",
            "LY": "LBY",
            "BJ": "BEN",
            "MP": "MNP",
            "PT": "PRT",
            "ME": "MNE",
            "BS": "BHS",
            "MX": "MEX",
            "NL": "NLD",
            "AZ": "AZE",
            "MN": "MNG",
            "MS": "MSR",
            "BF": "BFA",
            "GR": "GRC",
            "ZA": "ZAF",
            "AE": "ARE",
            "SC": "SYC",
            "AS": "ASM",
            "EE": "EST",
            "UA": "UKR",
            "MU": "MUS",
            "MH": "MHL",
            "BD": "BGD",
            "SS": "SSD",
            "CX": "CXR",
            "CY": "CYP",
            "BR": "BRA",
            "KR": "KOR",
            "GD": "GRD",
            "PY": "PRY",
            "BN": "BRN",
            "ML": "MLI",
            "KW": "KWT",
            "KG": "KGZ",
            "TJ": "TJK",
            "CC": "CCK",
            "WS": "WSM",
            "IL": "ISR",
            "BA": "BIH",
            "MD": "MDA",
            "NI": "NIC",
            "NE": "NER",
            "BL": "BLM",
            "GP": "GLP",
            "CO": "COL",
            "GH": "GHA",
            "AX": "ALA",
            "BH": "BHR",
            "IN": "IND",
            "ID": "IDN",
            "JO": "JOR",
            "QA": "QAT",
            "NF": "NFK",
            "BE": "BEL",
            "HR": "HRV",
            "SL": "SLE",
            "GU": "GUM",
            "SM": "SMR",
            "KM": "COM",
            "DK": "DNK",
            "BB": "BRB",
            "JM": "JAM",
            "JP": "JPN",
            "AQ": "ATA",
            "VE": "VEN",
            "BY": "BLR",
            "GW": "GNB",
            "FI": "FIN",
            "GS": "SGS",
            "UM": "UMI",
            "SO": "SOM",
            "RU": "RUS",
            "MM": "MMR",
            "GI": "GIB",
            "ET": "ETH",
            "KY": "CYM",
            "IQ": "IRQ",
            "CK": "COK",
            "SJ": "SJM",
            "SY": "SYR",
            "LA": "LAO",
            "LV": "LVA",
            "LB": "LBN",
            "AD": "AND",
            "AO": "AGO",
            "VN": "VNM",
            "LI": "LIE",
            "IO": "IOT",
            "RE": "REU",
            "GL": "GRL",
            "IR": "IRN",
            "MF": "MAF",
            "EH": "ESH",
            "IM": "IMN",
            "MK": "MKD",
            "KN": "KNA",
            "CA": "CAN",
            "SI": "SVN",
            "MY": "MYS",
            "GM": "GMB",
            "CW": "CUW",
            "BT": "BTN",
            "BO": "BOL",
            "CU": "CUB",
            "TW": "TWN",
            "VU": "VUT",
            "SN": "SEN",
            "SH": "SHN",
            "WF": "WLF",
            "JE": "JEY",
            "LC": "LCA",
            "LR": "LBR",
            "BQ": "BES",
            "CI": "CIV",
            "FO": "FRO",
            "SB": "SLB",
            "LU": "LUX",
            "NU": "NIU",
            "FM": "FSM",
            "GF": "GUF",
            "TF": "ATF",
            "DZ": "DZA",
            "KI": "KIR",
            "KE": "KEN",
            "SK": "SVK",
            "YT": "MYT",
            "VC": "VCT",
            "GY": "GUY",
            "MT": "MLT",
            "SX": "SXM",
            "FJ": "FJI",
            "VA": "VAT",
            "OM": "OMN",
            "YE": "YEM",
            "CR": "CRI",
            "MZ": "MOZ",
            "PG": "PNG",
            "PM": "SPM",
            "TH": "THA",
            "SR": "SUR",
            "DJ": "DJI",
            "SE": "SWE",
            "GN": "GIN",
            "AG": "ATG",
            "AM": "ARM",
            "CZ": "CZE",
            "RW": "RWA",
            "TD": "TCD",
            "IT": "ITA",
            "RS": "SRB",
            "AR": "ARG",
            "HM": "HMD",
            "HN": "HND",
            "CG": "COG",
            "PN": "PCN",
            "MW": "MWI",
            "AI": "AIA",
            "BG": "BGR",
            "BZ": "BLZ",
            "NO": "NOR",
            "PK": "PAK",
            "PW": "PLW",
            "LT": "LTU",
            "EG": "EGY",
            "SV": "SLV",
            "GQ": "GNQ",
            "ER": "ERI",
            "HK": "HKG",
            "TO": "TON",
            "TN": "TUN",
            "ES": "ESP",
            "LK": "LKA",
            "SD": "SDN",
            "ZM": "ZMB",
            "ZW": "ZWE"
        ]
        return result
    }()
}
