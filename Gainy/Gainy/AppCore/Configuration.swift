//
//  Configuration.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.10.2021.
//

import UIKit

enum BuildEnvironment: String {
    case staging = "staging"
    case production = "production"
    
    var version: String {
        return "v1"
    }
    
    var mount: String {
        return "api"
    }
    
    var baseURL: String {
        switch self {
        case .staging: return "https://hasura-test.gainy-infra.net/v1/graphql"
        case .production: return "https://hasura-production.gainy-infra.net/v1/graphql"
        }
    }
    
    var apiURL: String {
        return "\(self.baseURL)\(self.mount)/"
    }
    
    var clientId: String {
        switch self {
        case .staging: return "1"
        case .production: return "1"
        }
    }
    
    var clientSecret: String {
        switch self {
        case .staging: return ""
        case .production: return ""
        }
    }
}

struct Configuration {
    lazy var environment: BuildEnvironment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "SchemeName") as? String {
            if configuration.contains("Staging") {
                return BuildEnvironment.staging
            }
        }
        return BuildEnvironment.production
    }()
}
