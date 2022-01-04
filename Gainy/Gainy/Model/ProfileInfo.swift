//
//  ProfileInfo.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/20/21.
//

import Foundation

public final class ProfileInfoBuilder: NSObject {
    
    public var avatarURLString: String?
    public var firstName: String?
    public var lastName: String?
    public var email: String?
    public var gender: Int?
    public var legalAddress: String?
    public var userID: String?
    
    public func buildProfileInfo() -> ProfileInfo? {
        
        guard let avatarURLString = self.avatarURLString,
              let firstName = self.firstName,
              let lastName = self.lastName,
              let email = self.email,
              let gender = self.gender,
              let legalAddress = self.legalAddress,
              let userID = self.userID
        else {
            return nil
        }
        
        return ProfileInfo.init(avatarURLString: avatarURLString,
                                firstName: firstName,
                                lastName: lastName,
                                email: email,
                                gender: gender,
                                legalAddress: legalAddress,
                                userID: userID)
    }
}


public final class ProfileInfo: NSObject {
    
    public let avatarURLString: String
    public let firstName: String
    public let lastName: String
    public let email: String
    public var gender: Int
    public let legalAddress: String
    public let userID: String
    
    init(avatarURLString: String,
         firstName: String,
         lastName: String,
         email: String,
         gender: Int,
         legalAddress: String,
         userID: String) {
        
        self.avatarURLString = avatarURLString
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.gender = gender
        self.legalAddress = legalAddress
        self.userID = userID
    }
}
