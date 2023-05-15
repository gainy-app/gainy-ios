//
//  DiscoverySectionInfo.swift
//  Gainy
//
//  Created by Anton Gubarenko on 09.05.2023.
//

import Foundation
import UIKit

enum DiscoverySectionInfo: Int, Codable, CaseIterable {
    
    case recent, topUp, topDown, bestMatch, banner, bull, flat, bear
    
    var title: String {
        switch self {
        case .recent:
            return "Recently viewed"
        case .topUp:
            return "Top Performers"
        case .topDown:
            return "Top Losers"
        case .bestMatch:
            return "Best Match"
        case .banner:
            return ""
        case .bull:
            return "Growth Scenario"
        case .flat:
            return "Flat Scenario"
        case .bear:
            return "Recession Scenario"
        }
    }
    
    var titleForAMP: String {
        switch self {
        case .recent:
            return "recent"
        case .topUp:
            return "performer"
        case .topDown:
            return "loser"
        case .bestMatch:
            return "match"
        case .banner:
            return ""
        case .bull:
            return "bull"
        case .flat:
            return "flat"
        case .bear:
            return "bear"
        }
    }
    
    var showSorting: Bool {
        switch self {
        case .bull, .flat, .bear:
            return true
        default:
            return false
        }
    }
    
    func weightSortFunc (isAsc: Bool, _ lhs: Float, _ rhs: Float) -> Bool {
        if isAsc {
            return lhs < rhs
        } else {
            return lhs > rhs
        }
    }
    
    var explanationTitle: String {
        switch self {
        case .recent:
            return ""
        case .topUp:
            return ""
        case .topDown:
            return ""
        case .bestMatch:
            return ""
        case .banner:
            return ""
        case .bull:
            return "Growth"
        case .flat:
            return "Flat"
        case .bear:
            return "Recession"
        }
    }
    
    var explanationDescription: String {
        switch self {
        case .recent:
            return ""
        case .topUp:
            return ""
        case .topDown:
            return ""
        case .bestMatch:
            return ""
        case .banner:
            return ""
        case .bull:
            return "Economic recovery and growth improves employment and increases disposable income. People can spend more on expensive items and more readily take loans to finance their purchases. Tech and banking sectors usually profit during the recovery stage."
        case .flat:
            return "This scenario implies that the current economic situation will not change for a while. High inflation and lower real disposable income make consumers to prioritize important purchases like healthcare, utilities and rent. "
        case .bear:
            return "During a recession, consumers struggle to make large purchases and pay out existing loans. Sectors that feel better during recession include those that provide necessary goods and services, aka Consumer Staples. Investors can also profit from investing in inverse ETFs and gold. Historically entertainment and betting have also weathered recessions well. "
        }
    }
    
    var explanationHeight: Float {
    
        let width = UIScreen.main.bounds.width
        let titleTopOffset = 20.0
        let titleEdgeOffset = 28.0
        let descriptionEdgeOffset = 24.0
        let descriptionTopOffset = 16.0
        let bottomOffset = 24.0
        
        let titleWidth = width - titleEdgeOffset * 2.0
        let descriptionWidth = width - descriptionEdgeOffset * 2.0
        
        let title = self.explanationTitle
        let description = self.explanationDescription
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.proDisplaySemibold(20.0)
        titleLabel.textColor = UIColor.init(hexString: "#1F2E35", alpha: 1.0)
        titleLabel.textAlignment = .left
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        let titleSize = self.explanationTitle.heightWithConstrainedWidth(width: titleWidth, font: UIFont.proDisplaySemibold(20.0))
        
        let descriptionTextView = UITextView()
        descriptionTextView.font = UIFont.proDisplayRegular(14.0)
        descriptionTextView.contentInset = .zero
        descriptionTextView.textColor = UIColor(hexString: "#687379")
        descriptionTextView.textAlignment = .left
        descriptionTextView.text = description
        let descriptionSize = self.explanationDescription.heightWithConstrainedWidth(width: descriptionWidth, font: UIFont.proDisplayRegular(14.0))
        
        let height = titleTopOffset + titleSize + descriptionTopOffset + descriptionSize + bottomOffset
        return Float(height)
    }
}
