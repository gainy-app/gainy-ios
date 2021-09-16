//
//  TextInsetsLabel.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/16/21.
//

import UIKit

final class TextInsetsLabel: UILabel {

    public var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        
        didSet {
            self.setNeedsDisplay()
        }
    }

    override func drawText(in rect: CGRect) {
        
        super.drawText(in: rect.inset(by: self.textInsets))
    }
    
}
