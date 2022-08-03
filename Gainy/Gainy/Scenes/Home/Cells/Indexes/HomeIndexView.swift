//
//  File.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.02.2022.
//

import UIKit

protocol HomeIndexViewDelegate: AnyObject {
    func tickerTapped(symbol: String)
}

final class HomeIndexView: CornerView {
    
    weak var delegate: HomeIndexViewDelegate?
    
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var growImgView: UIImageView!
    @IBOutlet private weak var growLbl: UILabel!
    @IBOutlet private weak var valueLbl: UILabel!
    
    var indexModel: HomeIndexViewModel? {
        didSet {
            if let indexModel = indexModel {
                nameLbl.text = indexModel.name
                if indexModel.grow != 0 {
                growImgView.image = indexModel.grow >= 0.0 ? UIImage(named: "small_up") : UIImage(named: "small_down")
                    growLbl.text = indexModel.grow.percentUnsigned
                growLbl.textColor = UIColor(named: indexModel.grow >= 0.0 ? "mainGreen" : "mainRed")
                } else {
                    growImgView.image = nil
                    growLbl.text = "0.0"
                    growLbl.textColor = .lightGray
                }
                
                if indexModel.value != 0 {
                    valueLbl.text = indexModel.name == "Bitcoin" ? indexModel.value.priceShort : indexModel.value.zeroDecimalUnsigned
                } else {
                    valueLbl.text = "-"
                }
            }
        }
    }
    
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
        delegate?.tickerTapped(symbol: indexModel?.symbol ?? "")
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
        
        // Improve scrolling performance with an explicit shadowPath
//        layer.shadowPath = UIBezierPath(
//            roundedRect: bounds,
//            cornerRadius: 16.0
//        ).cgPath
//
//        dashLayer?.path = UIBezierPath(
//            roundedRect: bounds,
//            cornerRadius: 16.0
//        ).cgPath
//
//        shadowLayer?.shadowPath = UIBezierPath(
//            roundedRect: bounds,
//            cornerRadius: 16.0
//        ).cgPath
        
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
