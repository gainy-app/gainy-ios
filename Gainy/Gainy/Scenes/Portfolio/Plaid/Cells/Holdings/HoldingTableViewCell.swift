//
//  HoldingTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit
import PureLayout
import Deviice
import GainyCommon

protocol HoldingTableViewCellDelegate: AnyObject {
    func requestOpenCollection(withID id: Int)
}

final class HoldingTableViewCell: HoldingRangeableCell {
    
    public weak var delegate: HoldingTableViewCellDelegate?
    
    static let heightWithoutEvents: CGFloat = 136.0 + 16.0
    static let heightWithEvents: CGFloat = 136.0 + 16.0
    
    //MARK: - Outlet
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var amountLbl: UILabel!
    @IBOutlet private weak var symbolLbl: UILabel!
    
    @IBOutlet weak var matchCircleView: UIView!
    @IBOutlet weak var matchCircleImgView: UIImageView! {
        didSet {
            matchCircleImgView.backgroundColor = .clear
        }
    }
    @IBOutlet private weak var matchScoreLbl: UILabel!
    @IBOutlet private weak var lttView: CornerView!
    @IBOutlet private weak var categoriesView: UIView!
    
    @IBOutlet private weak var expandBtn: UIButton!
    @IBOutlet private weak var tagsExpandBtn: UIButton!
    @IBOutlet private weak var shadowView: CornerView! {
        didSet {
            shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            shadowView.layer.shadowOpacity = 0
            shadowView.layer.shadowRadius = 4
            shadowView.layer.shadowOffset = .zero
            shadowView.layer.shouldRasterize = true
            shadowView.layer.rasterizationScale = UIScreen.main.scale
            //            var bounds = shadowView.bounds
            //            bounds.size = CGSize.init(width: UIScreen.main.bounds.width - 16.0 * 2.0, height: bounds.height)
            //            shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }
    @IBOutlet private weak var holdingProgressView: PlainCircularProgressBar!
    @IBOutlet private weak var holdingProgressLbl: UILabel!
    @IBOutlet private weak var avgArrowView: UIImageView!
    @IBOutlet private weak var avgPriceLbl: UILabel!
    @IBOutlet private weak var avgGrowLbl: UILabel!
    @IBOutlet private var dots: [UIImageView]!
    @IBOutlet private weak var secsTopMargin: NSLayoutConstraint!
    
    @IBOutlet private weak var rangeArrowView: UIImageView!
    @IBOutlet private weak var rangeNameLbl: UILabel!
    @IBOutlet private weak var rangePriceLbl: UILabel!
    
    @IBOutlet private weak var eventsView: RectangularDashedView!
    @IBOutlet private weak var rangeGrowLbl: UILabel!
    @IBOutlet private weak var eventLbl: UILabel!
    
    
    @IBOutlet private weak var transactionsTotalLbl: UILabel!
    @IBOutlet private weak var securitiesTableView: UITableView! {
        didSet {
            securitiesTableView.dataSource = self
            securitiesTableView.isScrollEnabled = false
        }
    }
    @IBOutlet private weak var secTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tagsHeight: NSLayoutConstraint!
    
    //private var lines: Int = 1
    
    private let tagHeight: CGFloat = 24.0
    
    enum SecMargin: CGFloat {
        case cash = 56.0
        case normal = 128.0
    }
    
    func setModel(_ model: HoldingViewModel, _ range: ScatterChartView.ChartPeriod, isTagExpanded: Bool) {
        holding = model
        chartRange = range
        
        //Setting properties
        nameLbl.text = model.name
        eventsView.isHidden = true
        if let event = model.event {
            var eventDate = Date()
            if let zDate = event.toDate("yyyy-MM-dd'T'HH:mm:ssZ")?.date {
                eventDate = zDate
            } else {
                eventDate = event.toDate("yyyy-MM-dd'T'HH:mm:ss")?.date ?? Date()
            }
            eventLbl.text = "Earnings date • " + eventDate.toFormat("MMM dd, yy")
        }
        
        matchScoreLbl.textColor = UIColor.Gainy.mainText
        if let matchScore = TickerLiveStorage.shared.getMatchData(model.tickerSymbol)?.matchScore {
            let matchVal = Int(matchScore)
            matchCircleView.backgroundColor = MatchScoreManager.circleColorFor(matchVal)
            matchScoreLbl.text = "\(matchScore)"
            if !UserProfileManager.shared.isOnboarded {
                matchScoreLbl.text = "?"
            }
        } else {
            if UserProfileManager.shared.isOnboarded {
                if model.matchScore > 0 {
                    matchCircleView.backgroundColor = MatchScoreManager.circleColorFor(model.matchScore)
                    matchScoreLbl.text = "\(model.matchScore)"
                } else {
                    matchScoreLbl.text = "-"
                }
            } else {
                matchScoreLbl.text = "?"
                matchCircleView.backgroundColor = MatchScoreManager.circleColorFor(100)
            }
        }
        amountLbl.text = model.balance.price
        symbolLbl.text = model.tickerSymbol.cryptoRemoved
        symbolLbl.isHidden = false
        symbolLbl.superview?.isHidden = false
        
        categoriesView.subviews.forEach({$0.removeFromSuperview()})
        categoriesView.backgroundColor = .white
        
        //Tags
        let margin: CGFloat = 8.0
        
        let totalWidth: CGFloat = UIScreen.main.bounds.width - 32.0 - 94.0
        var xPos: CGFloat = 0.0
        var yPos: CGFloat = 0.0
        var lines: Int = 1
        if Deviice.current.type == .iPhone7 {
            categoriesView.clipsToBounds = false
        } else {
            categoriesView.clipsToBounds = false
        }
        categoriesView.backgroundColor = .clear
        for tag in model.tickerTags {
            let tagView = TagView()
            tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                              for: .touchUpInside)
            categoriesView.addSubview(tagView)
            
            tagView.backgroundColor = .clear
            tagView.tagLabel.textColor = UIColor(named: "mainText")
            
            tagView.collectionID = (tag.collectionID > 0) ? tag.collectionID : nil
            tagView.tagName = tag.name
            tagView.loadImage(url: tag.url)
            let width = min(totalWidth, (tag.url.isEmpty ? 8.0 : 26.0) + tag.name.uppercased().widthOfString(usingFont: UIFont.compactRoundedSemibold(12)) + (tag.url.isEmpty ? margin + 4.0 : margin))
            tagView.autoSetDimensions(to: CGSize.init(width: width, height: tagHeight))
            if xPos + width + margin > totalWidth && categoriesView.subviews.count > 1 {
//                xPos = 0.0
//                yPos = yPos + tagHeight + margin
//                lines += 1
                tagView.removeFromSuperview()
                break
            }
            tagView.autoPinEdge(.leading, to: .leading, of: categoriesView, withOffset: xPos)
            tagView.autoPinEdge(.top, to: .top, of: categoriesView, withOffset: yPos)
            xPos += width + margin
            
            if tag.collectionID != Constants.CollectionDetails.noCollectionId {
                tagView.setBorderForCollection()
            } else {
                tagView.setBorderForTicker()
            }
        }
        
        if isTagExpanded {
            self.tagsHeight?.constant = tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
        } else {
            if lines <= 2 {
                self.tagsHeight?.constant = tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
            } else {
                if isTagExpanded {
                    self.tagsHeight?.constant = tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
                } else {
                    self.tagsHeight?.constant = tagHeight * CGFloat(2) + margin * CGFloat(1)
                }
            }
        }
        self.categoriesView.layoutIfNeeded()
        
        //Tags expand
        if lines <= 2 {
            tagsExpandBtn.isHidden = true
        } else {
            tagsExpandBtn.isHidden = false
        }
        expandBtn.isHidden = true
        
        lttView.isHidden = true
        
        //Prices
        if let curPrice = TickerLiveStorage.shared.getSymbolData(model.tickerSymbol) {
                (avgPriceLbl.text, avgArrowView.image, avgGrowLbl.text, avgGrowLbl.textColor) = (curPrice.currentPrice.price,
                                                                                             UIImage(named: curPrice.priceChangeToday >= 0.0 ?  "small_up" : "small_down")!,
                                                                                             (curPrice.priceChangeToday * 100.0).cleanTwoDecimalP.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: ""),
                                                                                             curPrice.priceChangeToday >= 0.0 ? UIColor(named: "mainGreen") :  UIColor(named: "mainRed"))
            dprint("Set \(curPrice.currentPrice) - \(curPrice.priceChangeToday) for \(model.tickerSymbol)")
            dots.forEach({$0.isHidden = false})
        } else {
            (avgPriceLbl.text, avgArrowView.image, avgGrowLbl.text) = ("", nil, "")
            dots.forEach({$0.isHidden = true})
        }
        (rangeNameLbl.text, rangeArrowView.image, rangePriceLbl.text, rangeGrowLbl.text, rangePriceLbl.textColor, rangeGrowLbl.textColor) = model.infoForRange(chartRange)
        
        //Footer
        holdingProgressView.progress = CGFloat(model.percentInProfile / 100.0)
        holdingProgressLbl.text = (model.percentInProfile).cleanOneDecimalP
        //transactionsTotalLbl.text = model.securities.map({"\($0.name)x\($0.quantity)"}).joined(separator: " ")
        
        if model.securities.isEmpty {
            expandBtn.isHidden = true
            transactionsTotalLbl.attributedText =  "No transactions".attr(font: .compactRoundedSemibold(14.0), color: .init(hexString: "B1BDC8", alpha: 1.0)!)
            secTableHeight.constant = 0.0
        } else {
            if lines <= 2 {
                expandBtn.isHidden = true
            } else {
                expandBtn.isHidden = false
            }
            transactionsTotalLbl.attributedText = model.holdingsCount
            secTableHeight.constant = Double(model.securities.count) * 80.0 + Double(model.securities.count - 1) * 8.0
        }
        securitiesTableView.reloadData()
        securitiesTableView.isHidden = true
        transactionsTotalLbl.isHidden = true
        
        if model.isCash {
            matchCircleView.backgroundColor = UIColor(hexString: "B1BDC8", alpha: 1.0)
            matchScoreLbl.text = "$"
            nameLbl.text = "Cash Balance"
            
            symbolLbl.isHidden = true
            symbolLbl.superview?.isHidden = true
            secsTopMargin.constant = SecMargin.cash.rawValue
            transactionsTotalLbl.isHidden = true
            categoriesView.isHidden = true
        } else {
            if model.isCrypto {
                matchCircleView.backgroundColor = UIColor(hexString: "0062FF", alpha: 1.0)
                matchScoreLbl.text = "C"
                matchScoreLbl.textColor = .white
                matchCircleImgView.image = UIImage(named: "match_circle_white")
                
                secsTopMargin.constant = SecMargin.normal.rawValue + model.tagsHeight(isExpanded: isTagExpanded)
                transactionsTotalLbl.isHidden = false
                categoriesView.isHidden = false
            } else {
                secsTopMargin.constant = SecMargin.normal.rawValue + model.tagsHeight(isExpanded: isTagExpanded)
                transactionsTotalLbl.isHidden = false
                categoriesView.isHidden = false
            }
        }
        transactionsTotalLbl.isHidden = true
        expandBtn.isHidden = true
        avgArrowView.isHidden = true
        avgPriceLbl.isHidden = true
        avgGrowLbl.isHidden = true
        layoutIfNeeded()
    }
    
