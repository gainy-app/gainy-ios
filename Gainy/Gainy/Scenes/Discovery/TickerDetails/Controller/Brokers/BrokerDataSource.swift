//
//  PlaidAccountDataSource.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/8/21.
//

import Foundation

struct PlaidAccountData: Codable {
    
    let id: Int
    let institutionID: Int
    let name: String
}

struct PlaidAccountDataSource {
    
    let accountData: PlaidAccountData
    let enabled: Bool
}

enum BrokerData: Int, Codable {
    
    case Robinhood
    case Etrade
    case Ameritrade
    case Public
    case Webull
    case Stash
    case coinbase
    case InteractiveBrokers
    case CharlesSchwab
    case Fidelity
    
    var imageName: String {
        
        var result = ""
        switch self {
        case .Robinhood: result = "Robinhood"
        case .Etrade: result = "Etrade"
        case .Ameritrade: result = "Ameritrade"
        case .Public: result = "Public"
        case .Webull: result = "Webull"
        case .Stash: result = "Stash"
        case .coinbase: result = "coinbase"
        case .InteractiveBrokers: result = "InteractiveBrokers"
        case .CharlesSchwab: result = "Charles Schwab"
        case .Fidelity: result = "Fidelity"
        }
        
        return result
    }
    
    var brokerName: String {
        
        var result = ""
        switch self {
        case .Robinhood: result = "Robinhood"
        case .Etrade: result = "Etrade"
        case .Ameritrade: result = "Ameritrade"
        case .Public: result = "Public"
        case .Webull: result = "Webull"
        case .Stash: result = "Stash"
        case .coinbase: result = "coinbase"
        case .InteractiveBrokers: result = "InteractiveBrokers"
        case .CharlesSchwab: result = "Charles Schwab"
        case .Fidelity: result = "Fidelity"
        }
        
        return result
    }
    
    func brokerURLWithSymbol(symbol: String) -> URL? {
        
        var result: URL?
        switch self {
        case .Robinhood: result = URL.init(string: "https://robinhood.com/applink/instrument/?symbol=" + symbol)
        case .Etrade: result = URL.init(string:"https://us.etrade.com/home")
        case .Ameritrade: result = URL.init(string:"https://www.tdameritrade.com")
        case .Public: result = URL.init(string:"https://public.com/stocks/" + symbol)
        case .Webull: result = URL.init(string:"https://www.webull.com")
        case .Stash: result = URL.init(string:"https://www.stash.com")
        case .coinbase: result = URL.init(string:"https://www.coinbase.com")
        case .InteractiveBrokers: result = URL.init(string:"https://www.interactivebrokers.com")
        case .CharlesSchwab: result = URL.init(string:"https://www.schwab.com")
        case .Fidelity: result = URL.init(string:"https://www.fidelity.com")
        }
        
        return result
    }
}

