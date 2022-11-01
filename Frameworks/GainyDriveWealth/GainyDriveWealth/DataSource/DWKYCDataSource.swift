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
    
    @KeychainString("passcodeSHA256")
    internal var passcodeSHA256: String?
    
    @UserDefaultBool("useFaceID")
    internal var useFaceID: Bool
    
    private (set) var kycFormConfig: KycGetFormConfigQuery.Data.KycGetFormConfig? = nil
    
    func loadKYCFromConfig(forceReload: Bool = false, _ completion: @escaping (Bool) -> Void) {
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
    
    func upsertKycForm(address_city:  String? = nil,
                       address_country: String? = nil,
                       address_postal_code: String? = nil,
                       address_province: String? = nil,
                       address_street1: String? = nil,
                       address_street2: String? = nil,
                       birthdate: date? = nil,
                       citizenship: String? = nil,
                       country: String? = nil,
                       disclosures_drivewealth_customer_agreement: Bool? = nil,
                       disclosures_drivewealth_data_sharing: Bool? = nil,
                       disclosures_drivewealth_ira_agreement: Bool? = nil,
                       disclosures_drivewealth_market_data_agreement: Bool? = nil,
                       disclosures_drivewealth_privacy_policy: Bool? = nil,
                       disclosures_drivewealth_terms_of_use: Bool? = nil,
                       disclosures_extended_hours_agreement: Bool? = nil,
                       disclosures_rule14b: Bool? = nil,
                       disclosures_signed_by: String? = nil, email_address: String? = nil,
                       employment_affiliated_with_a_broker: Bool? = nil,
                       employment_company_name: String? = nil,
                       employment_is_director_of_a_public_company: String? = nil,
                       employment_position: String? = nil,
                       employment_status: String? = nil,
                       employment_type: String? = nil,
                       first_name: String? = nil,
                       gender: String? = nil,
                       investor_profile_annual_income: bigint? = nil,
                       investor_profile_experience: String? = nil,
                       investor_profile_net_worth_liquid: bigint? = nil,
                       investor_profile_net_worth_total: bigint? = nil,
                       investor_profile_objectives: String? = nil,
                       investor_profile_risk_tolerance: String? = nil,
                       tax_treaty_with_us: Bool? = nil,
                       tax_id_value: String? = nil,
                       tax_id_type: String? = nil,
                       politically_exposed_names: String? = nil,
                       phone_number: String? = nil,
                       marital_status: String? = nil,
                       last_name: String? = nil,
                       language: String? = nil,
                       is_us_tax_payer: Bool? = nil,
                       irs_backup_withholdings_notified: Bool? = nil,
                       _ completion: @escaping (Bool) -> Void) {
        
        Task {
            async let res = self.dwAPI.upsertKycForm(address_city:address_city,
                                                            address_country:address_country,
                                                            address_postal_code:address_postal_code,
                                                            address_province:address_province,
                                                            address_street1:address_street1,
                                                            address_street2:address_street2,
                                                            birthdate:birthdate,
                                                            citizenship:citizenship,
                                                            country:country,
                                                            disclosures_drivewealth_customer_agreement:disclosures_drivewealth_customer_agreement,
                                                            disclosures_drivewealth_data_sharing:disclosures_drivewealth_data_sharing,
                                                            disclosures_drivewealth_ira_agreement:disclosures_drivewealth_ira_agreement,
                                                            disclosures_drivewealth_market_data_agreement:disclosures_drivewealth_market_data_agreement,
                                                            disclosures_drivewealth_privacy_policy:disclosures_drivewealth_privacy_policy,
                                                            disclosures_drivewealth_terms_of_use:disclosures_drivewealth_terms_of_use,
                                                            disclosures_extended_hours_agreement:disclosures_extended_hours_agreement,
                                                            disclosures_rule14b:disclosures_rule14b,
                                                            disclosures_signed_by:disclosures_signed_by,
                                                            email_address:email_address,
                                                            employment_affiliated_with_a_broker:employment_affiliated_with_a_broker,
                                                            employment_company_name:employment_company_name,
                                                            employment_is_director_of_a_public_company:employment_is_director_of_a_public_company,
                                                            employment_position:employment_position,
                                                            employment_status:employment_status,
                                                            employment_type:employment_type,
                                                            first_name:first_name,
                                                            gender:gender,
                                                            investor_profile_annual_income:investor_profile_annual_income,
                                                            investor_profile_experience:investor_profile_experience,
                                                            investor_profile_net_worth_liquid:investor_profile_net_worth_liquid,
                                                            investor_profile_net_worth_total:investor_profile_net_worth_total,
                                                            investor_profile_objectives:investor_profile_objectives,
                                                            investor_profile_risk_tolerance:investor_profile_risk_tolerance,
                                                            tax_treaty_with_us:tax_treaty_with_us,
                                                            tax_id_value:tax_id_value,
                                                            tax_id_type:tax_id_type,
                                                            politically_exposed_names:politically_exposed_names,
                                                            phone_number:phone_number,
                                                            marital_status:marital_status,
                                                            last_name:last_name,
                                                            language:language,
                                                            is_us_tax_payer:is_us_tax_payer,
                                                            irs_backup_withholdings_notified:irs_backup_withholdings_notified)
            do {
                let result = try await res
                await MainActor.run {
                    completion(true)
                }
            } catch {
                completion(false)
            }
        }
    }
}
