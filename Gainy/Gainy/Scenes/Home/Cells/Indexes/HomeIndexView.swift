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
                    valueLbl.text = indexModel.value.zeroDecimalUnsigned
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
        self.backgroundColor = .white
        
        addDashedBorder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 8.0
        ).cgPath
    }
}
