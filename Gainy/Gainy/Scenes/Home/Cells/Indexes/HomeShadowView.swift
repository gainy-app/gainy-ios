//
//  HomeShadowView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 10.08.2022.
//

import UIKit


final class HomeShadowView: CornerView {
    
    var tapCallback: (() -> Void)? = nil
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        isUserInteractionEnabled = true
        self.backgroundColor = .clear
        //addDashedBorder()
        //addShadow()
        fillRemoteButtonBack()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapAction() {
        tapCallback?()
    }
    
    private var dashLayer: CAShapeLayer?
    private var shadowLayer: CAShapeLayer?
    
    func addDashedBorder() {
        guard dashLayer == nil else {return}
        let color = UIColor(hexString: "#B1BDC8")!.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = mainButtonColor.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [1, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 16).cgPath
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.dashLayer = shapeLayer
    }
    
    func addShadow() {
        guard shadowLayer == nil else {return}
        let color = UIColor(hexString: "#B1BDC8")!.cgColor
        
        let shadowLayer:CAShapeLayer = CAShapeLayer()
        
        shadowLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOpacity = 1
        shadowLayer.cornerRadius = 16.0
        shadowLayer.shadowPath = UIBezierPath(rect: bounds).cgPath
        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = UIScreen.main.scale
        self.layer.insertSublayer(shadowLayer, at: 0)
        self.shadowLayer = shadowLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 16.0
        layer.cornerCurve = .continuous
        layer.masksToBounds = true

        layer.cornerRadius = 16.0
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.cornerRadius = 16.0

        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: layer.cornerRadius
        ).cgPath
    }
}
