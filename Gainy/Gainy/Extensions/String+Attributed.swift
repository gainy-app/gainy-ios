//
//  String+Attributed.swift
//  Gainy
//
//  Created by Anton Gubarenko on 24.11.2021.
//

import UIKit

extension String {
    func attr(font: UIFont = .compactRoundedRegular(), color: UIColor = UIColor(hexString: "1E252B")!) -> NSAttributedString {
        let body = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor : color])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        body.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, body.length))
        
        return body
    }
    
    func mutableAttr(font: UIFont = .compactRoundedRegular(14.0), color: UIColor = UIColor(hexString: "1E252B")!) -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self.attr(font: font, color: color))
    }
    
    func withLineSpacing(_ spacing: CGFloat = 16.0) {
        let attributedString = NSMutableAttributedString(string: self)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = spacing // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        return attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
    }
    
    func height(containerWidth: CGFloat) -> CGFloat {
        
        let rect = self.boundingRect(with: CGSize.init(width: containerWidth, height: CGFloat.greatestFiniteMagnitude),
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil)
        return ceil(rect.size.height)
    }
}

extension NSAttributedString {
    static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
        let merged = NSMutableAttributedString.init(attributedString: lhs)
        merged.append(rhs)
        return merged
    }
}
