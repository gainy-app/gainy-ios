//
//  GainyTextField.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/21/21.
//

import UIKit

public class GainyTextField: UITextField {
    open var insets: UIEdgeInsets
    open var overrideHitTest: Bool = false
    
    public override init(frame: CGRect) {
        self.insets = UIEdgeInsets.zero
        super.init(frame: frame)
    }
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
    }

    required init(coder aDecoder: NSCoder) {
        
        self.insets = UIEdgeInsets.zero
        super.init(coder: aDecoder)!
    }

    // placeholder position
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
         return super.textRect(forBounds: bounds.inset(by: insets))
    }
 
    // text position
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return super.editingRect(forBounds: bounds.inset(by: insets))
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.overrideHitTest || self.isFirstResponder {
            return super.hitTest(point, with: event)
        }
        
        return nil
    }
}

extension UITextField {

    public class func textFieldWithInsets(insets: UIEdgeInsets) -> UITextField {
        return GainyTextField(insets: insets)
    }
}
