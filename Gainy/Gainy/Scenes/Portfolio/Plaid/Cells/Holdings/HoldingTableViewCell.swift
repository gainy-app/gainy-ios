//
//  HoldingTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit
import PureLayout

protocol HoldingTableViewCellDelegate: AnyObject {
    func requestOpenCollection(withID id: Int)
}

final class HoldingTableViewCell: HoldingRangeableCell {
    
    public weak var delegate: HoldingTableViewCellDelegate?
    
    static let heightWithoutEvents: CGFloat = 252.0
    static let heightWithEvents: CGFloat = 252.0
    
    //MARK: - Outlet
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    
    @IBOutlet weak var matchCircleView: UIView!
    @IBOutlet weak var matchCircleImgView: UIImageView! {
        didSet {
            matchCircleImgView.backgroundColor = .clear
            matchCircleImgView.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
            matchCircleImgView.tintColor = .white
        }
    }
    @IBOutlet weak var matchScoreLbl: UILabel!
    @IBOutlet weak var lttView: CornerView!
    @IBOutlet weak var categoriesView: UIView!
    
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var shadowView: CornerView! {
        didSet {
            shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            shadowView.layer.shadowOpacity = 1
            shadowView.layer.shadowRadius = 4
            shadowView.layer.shadowOffset = .zero
            shadowView.layer.shouldRasterize = true
            shadowView.layer.rasterizationScale = UIScreen.main.scale
            //            var bounds = shadowView.bounds
            //            bounds.size = CGSize.init(width: UIScreen.main.bounds.width - 16.0 * 2.0, height: bounds.height)
            //            shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }
    @IBOutlet weak var holdingProgressView: PlainCircularProgressBar!
    @IBOutlet weak var holdingProgressLbl: UILabel!
    @IBOutlet weak var avgArrowView: UIImageView!
    @IBOutlet weak var avgPriceLbl: UILabel!
    @IBOutlet weak var avgGrowLbl: UILabel!
    @IBOutlet var dots: [UIImageView]!
    @IBOutlet weak var secsTopMargin: NSLayoutConstraint!
    
    @IBOutlet weak var rangeArrowView: UIImageView!
    @IBOutlet weak var rangeNameLbl: UILabel!
    @IBOutlet weak var rangePriceLbl: UILabel!
    
    @IBOutlet weak var eventsView: RectangularDashedView!
    @IBOutlet weak var rangeGrowLbl: UILabel!
    @IBOutlet weak var eventLbl: UILabel!
    
    
    @IBOutlet weak var transactionsTotalLbl: UILabel!
    @IBOutlet weak var securitiesTableView: UITableView! {
        didSet {
            securitiesTableView.dataSource = self
            securitiesTableView.isScrollEnabled = false
        }
    }
    @IBOutlet weak var secTableHeight: NSLayoutConstraint!
    
    func setModel(_ model: HoldingViewModel, _ range: ScatterChartView.ChartPeriod) {
        holding = model
        chartRange = range
        
        //Setting properties
        nameLbl.text = model.name
        eventsView.isHidden = model.event == nil
        if let event = model.event {
            var eventDate = Date()
            if let zDate = event.toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date {
                eventDate = zDate
            } else {
                eventDate = event.toDate("yyy-MM-dd'T'HH:mm:ss")?.date ?? Date()
            }
            eventLbl.text = "Earnings date • " + eventDate.toFormat("MMM dd, yy")
        }
        
        matchScoreLbl.textColor = .white
        if let matchScore = TickerLiveStorage.shared.getMatchData(model.tickerSymbol)?.matchScore {
            let matchVal = Int(matchScore)
            matchScoreLbl.backgroundColor = MatchScoreManager.circleColorFor(matchVal)
            matchScoreLbl.text = "\(matchScore)"
        } else {
            matchScoreLbl.text = "-"
        }
        amountLbl.text = model.balance.price
        symbolLbl.text = model.tickerSymbol
        symbolLbl.isHidden = false
        symbolLbl.superview?.isHidden = false
        
        categoriesView.subviews.forEach({$0.removeFromSuperview()})
        
        //Tags
        
        let industries = model.industries.compactMap({TickerTag.init(name:$0.gainyIndustry?.name ?? "",
                                                                     url: "", collectionID: $0.gainyIndustry?.collectionId ?? -404,
                                                                     id: $0.gainyIndustry?.id ?? -1)  })
        let categories = model.categories.compactMap({TickerTag.init(name: $0.categories?.name ?? "", url: $0.categories?.iconUrl ?? "", collectionID: $0.categories?.collectionId ?? -404,
                                                                     id: $0.categories?.id ?? -1)})
        let tags = categories + industries
        
        
        let tagHeight: CGFloat = 24.0
        let margin: CGFloat = 8.0
        
        let totalWidth: CGFloat = UIScreen.main.bounds.width - 81.0 - 32.0
        var xPos: CGFloat = 0.0
        
        for tag in tags {
            let tagView = TagView()
            tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                              for: .touchUpInside)
            categoriesView.addSubview(tagView)
            
            tagView.backgroundColor = UIColor.white
            tagView.tagLabel.textColor = UIColor(named: "mainText")
            
            tagView.collectionID = (tag.collectionID > 0) ? tag.collectionID : nil
            tagView.tagName = tag.name
            tagView.loadImage(url: tag.url)
            let width = (tag.url.isEmpty ? 8.0 : 26.0) + tag.name.uppercased().widthOfString(usingFont: UIFont.compactRoundedSemibold(12)) + margin
            tagView.autoSetDimensions(to: CGSize.init(width: width, height: tagHeight))
            if xPos + width + margin > totalWidth && categoriesView.subviews.count > 0 {
                tagView.removeFromSuperview()
                break
            }
            tagView.autoPinEdge(.leading, to: .leading, of: categoriesView, withOffset: xPos)
            tagView.autoPinEdge(.top, to: .top, of: categoriesView, withOffset: 0)
            xPos += width + margin
        }
        
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
        transactionsTotalLbl.text = model.securities.map({"\($0.name)x\($0.quantity)"}).joined(separator: " ")
        
        if model.securities.isEmpty {
            expandBtn.isHidden = true
            transactionsTotalLbl.attributedText =  "No transactions".attr(font: .compactRoundedSemibold(14.0), color: .init(hexString: "B1BDC8", alpha: 1.0)!)
            secTableHeight.constant = 0.0
        } else {
            expandBtn.isHidden = false
            transactionsTotalLbl.attributedText = model.holdingsCount
            secTableHeight.constant = Double(model.securities.count) * 80.0 + Double(model.securities.count - 1) * 8.0
        }
        securitiesTableView.reloadData()
        
        if model.isCash {
            matchCircleView.backgroundColor = UIColor(hexString: "B1BDC8", alpha: 1.0)
            matchScoreLbl.text = "$"
            nameLbl.text = "Cash Balance"
            
            symbolLbl.isHidden = true
            symbolLbl.superview?.isHidden = true
            secsTopMargin.constant = 56.0
            transactionsTotalLbl.isHidden = true
            categoriesView.isHidden = true
        } else {
            if model.isCrypto {
                matchCircleView.backgroundColor = UIColor(hexString: "0062FF", alpha: 1.0)
                matchScoreLbl.text = "B"
                nameLbl.text = "Crypto Currencies"
                
                symbolLbl.isHidden = true
                symbolLbl.superview?.isHidden = true
                secsTopMargin.constant = 56.0
                transactionsTotalLbl.isHidden = true
                categoriesView.isHidden = true
            } else {
                secsTopMargin.constant = 128.0
                transactionsTotalLbl.isHidden = false
                categoriesView.isHidden = false
            }
        }
    }
    
    private var holding: HoldingViewModel?
    private var chartRange: ScatterChartView.ChartPeriod = .d1
    
    var isExpanded: Bool = false {
        didSet {
            expandBtn.isSelected = isExpanded
            securitiesTableView.isHidden = !isExpanded
            if let holding = holding {
                if isExpanded {
                    transactionsTotalLbl.attributedText = "All positions".attr(font: .compactRoundedSemibold(14.0), color: .init(hexString: "B1BDC8", alpha: 1.0)!)
                } else {
                    transactionsTotalLbl.attributedText = holding.holdingsCount
                }
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
        let cell: HoldingSecurityTableViewCell = tableView.dequeueReusableCell(withIdentifier: ((holding?.isCash ?? false) || (holding?.isCrypto ?? false)) ? HoldingSecurityTableViewCell.cashCellIdentifier : HoldingSecurityTableViewCell.cellIdentifier, for: indexPath) as! HoldingSecurityTableViewCell
        if let security = holding?.securities[indexPath.row] {
            cell.setModel(security, chartRange)
        }
        return cell
    }
}
