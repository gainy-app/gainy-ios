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

enum GoogleAuthError: Error, Equatable {

    case inconsistencyCall
    case noClientID
    case noToken
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
        GIDSignIn.sharedInstance.signIn(with: config, presenting: fromViewController) { [unowned self] user, error in
            
            if let error = error as? NSError {
                if error.domain == "com.google.GIDSignIn" && error.code == -5 {
                    completion(false, GoogleAuthError.authorizationCancelled)
                } else {
                    completion(false, GoogleAuthError.authorizationFailed)
                }
                return
            }
            
            guard
                let authentication = user?.authentication,
                let userID = user?.userID
            else {
                completion(false, GoogleAuthError.noToken)
                return
            }
            
            if let firstName = user?.profile?.givenName {
                self.firstName = firstName
            }
            
            if let lastName = user?.profile?.familyName {
                self.lastName = lastName
            }
            
            if let email = user?.profile?.email {
                self.email = email
            }
            self.googleAuthorizedUserId = userID
            
            if let idToken = authentication.idToken {
                self.finishSignIn(idToken, authentication.accessToken, completion)
            } else {
                authentication.do { refreshedAuthentication, error in
                    
                    if error != nil {
                        completion(false, GoogleAuthError.noToken)
                        return
                    }
                    guard let idToken = refreshedAuthentication?.idToken, let accessToken =   refreshedAuthentication?.accessToken else {
                        completion(false, GoogleAuthError.noToken)
                        return
                    }
                    self.finishSignIn(idToken, accessToken, completion)
                }
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
                  print(error.localizedDescription)
                  return
              }
              
              completion(true, nil)
          }
    }
}
