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
                citizenship: cache.citizenship,
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
}
