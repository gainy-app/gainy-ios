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
}
