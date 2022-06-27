//
//  File.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.02.2022.
//

import UIKit

final class HomeIndexView: CornerView {
    
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
                    growLbl.text = "-"
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
        self.backgroundColor = .clear
        addDashedBorder()
        fillRemoteButtonBack()
        clipsToBounds = true
    }
    
    private var dashLayer: CAShapeLayer?
    func addDashedBorder() {
        guard dashLayer == nil else {return}
        let color = UIColor(hexString: "#B1BDC8")!.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [1, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 16).cgPath
        self.layer.addSublayer(shapeLayer)
        self.dashLayer = shapeLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 16.0
        ).cgPath
        
        dashLayer?.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 16.0
        ).cgPath
    }
}
