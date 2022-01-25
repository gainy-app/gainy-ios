//
//  String+Attributed.swift
//  Gainy
//
//  Created by Anton Gubarenko on 24.11.2021.
//

import UIKit

extension String {
    func attr(font: UIFont = .compactRoundedRegular(), color: UIColor = UIColor(hexString: "1E252B")!, lineHeight: CGFloat? = nil) -> NSAttributedString {
        let body = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor : color])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        if let lineHeight = lineHeight {
            paragraphStyle.lineSpacing = lineHeight
        }
        
        body.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, body.length))
        
        return body
    }
    
    func mutableAttr(font: UIFont = .compactRoundedRegular(14.0), color: UIColor = UIColor(hexString: "1E252B")!) -> NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self.attr(font: font, color: color))
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
    
        func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
            let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

            return boundingBox.height
        }
}
