//
//  TickerDetailsMarketDataViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsMarketDataViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 326.0 + 16.0
    
    @IBOutlet weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.allowsMultipleSelection = true
            innerCollectionView.register(UINib.init(nibName: "LongTickerDetailsMarketInnerViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: TickerDetailsMarketInnerViewCell.reuseIdentifier)
            innerCollectionView.isScrollEnabled = false
        }
    }
    
    override func updateFromTickerData() {
        innerCollectionView.reloadData()
        delay(1.0) {[weak innerCollectionView] in
            innerCollectionView?.isScrollEnabled = false
        }
    }
}

extension TickerDetailsMarketDataViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickerInfo?.marketData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TickerDetailsMarketInnerViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TickerDetailsMarketInnerViewCell.reuseIdentifier, for: indexPath) as! TickerDetailsMarketInnerViewCell
//        let cell: TickerDetailsMarketInnerViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.marketData = tickerInfo?.marketData[indexPath.row]
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        cell.isSelected = true
        return cell
    }
}

extension TickerDetailsMarketDataViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: (UIScreen.main.bounds.width - 16.0 * 3.0) / 2.0, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}

final class TickerDetailsMarketInnerViewCell: UICollectionViewCell {
    
    public var highlightSelection: Bool! = false
    
    @IBOutlet private weak var cornerView: CornerView!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var pinImageView: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var periodLbl: UILabel!
    @IBOutlet private weak var valueLbl: UILabel!
    
    func setButtonHidden(isHidden: Bool) {
        
        self.actionButton.isHidden = isHidden
    }
    
    func setSelectionPinHidden(isHidden: Bool) {
        
        self.pinImageView.isHidden = isHidden
    }
    
    var marketData: TickerInfo.MarketData? {
        didSet {
            nameLbl.text = marketData?.name
            periodLbl.text = marketData?.period.uppercased()
            valueLbl.text = marketData?.value
        }
    }
    
    var isForceSelected: Bool = false
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        guard let pinImageView = self.pinImageView else { return }
        guard let cornerView = self.cornerView else { return }
        
        let selected = isForceSelected || isSelected
        
        pinImageView.isHidden = !selected
        
        cornerView.layer.borderWidth = 1.0
        cornerView.layer.borderColor = (selected && highlightSelection) ? UIColor(hexString: "#FC5058", alpha: 1.0)?.cgColor : UIColor.clear.cgColor
        cornerView.backgroundColor = RemoteConfigManager.shared.mainButtonColor
    }
    
    @IBAction func onActionButtonTouchUpInside(_ sender: Any) {
        
        guard let marketData = self.marketData?.marketDataField else {
            return
        }
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: marketData.explanationTitle)
        explanationVc.configureWith(description: marketData.explanationDescription,
                                    linkString: marketData.explanationLinkString,
                                    link: marketData.explanationLink)
        FloatingPanelManager.shared.configureWithHeight(height: CGFloat(marketData.explanationHeight))
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
}
