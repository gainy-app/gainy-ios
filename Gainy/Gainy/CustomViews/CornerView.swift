//
//  CornerView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.08.2021.
//

import UIKit

@IBDesignable
class CornerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    @IBInspectable var cornerRadius: CGFloat = 2.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    fileprivate func setupView() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderColor = UIColor.init(hexString: "#FFFFFF")!.cgColor
        self.layer.borderWidth = self.borderWidth
    }
    
}
