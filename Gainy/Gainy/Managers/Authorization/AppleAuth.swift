//
//  AppleAuth.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/20/21.
//

import CryptoKit
import AuthenticationServices
import FirebaseAuth
import GainyCommon

enum AppleAuthError: Error, Equatable {

    case inconsistencyCall
    case noToken
    case tokenDecodingError
    case authorizationFailed
    case authorizationCancelled

    case unexpected(code: Int)
}

final class AppleAuth: NSObject, AuthorizationProtocol, ASAuthorizationControllerDelegate {
    
    private var currentNonce: String?
    private var completion: ((Bool, Error?) -> Void)?
    private var authorizationController: ASAuthorizationController? = nil
    
    @UserDefault<String>("appleAuthorizedUserIdKey")
    private(set) var appleAuthorizedUserId: String?
    
    @UserDefault<String>("appleAuthorizedUserFirstName")
    private(set) var firstName: String?
    
    @UserDefault<String>("appleAuthorizedUserLastName")
    private(set) var lastName: String?
    
    @UserDefault<String>("appleAuthorizedUserEmailName")
    private(set) var email: String?
    
    func signIn(_ fromViewController: UIViewController?, completion: @escaping (Bool, Error?) -> Void) {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        // Generate nonce for validation after authentication successful
        self.currentNonce = randomNonceString()
        // Set the SHA256 hashed nonce to ASAuthorizationAppleIDRequest
        request.nonce = sha256(currentNonce!)

        // Present Apple authorization form
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
        self.authorizationController = authorizationController
        self.completion = completion
    }
    
    func signOut() throws {
        
        self.appleAuthorizedUserId = nil
        // Perform sign out from Firebase
        try Auth.auth().signOut()
    }
    
    func isAuthorized() -> Bool {
        
        if self.appleAuthorizedUserId != nil && Auth.auth().currentUser != nil {
            return true
        }
        
        return false
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        self.authorizationController = nil
        let error = error as NSError
        if error.code == ASAuthorizationError.Code.canceled.rawValue || error.code ==  ASAuthorizationError.Code.unknown.rawValue {
            if let completion = self.completion {
                completion(false, AppleAuthError.authorizationCancelled)
                self.completion = nil
            }
            return
        }
        dprint("Apple Auth error: \(error)")
        if let completion = self.completion {
            completion(false, AppleAuthError.authorizationFailed)
            self.completion = nil
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        self.authorizationController = nil
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            // Save authorised user ID for future reference
            self.appleAuthorizedUserId = appleIDCredential.user
            if let firstName = appleIDCredential.fullName?.givenName {
                self.firstName = firstName
            }
            if let lastName = appleIDCredential.fullName?.familyName {
                self.lastName = lastName
            }
            if let email = appleIDCredential.email {
                self.email = email
            }
            
            // Retrieve the secure nonce generated during Apple sign in
            guard let nonce = self.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                if let completion = self.completion {
                    completion(false, AppleAuthError.inconsistencyCall)
                    self.completion = nil
                }
            }

            // Retrieve Apple identity token
            guard let appleIDToken = appleIDCredential.identityToken else {
                dprint("Failed to fetch identity token")
                if let completion = self.completion {
                    completion(false, AppleAuthError.noToken)
                    self.completion = nil
                }
                return
            }

            // Convert Apple identity token to string
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                dprint("Failed to decode identity token")
                if let completion = self.completion {
                    completion(false, AppleAuthError.tokenDecodingError)
                    self.completion = nil
                }
                return
            }

            // Initialize a Firebase credential using secure nonce and Apple identity token
            let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                              idToken: idTokenString,
                                                              rawNonce: nonce)
                
            // Sign in with Firebase
            Auth.auth().signIn(with: firebaseCredential) { (authResult, error) in
                
                if let error = error {
                    if let completion = self.completion {
                        completion(false, AppleAuthError.authorizationFailed)
                        self.completion = nil
                    }
                    dprint(error.localizedDescription)
                    return
                }
                
                if let completion = self.completion {
                    completion(true, nil)
                    self.completion = nil
                }
                
                if let givenName = appleIDCredential.fullName?.givenName {
                    // Mak a request to set user's display name on Firebase
                    let changeRequest = authResult?.user.createProfileChangeRequest()
                    changeRequest?.displayName = givenName
                    changeRequest?.commitChanges(completion: { (error) in
                        
                        if let error = error {
                            dprint(error.localizedDescription)
                        } else {
                            dprint("Updated display name: \(Auth.auth().currentUser!.displayName!)")
                        }
                    })
                }
            }
            
        }
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
