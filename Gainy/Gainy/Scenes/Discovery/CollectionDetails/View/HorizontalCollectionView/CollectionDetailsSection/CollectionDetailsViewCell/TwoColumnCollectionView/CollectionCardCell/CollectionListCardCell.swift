//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView

final class CollectionListCardCell: UICollectionViewCell {
    

    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var symbolLbl: UILabel!
    @IBOutlet private weak var priceLbl: UILabel!
    
    @IBOutlet weak var matchView: UIView!{
        didSet {
            matchView.layer.cornerRadius = 12
            matchView.clipsToBounds = true
        }
    }
    @IBOutlet weak var matchCircleImgView: UIImageView! {
        didSet {
            matchCircleImgView.backgroundColor = .clear
            matchCircleImgView.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
            matchCircleImgView.tintColor = .white
        }
    }
    
    @IBOutlet private weak var growthLbl: UILabel!
    @IBOutlet private weak var yieldLbl: UILabel!
    @IBOutlet private weak var peLbl: UILabel!
    @IBOutlet private weak var marketLbl: UILabel!
    @IBOutlet private weak var mlpLbl: UILabel!
    
    func configureWith(
        companyName: String,
        tickerSymbol: String,
        tickerPercentChange: String,
        tickerPrice: String,
        markerHeaders: [String],
        markerMetrics: [String],
        matchScore: String
    ) {
        nameLbl.text = companyName

        symbolLbl.text = tickerSymbol

        if companyName.hasPrefix(Constants.CollectionDetails.demoNamePrefix) || tickerPrice.isEmpty {
            priceLbl.text = ""
        } else {
            priceLbl.text = "$\(tickerPrice)"
        }
        priceLbl.textColor = tickerPercentChange.hasPrefix(" +")
            ? UIColor.Gainy.green
            : UIColor.Gainy.red

        let lbls = [growthLbl, yieldLbl, peLbl, marketLbl, mlpLbl]
        
        for (ind, val) in markerMetrics.enumerated() {
            lbls[ind]?.text = val
        }
        if markerHeaders.first == "Match\nScore" {
            let matchVal = Int(markerMetrics.first ?? "0") ?? 0
            switch matchVal {
            case 0..<55:
                matchView.backgroundColor = UIColor.Gainy.mainRed
                break
            case 55..<75:
                matchView.backgroundColor = UIColor.Gainy.mainYellow
                break
            case 75...:
                matchView.backgroundColor = UIColor.Gainy.mainGreen
                break
            default:
                break
            }
            matchView.isHidden = false
            growthLbl.textColor = .white
        } else {
            matchView.isHidden = true
            growthLbl.textColor = UIColor(named: "mainText")
        }
        
        layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        [nameLbl, symbolLbl, priceLbl, growthLbl, yieldLbl, peLbl, marketLbl, mlpLbl].forEach({
            $0?.isSkeletonable = true
            $0?.linesCornerRadius = 6
            $0?.numberOfLines = 1
        })
    }
}
