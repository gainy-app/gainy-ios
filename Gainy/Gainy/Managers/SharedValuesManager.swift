//
//  SharedValuesManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.01.2023.
//

import Foundation
import GainyAPI

/// Storage for shared Porto gains and other mid-screen data
final class SharedValuesManager {
    
    static let shared = SharedValuesManager()
    
    var homeGains: PortoGains?
    
    var demoPortoGains: PortoGains?
    
    
    func portfolioBalance(forPorto: Bool = false) -> Float? {
        if let demoPortoGains, forPorto {
            return demoPortoGains.actualValue
        } else {
            return homeGains?.actualValue
        }
    }
    
    func rangeGrowFor(_ range: ScatterChartView.ChartPeriod, forPorto: Bool = false) -> Float? {
        if let demoPortoGains, forPorto {
            switch range {
            case .d1:
                return demoPortoGains.relativeGain_1d
            case .w1:
                return demoPortoGains.relativeGain_1w
            case .m1:
                return demoPortoGains.relativeGain_1m
            case .m3:
                return demoPortoGains.relativeGain_3m
            case .y1:
                return demoPortoGains.relativeGain_1y
            case .y5:
                return demoPortoGains.relativeGain_5y
            case .all:
                return demoPortoGains.relativeGainTotal
            }
            
        } else {
            if let homeGains {
                switch range {
                case .d1:
                    return homeGains.relativeGain_1d
                case .w1:
                    return homeGains.relativeGain_1w
                case .m1:
                    return homeGains.relativeGain_1m
                case .m3:
                    return homeGains.relativeGain_3m
                case .y1:
                    return homeGains.relativeGain_1y
                case .y5:
                    return homeGains.relativeGain_5y
                case .all:
                    return homeGains.relativeGainTotal
                }
            }
        }
        return nil
    }
    
    func rangeGrowBalanceFor(_ range: ScatterChartView.ChartPeriod, forPorto: Bool = false) -> Float? {
        if let demoPortoGains, forPorto {
            switch range {
                case .d1:
                    return demoPortoGains.absoluteGain_1d
                case .w1:
                    return demoPortoGains.absoluteGain_1w
                case .m1:
                    return demoPortoGains.absoluteGain_1m
                case .m3:
                    return demoPortoGains.absoluteGain_3m
                case .y1:
                    return demoPortoGains.absoluteGain_1y
                case .y5:
                    return demoPortoGains.absoluteGain_5y
                case .all:
                    return demoPortoGains.absoluteGainTotal
                }
            } else {
            if let homeGains {
                switch range {
                case .d1:
                    return homeGains.absoluteGain_1d
                case .w1:
                    return homeGains.absoluteGain_1w
                case .m1:
                    return homeGains.absoluteGain_1m
                case .m3:
                    return homeGains.absoluteGain_3m
                case .y1:
                    return homeGains.absoluteGain_1y
                case .y5:
                    return homeGains.absoluteGain_5y
                case .all:
                    return homeGains.absoluteGainTotal
                }
            }
        }
        
        return nil
    }
}
