//
//  DWKYCDataCache.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 10/31/22.
//

import GainyCommon
import GainyAPI

struct DWKYCDataCache: Codable {
    
    public var address_city:  String? = nil
    public var address_postal_code: String? = nil
    public var address_province: String? = nil
    public var address_street1: String? = nil
    public var address_street2: String? = nil
    public var birthdate: date? = nil
    public var country: String? = nil
    public var citizenship: String? = nil
    public var email_address: String? = nil
    public var employment_affiliated_with_a_broker: Bool? = nil
    public var employment_company_name: String? = nil
    public var employment_is_director_of_a_public_company: String? = nil
    public var employment_position: String? = nil
    public var employment_status: String? = nil
    public var employment_type: String? = nil
    public var first_name: String? = nil
    public var investor_profile_annual_income: bigint? = nil
    public var investor_profile_net_worth_total: bigint? = nil
    public var investor_profile_net_worth_liquid: bigint? = nil
    public var investor_profile_experience: String? = nil
    public var investor_profile_objectives: String? = nil
    public var investor_profile_risk_tolerance: String? = nil
    
    public var tax_id_value: String? = nil
    public var tax_id_type: String? = nil
    public var phone_number: String? = nil
    public var phone_number_country_iso: String? = nil
    public var phone_number_without_code: String? = nil
    public var payment_method: String? = nil
    public var source_of_founds: Int? = nil
    public var how_much_deposit: Double? = nil
    public var last_name: String? = nil
    public var is_us_tax_payer: Bool? = nil
    public var irs_backup_withholdings_notified: Bool? = nil
    public var politically_exposed_names: String? = nil
    
    
    public var account_filled: Bool? = nil
    public var identity_filled: Bool? = nil
    public var investor_profile_filled: Bool? = nil
    
    public var disclosures_all_agreements_qccepted: Bool? = nil
    
    public var disclosures_gainy_policy_agreement: Bool? = nil
    public var disclosures_gainy_customer_agreement: Bool? = nil
    
    public var disclosures_drivewealth_ira_agreement: Bool? = nil
    public var disclosures_drivewealth_market_data_agreement: Bool? = nil
    public var disclosures_drivewealth_terms_of_use: Bool? = nil
 
    public mutating func updateAccountFilled() {
        
        if email_address != nil,
           country != nil,
           citizenship != nil,
           phone_number != nil {
            account_filled = true
        } else {
            account_filled = false
        }
    }
    
    public mutating func updateIdentityFilled() {
        
        if first_name != nil,
           last_name != nil,
           birthdate != nil,
           address_street1 != nil,
           address_city != nil,
           address_province != nil,
           address_postal_code != nil
        {
            identity_filled = true
        } else {
            identity_filled = false
        }
    }
    
    public mutating func updateInvestorProfileFilled() {
        
        let allFilled = investor_profile_annual_income != nil &&
        investor_profile_net_worth_total != nil &&
        investor_profile_net_worth_liquid != nil &&
        investor_profile_experience != nil &&
        investor_profile_objectives != nil &&
        investor_profile_risk_tolerance != nil &&
        employment_status != nil
        
        var employmentFilled = true
        if let employment_status = employment_status, employment_status == "EMPLOYED" {
            employmentFilled = employment_company_name != nil &&
            employment_position != nil &&
            employment_type != nil
        }
        
        if allFilled && employmentFilled {
            investor_profile_filled = true
        } else {
            investor_profile_filled = false
        }
    }
}
