//
//  UILable+LineHeight.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 30.11.2022.
//

import UIKit

extension UILabel {
    public func setLineHeight(lineHeight: CGFloat, textAlignment: NSTextAlignment, color: UIColor = UIColor.black) {
       
        guard let text = self.text else { return }
        guard let font = self.font else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let styleLineHeight = lineHeight
        let style = NSMutableParagraphStyle()
            style.alignment = textAlignment
            style.maximumLineHeight = styleLineHeight
        style.minimumLineHeight = styleLineHeight
        let range = NSMakeRange(0, text.utf16.count)
        attributeString.addAttribute(.paragraphStyle, value: style, range: range)
        attributeString.addAttribute(.foregroundColor, value: color, range: range)
        attributeString.addAttribute(.font, value: font, range: range)
        
        self.attributedText = attributeString
    }
    
    public func setKern(kern: CGFloat = 1.25, color: UIColor = UIColor.Gainy.mainText!) {
        
        guard let text = self.text else { return }
        guard let font = self.font else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        let range = NSMakeRange(0, text.count)
        attributeString.addAttribute(.kern, value: kern, range: range)
        attributeString.addAttribute(.paragraphStyle, value: style, range: range)
        attributeString.addAttribute(.foregroundColor, value: color, range: range)
        attributeString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributeString
    }
}

