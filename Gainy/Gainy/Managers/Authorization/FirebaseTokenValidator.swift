//
//  FirebaseTokenValidator.swift
//  Gainy
//
//  Created by Anton Gubarenko on 04.10.2021.
//

import Foundation
import JWTDecode

/// Token validation and expire checker
final class FirebaseTokenValidator {
    
    init(token: String) {
        self.token = token
    }
    
    /// JWT token to decode
    let token: String
 
    //MARK: - Methods
    
    /// Is token valid
    /// - Returns: True - if valid
    func isValidToken() -> Bool {
        do {
            let jwt = try JWTDecode.decode(jwt: token)
            if let expDate = jwt.expiresAt {
                if Date() > expDate {
                    return false
                } else {
                    return true
                }
            }
            return false
        } catch {
            dprint(error.localizedDescription)
        }
        return false
    }
    
    /// Expiration date, if exists
    /// - Returns: Date if JWT expiry
    func expDate() -> Date? {
        do {
            let jwt = try JWTDecode.decode(jwt: token)
            if let expDate = jwt.expiresAt {
                return expDate
            }
            return nil
        } catch {
            dprint(error.localizedDescription)
        }
        return nil
    }
}
