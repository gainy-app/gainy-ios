//
//  CategoriesTipsGenerator.swift
//  Gainy
//
//  Created by Anton Gubarenko on 21.11.2021.
//

import UIKit

struct CategoriesTipsGenerator {
    
    /// Generating info for tag name
    /// - Parameter name: Tag name
    static func getInfoForPanel(_ name: String) -> (title: String, description: String, height: CGFloat){
        var title = NSLocalizedString("Title", comment: "title")
        var description = NSLocalizedString("Description", comment: "description")
        var height: CGFloat = CGFloat(135.0)
        
        let nameLowercased = name.lowercased()
        if nameLowercased.contains("Defensive".lowercased()) {
            title = NSLocalizedString("Defensive", comment: "Defensive")
            description = NSLocalizedString("Defensive - a historically calculated metric of stocks that provide consistent dividends and stable earnings regardless of the state of the overall stock market.", comment: "Defensive desc")
            height = 145.0
            
        } else if nameLowercased.contains("Speculation".lowercased()) || nameLowercased.contains("Speculative".lowercased()) {
            title = NSLocalizedString("Speculation", comment: "Speculation")
            description = NSLocalizedString("A speculative stock is a stock that a trader uses to speculate. The fundamentals of the stock do not show an apparent strength or sustainable business model, leading it to be viewed as very risky and trade at a comparatively low price, although the trader is hopeful that this will one day change.", comment: "Speculation desc")
            height = 185.0
        } else if nameLowercased.contains("Penny".lowercased()) {
            title = NSLocalizedString("Penny", comment: "Penny")
            description = NSLocalizedString("A penny stock typically refers to a small company's stock that trades for less than $5 per share.", comment: "Penny desc")
            height = 135.0
        } else if nameLowercased.contains("Dividend".lowercased()) {
            title = NSLocalizedString("Dividend", comment: "Dividend")
            description = NSLocalizedString("It is usually a more stable but with a slower growth company. Dividend stocks are companies that pay out regular dividends.", comment: "Dividend desc")
            height = 145.0
        } else if nameLowercased.contains("Momentum".lowercased()) {
            title = NSLocalizedString("Momentum", comment: "Momentum")
            description = NSLocalizedString("Momentum stocks is simply the stocks that are yielding higher returns over the past three, six, or 12 months than the S&P 500. They currently perform better than their peers but might have potential downside trend when the momentum is over. ", comment: "Momentum desc")
            height = 175.0
        } else if nameLowercased.contains("Value".lowercased()) {
            title = NSLocalizedString("Value", comment: "Value")
            description = NSLocalizedString("A value stock is one that is cheap in relation to such basic measures of corporate performance as earnings, sales, book value and cash flow.", comment: "Value desc")
            height = 145.0
        } else if nameLowercased.contains("Growth".lowercased()) {
            title = NSLocalizedString("Growth", comment: "Growth")
            description = NSLocalizedString("A growth stock is any share in a company that is anticipated to grow at a rate significantly above the average growth for the market.", comment: "Growth desc")
            height = 145.0
        } else {
            // Not a category
            return ("", "", 0.0)
        }
        return (title, description, height)
    }
}