    private var holding: HoldingViewModel?
    private var chartRange: ScatterChartView.ChartPeriod = .d1
    
    var isExpanded: Bool = false {
        didSet {
            expandBtn.isSelected = isExpanded
            securitiesTableView.isHidden = !isExpanded
            if let holding = holding {
                if isExpanded {
                    transactionsTotalLbl.attributedText = (holding.isCrypto ? "Coins" : "All positions").attr(font: .compactRoundedSemibold(14.0), color: .init(hexString: "B1BDC8", alpha: 1.0)!)
                } else {
                    transactionsTotalLbl.attributedText = holding.holdingsCount
                }
            }
        }
    }
    
    var isTagExpanded: Bool = false {
        didSet {
            tagsExpandBtn.isSelected = isTagExpanded
            if let holding = holding, !holding.isCash {
                tagsHeight?.constant = tagHeight  + holding.tagsHeight(isExpanded: isTagExpanded)
                secsTopMargin.constant = SecMargin.normal.rawValue + holding.tagsHeight(isExpanded: isTagExpanded)
                layoutIfNeeded()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    //MARK: - Actions
    
    @IBAction func toggleExpandAction(_ sender: Any) {
        
        isExpanded.toggle()
        
        if isExpanded {
            GainyAnalytics.logEvent("portfolio_pl_hld_det_expanded")
        } else {
            GainyAnalytics.logEvent("portfolio_pl_hld_det_collapsed")
        }
        if let holding = holding {
            cellHeightChanged?(holding)
        }
    }
    
    @IBAction func toggleTagsExpandAction(_ sender: Any) {
        
        isTagExpanded.toggle()
        
        if isTagExpanded {
            GainyAnalytics.logEvent("portfolio_pl_tag_det_expanded")
        } else {
            GainyAnalytics.logEvent("portfolio_pl_tag_det_collapsed")
        }
                    
        if let holding = holding {
            self.tagsHeight?.constant = tagHeight  + holding.tagsHeight(isExpanded: isTagExpanded)
            self.categoriesView.layoutIfNeeded()
            cellTagExpanded?(holding)
        }
    }
    
    @objc func tagViewTouchUpInside(_ tagView: TagView) {
        guard let collectionID = tagView.collectionID, collectionID > 0 else {
            return
        }
        
        self.delegate?.requestOpenCollection(withID: collectionID);
    }
    
    private func showExplanationWith(title: String, description: String, height: CGFloat, linkText: String? = nil, link: String? = nil) {
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: title)
        explanationVc.configureWith(description: description, linkString: linkText, link: link)
        FloatingPanelManager.shared.configureWithHeight(height: height)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
    
}

extension HoldingTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        holding?.securities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HoldingSecurityTableViewCell = tableView.dequeueReusableCell(withIdentifier: (holding?.isCash ?? false) ? HoldingSecurityTableViewCell.cashCellIdentifier : HoldingSecurityTableViewCell.cellIdentifier, for: indexPath) as! HoldingSecurityTableViewCell
        if let security = holding?.securities[indexPath.row] {
            cell.setModel(security, chartRange)
        }
        return cell
    }
}
