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
            
            var province = cache.address_province ?? ""
            let provinceCode = String(province.prefix(2))
            async let res = self.dwAPI.upsertKycForm(address_city: cache.address_city,
                                                     address_country: cache.country,
                                                     address_postal_code: cache.address_postal_code,
                                                     address_province: provinceCode,
                                                     address_street1: cache.address_street1,
                                                     address_street2: cache.address_street2,
                                                     birthdate: cache.birthdate,
                                                     citizenship: nil,
                                                     country: cache.country,
                                                     disclosures_drivewealth_customer_agreement: cache.disclosures_drivewealth_customer_agreement,
                                                     disclosures_drivewealth_data_sharing: nil,
                                                     disclosures_drivewealth_ira_agreement: cache.disclosures_drivewealth_ira_agreement,
                                                     disclosures_drivewealth_market_data_agreement: cache.disclosures_drivewealth_market_data_agreement,
                                                     disclosures_drivewealth_privacy_policy: nil,
                                                     disclosures_drivewealth_terms_of_use: cache.disclosures_drivewealth_terms_of_use,
                                                     disclosures_extended_hours_agreement: nil,
                                                     disclosures_rule14b: nil,
                                                     disclosures_signed_by: nil,
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
                                                     investor_profile_experience: nil,
                                                     investor_profile_net_worth_liquid: nil,
                                                     investor_profile_net_worth_total: cache.investor_profile_net_worth_total,
                                                     investor_profile_objectives: nil,
                                                     investor_profile_risk_tolerance: nil,
                                                     tax_treaty_with_us: nil,
                                                     tax_id_value: cache.tax_id_value,
                                                     tax_id_type: cache.tax_id_type,
                                                     politically_exposed_names: nil,
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
