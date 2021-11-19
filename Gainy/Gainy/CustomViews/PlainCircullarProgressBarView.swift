//
//  PlainCircullarProgressBarView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.11.2021.
//

import Foundation
import UIKit

@IBDesignable
class PlainCircularProgressBar: UIView {
    @IBInspectable var color: UIColor? = UIColor(hexString: "#6C5DD3", alpha: 0.3) {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable var ringWidth: CGFloat = 2

    var progress: CGFloat = 0.3 {
        didSet { setNeedsDisplay() }
    }

    private var trackLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask

        trackLayer.lineWidth = ringWidth
        trackLayer.fillColor = nil
        layer.addSublayer(trackLayer)
        
        progressLayer.lineWidth = ringWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
        
        
    }

    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: ringWidth / 2, dy: ringWidth / 2))
        backgroundMask.path = circlePath.cgPath

        trackLayer.path = circlePath.cgPath
        trackLayer.lineCap = .round
        trackLayer.strokeColor = UIColor(hexString: "#6C5DD3", alpha: 0.3)!.cgColor
        
        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = color?.cgColor
        
        
    }
}

