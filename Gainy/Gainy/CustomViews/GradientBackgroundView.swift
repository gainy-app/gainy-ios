//
//  GradientBackgroundView.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/28/21.
//

import UIKit


@IBDesignable class GradientBackgroundView: UIView {
    // implement cgcolorgradient in the next section
    @IBInspectable var startColor: UIColor? {
        didSet { gradientLayer.colors = cgColorGradient; gradientLayer.locations = locations }
    }

    @IBInspectable var middleColor: UIColor? {
        didSet { gradientLayer.colors = cgColorGradient; gradientLayer.locations = locations }
    }
    
    @IBInspectable var endColor: UIColor? {
        didSet { gradientLayer.colors = cgColorGradient; gradientLayer.locations = locations }
    }

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0) {
        didSet { gradientLayer.startPoint = startPoint; gradientLayer.locations = locations }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0) {
        didSet { gradientLayer.endPoint = endPoint; gradientLayer.locations = locations }
    }

    @IBInspectable var middleLocation: Double = Double(0.5) {
        didSet { gradientLayer.locations = locations }
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
}

class GradientRadialView: UIView {
    
    let gradientLayer = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        gradientLayer.locations = [
//            NSNumber(value: 0.6),
//            NSNumber(value: 0.8)
//        ]
        gradientLayer.type = .axial
        gradientLayer.colors = [
            UIColor.green.cgColor,
            UIColor.purple.cgColor,
            UIColor.orange.cgColor,
            UIColor.red.cgColor
        ]
        self.layer.addSublayer(gradientLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [
            NSNumber(value: 0.3),
            NSNumber(value: 0.9)
        ]
        gradientLayer.type = .radial
        gradientLayer.colors = [
            UIColor(hexString: "#FF4BF8")!.withAlphaComponent(0.8).cgColor,
            UIColor.white.withAlphaComponent(0.0).cgColor
        ]
        self.layer.addSublayer(gradientLayer)
        clipsToBounds = false
    }

    override func layoutSublayers(of layer: CALayer) {
        assert(layer === self.layer)
        gradientLayer.frame = layer.bounds
    }
}

extension GradientBackgroundView {
    // For this implementation, both colors are required to display
    // a gradient. You may want to extend cgColorGradient to support
    // other use cases, like gradients with three or more colors.
    internal var cgColorGradient: [CGColor]? {
        guard let startColor = startColor, let middleColor = middleColor, let endColor = endColor else {
            return nil
        }
        
        return [startColor.cgColor, middleColor.cgColor, endColor.cgColor]
    }
    
    internal var locations: [NSNumber]? {
        let midLocation = middleLocation
        return [NSNumber(0.0), NSNumber(floatLiteral: midLocation), NSNumber(1.0)]
    }
}
