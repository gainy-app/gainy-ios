//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

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
    @IBOutlet weak var matchTrailing: NSLayoutConstraint!
    @IBOutlet weak var separatorTrailing: NSLayoutConstraint!
    
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
        lbls.forEach({$0?.textColor = UIColor(named: "mainText")})
        
        mlpLbl.textColor = UIColor(named: "mainText")
        let matchVal = Int(matchScore) ?? 0
        switch matchVal {
        case 0..<35:
            matchView.backgroundColor = UIColor.Gainy.mainRed
            break
        case 35..<65:
            matchView.backgroundColor = UIColor.Gainy.mainYellow
            break
        case 65...:
            matchView.backgroundColor = UIColor.Gainy.mainGreen
            break
        default:
            break
        }
        mlpLbl.font = .compactRoundedSemibold(14.0)
        
        if markerHeaders.first == Constants.CollectionDetails.matchScore || markerHeaders.contains(where: {$0 == Constants.CollectionDetails.matchScore}) {
            
            if markerHeaders.first == Constants.CollectionDetails.matchScore {
                for (ind, val) in markerMetrics.enumerated() {
                    lbls.reversed()[ind]?.text = val
                }
                matchTrailing.constant = 34.0
                mlpLbl.textColor = .white
                mlpLbl.font = .compactRoundedSemibold(12.0)
            } else {
                for (ind, val) in markerMetrics.enumerated() {
                    lbls[ind]?.text = val
                    
                    if (markerHeaders[ind] == Constants.CollectionDetails.matchScore) {
                        matchTrailing.constant = CGFloat(5 - ind) * 48.0 - 4.0 - 22.0 + 12.0
                        lbls[ind]?.textColor = .white
                        lbls[ind]?.font = .compactRoundedSemibold(12.0)
                    }
                }
            }
            matchView.isHidden = false
            separatorTrailing.constant = 56
        } else {
            for (ind, val) in markerMetrics.enumerated() {
                lbls[ind]?.text = val
            }
            matchView.isHidden = true
            mlpLbl.textColor = UIColor(named: "mainText")
            separatorTrailing.constant = 0
        }
        
        layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.removeConstraints(matchView.constraints)
        [nameLbl, symbolLbl, priceLbl, growthLbl, yieldLbl, peLbl, marketLbl, mlpLbl].forEach({
            $0?.isSkeletonable = true
            $0?.linesCornerRadius = 6
            $0?.numberOfLines = 1
        })
    }
}
