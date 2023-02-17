//
//  GainyAPIError.swift
//  GainyAPI
//
//  Created by r10 on 15.02.2023.
//

import Foundation


public enum GainyAPIError: Error {
    case noProfileId, noData, loadError(_ error: Error)
    
    public var localizedDescription: String {
        switch self {
        case .noData:
            return "Request returned no data. It might be a temporary error but if not try again later."
        case .noProfileId:
            return "Seems that you are not logged in. Please check Profile and return."
        case .loadError(let error):
            return error.localizedDescription
            
        }
    }
}

extension GainyAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "Request returned no data. It might be a temporary error but if not try again later."
        case .noProfileId:
            return "Seems that you are not logged in. Please check Profile and return."
        case .loadError(let error):
            return error.localizedDescription
        }
    }
}
