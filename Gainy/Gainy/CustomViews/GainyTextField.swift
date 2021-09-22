//
//  GainyTextField.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/21/21.
//

import UIKit

final class GainyTextField: UITextField {
    var insets: UIEdgeInsets

    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
    }

    required init(coder aDecoder: NSCoder) {
        
        self.insets = UIEdgeInsets.zero
        super.init(coder: aDecoder)!        
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
         return super.textRect(forBounds: bounds.inset(by: insets))
    }
 
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return super.editingRect(forBounds: bounds.inset(by: insets))
    }
}

extension UITextField {

    class func textFieldWithInsets(insets: UIEdgeInsets) -> UITextField {
        return GainyTextField(insets: insets)
    }

}
