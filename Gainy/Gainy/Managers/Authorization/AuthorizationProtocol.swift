//
//  AuthorizationProtocol.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/20/21.
//

import Foundation
import UIKit

protocol AuthorizationProtocol: AnyObject {
    
    func signIn(_ fromViewController: UIViewController?, completion: @escaping (_ success: Bool, _ error: Error?) -> Void)
    func signOut() throws
    func isAuthorized() -> Bool
}
