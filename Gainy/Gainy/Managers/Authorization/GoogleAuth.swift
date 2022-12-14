//
//  GoogleAuth.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/20/21.
//

import AuthenticationServices
import FirebaseAuth
import GoogleSignIn
import Firebase
import GainyCommon

enum GoogleAuthError: Error, Equatable {

    case inconsistencyCall
    case noClientID
    case noToken
    case noUser
    case noUserID
    case authorizationFailed
    case authorizationCancelled

    case unexpected(code: Int)
}

final class GoogleAuth: NSObject {

    @UserDefault<String>("googleAuthorizedUserIdKey")
    private(set) var googleAuthorizedUserId: String?
    
    @UserDefault<String>("googleAuthorizedUserFirstName")
    private(set) var firstName: String?
    
    @UserDefault<String>("googleAuthorizedUserLastName")
    private(set) var lastName: String?
    
    @UserDefault<String>("googleAuthorizedUserEmailName")
    private(set) var email: String?
    
    
    func signIn(_ fromViewController: UIViewController?, completion: @escaping (Bool, Error?) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(false, GoogleAuthError.noClientID)
            return
        }
        
        guard let fromViewController = fromViewController else {
            
            completion(false, GoogleAuthError.inconsistencyCall)
            return
        }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: fromViewController) { [unowned self] result, error in
            
            if let error = error as? NSError {
                if error.domain == "com.google.GIDSignIn" && error.code == -5 {
                    completion(false, GoogleAuthError.authorizationCancelled)
                } else {
                    completion(false, GoogleAuthError.authorizationFailed)
                }
                return
            }
            
            guard let googleUser = result?.user
            else {
                completion(false, GoogleAuthError.noUser)
                return
            }
            
            guard let userID = googleUser.userID
            else {
                completion(false, GoogleAuthError.noUserID)
                return
            }
            
            if let firstName = googleUser.profile?.givenName {
                self.firstName = firstName
            }
            
            if let lastName = googleUser.profile?.familyName {
                self.lastName = lastName
            }
            
            if let email = googleUser.profile?.email {
                self.email = email
            }
            self.googleAuthorizedUserId = userID
            
            if let idToken = googleUser.idToken {
                self.finishSignIn(idToken.tokenString, googleUser.accessToken.tokenString, completion)
            } else {
                googleUser.refreshTokensIfNeeded(completion: { user, error in
                    if error != nil {
                        completion(false, GoogleAuthError.noToken)
                        return
                    }
                    guard let googleUser = user
                    else {
                        completion(false, GoogleAuthError.noUserID)
                        return
                    }
                    guard let idToken = googleUser.idToken else {
                        completion(false, GoogleAuthError.noToken)
                        return
                    }
                    self.finishSignIn(idToken.tokenString, googleUser.accessToken.tokenString, completion)
                })
            }
        }
    }
    
    func signOut() throws {
        
        self.googleAuthorizedUserId = nil
        // Perform sign out from Firebase
        try Auth.auth().signOut()
    }
    
    func isAuthorized() -> Bool {
        
        if self.googleAuthorizedUserId != nil && Auth.auth().currentUser != nil {
            return true
        }
        
        return false
    }
    
    private func finishSignIn(_ idToken: String, _ accessToken: String, _ completion: @escaping (Bool, Error?) -> Void) {
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken)

          Auth.auth().signIn(with: credential) { authResult, error in
             
              if let error = error {
                  completion(false, GoogleAuthError.authorizationFailed)
                  dprint(error.localizedDescription)
                  return
              }
              
              completion(true, nil)
          }
    }
}
