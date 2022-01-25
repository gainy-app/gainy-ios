//
//  IDFARequestViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.01.2022.
//

import UIKit
import AppTrackingTransparency
import AdSupport

final class IDFARequestViewController: UIViewController {
    
    @IBAction func requestIDFAAction() {
        requestTrackingAuthorization()
    }
    
    private func requestTrackingAuthorization() {
        guard #available(iOS 14, *) else { return }
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    dprint("Got IDFA")
                    print(self.identifierForAdvertising())
                case .denied, .restricted:
                    dprint("Denied IDFA")
                case .notDetermined:
                    dprint("Not Determined IDFA")
                @unknown default:
                    break
                }
            }
        }
    }
    
    private func identifierForAdvertising() -> String? {
        // check if advertising tracking is enabled in user’s setting
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            return nil
        }
    }
}
