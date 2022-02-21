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
                growImgView.image = indexModel.grow >= 0.0 ? UIImage(named: "small_up") : UIImage(named: "small_down")
                growLbl.text = indexModel.grow.percent
                growLbl.textColor = UIColor(named: indexModel.grow >= 0.0 ? "mainGreen" : "mainRed")
                valueLbl.text = indexModel.value.cleanTwoDecimal
            }
        }
    }
}