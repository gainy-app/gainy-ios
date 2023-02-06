//
//  RectangularDashedView.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 14.11.2022.
//

import UIKit

open class RectangularDashedView: UIView {
    
    @IBInspectable open var cornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable open var dashWidth: CGFloat = 1
    @IBInspectable open var dashColor: UIColor = UIColor(hexString: "#FC5058", alpha: 1.0)!
    @IBInspectable open var dashLength: CGFloat = 0
    @IBInspectable open var betweenDashesSpace: CGFloat = 0
    
    private var dashBorder: CAShapeLayer?
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [1, 3]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}

