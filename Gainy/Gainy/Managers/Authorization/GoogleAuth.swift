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
            let idToken = authentication.idToken,
            let userID = user?.userID
          else {
            completion(false, GoogleAuthError.noToken)
            return
          }
        
          self.googleAuthorizedUserId = userID
          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

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
}
