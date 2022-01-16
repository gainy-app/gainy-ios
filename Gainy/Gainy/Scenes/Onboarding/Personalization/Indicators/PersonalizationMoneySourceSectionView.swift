//
//  PersonalizationTitlePickerSectionView.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/6/21.
//

import UIKit
import PureLayout

enum PersonalizationInfoValue: Int {
    
    case market_return_6
    case market_return_15
    case market_return_25
    case market_return_50
    case checking_savings
    case stock_investments
    case credit_card
    case other_loans
    case never_tried
    case very_little
    case companies_i_believe_in
    case etfs_and_safe_stocks
    case advanced
    case daily_trader
    case investment_funds
    case professional
    case dont_trade_after_bad_experience
    
    func description() -> String {
        switch self {
            
        case .market_return_6: return NSLocalizedString ("6%", comment: "6%")
        case .market_return_15: return NSLocalizedString("15%", comment: "15%")
        case .market_return_25: return NSLocalizedString("25%", comment: "25%")
        case .market_return_50: return NSLocalizedString("50%", comment: "50%")
        case .checking_savings: return NSLocalizedString("Checking/savings", comment: "Checking/savings")
        case .stock_investments: return NSLocalizedString("Stock investments", comment: "Stock investments")
        case .credit_card: return NSLocalizedString("Credit card", comment: "Credit card")
        case .other_loans: return NSLocalizedString("Other loans", comment: "Other loans")
        case .never_tried: return NSLocalizedString("Never tried but curious", comment: "Never tried but curious")
        case .very_little: return NSLocalizedString("Have very little experience", comment: "Have very little experience")
        case .companies_i_believe_in: return NSLocalizedString("Invest in companies I believe in", comment: "Invest in companies I believe in")
        case .etfs_and_safe_stocks: return NSLocalizedString("Invest in ETFs or safe stocks (blue chips)", comment: "Invest in ETFs or safe stocks (blue chips)")
        case .advanced: return NSLocalizedString("Advanced trader", comment: "Advanced trader")
        case .daily_trader: return NSLocalizedString("Daily trader", comment: "Daily trader")
        case .investment_funds: return NSLocalizedString("Investment funds manage for me", comment: "Investment funds manage for me")
        case .professional: return NSLocalizedString("Professional trader (work)", comment: "Professional trader (work)")
        case .dont_trade_after_bad_experience: return NSLocalizedString("Don’t trade after bad experience", comment: "Don’t trade after bad experience")
            
        }
    }
}

protocol PersonalizationTitlePickerSectionViewDelegate: AnyObject {
    
    func personalizationTitlePickerDidPickSources(sender: PersonalizationTitlePickerSectionView, sources: [PersonalizationInfoValue]?)
}

final class PersonalizationTitlePickerSectionView: UIView {
    
    public weak var delegate: PersonalizationTitlePickerSectionViewDelegate?
    
    public var itemSpacing: CGFloat = CGFloat(13.0)
    private let titleLabel: UILabel = UILabel.newAutoLayout()
    private let descriptionLabel: UILabel = UILabel.newAutoLayout()
    private var collectionView: UICollectionView?
    
    private var sources: [PersonalizationInfoValue]?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        self.setUp()
    }
    
    public func configureWith(sources: [PersonalizationInfoValue]?) {
        
        self.sources = sources
        self.collectionView?.reloadData()
    }
    
    public func configureWith(title: String) {
        
        self.titleLabel.text = title
    }
    
    public func configureWith(description: String) {
        
        self.descriptionLabel.text = description
        self.descriptionLabel.sizeToFit()
    }
    
    private func setUp() {
        
        self.setUpTitleLabel()
        self.setUpDescriptionLabel()
        self.setUpCollectionView()
    }
    
    private func setUpTitleLabel() {
        
        self.addSubview(self.titleLabel)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 28.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 28.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top)
        self.titleLabel.autoSetDimension(.height, toSize: 24.0)
        
        self.titleLabel.font = UIFont.proDisplayBold(20.0)
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = "Title"
    }
    
    private func setUpDescriptionLabel() {
        
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 28.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 28.0)
        self.descriptionLabel.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 16.0)
        self.descriptionLabel.numberOfLines = 0
        
        self.descriptionLabel.font = UIFont.proDisplayRegular(16.0)
        self.descriptionLabel.textColor = UIColor(hexString: "#09141F")
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.text = "Description Description Description Description Description Description Description Description"
        self.descriptionLabel.sizeToFit()
    }
    
    private func setUpCollectionView() {
        
        let layout = UICollectionViewCenterAlignedLayout()
        layout.sectionFootersPinToVisibleBounds = true
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        guard let collectionView = self.collectionView else {
            return
        }
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView?.autoPinEdge(toSuperviewEdge: .leading, withInset: 19.0)
        self.collectionView?.autoPinEdge(toSuperviewEdge: .trailing, withInset: 19.0)
        self.collectionView?.autoPinEdge(toSuperviewEdge: .bottom)
        self.collectionView?.autoPinEdge(.top, to: .bottom, of: self.descriptionLabel, withOffset: 32.0)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(UINib.init(nibName: "RoundedTextCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: RoundedTextCollectionViewCell.reuseIdentifier)
        self.collectionView?.allowsSelection = true
        self.collectionView?.allowsMultipleSelection = false
    }
}

extension PersonalizationTitlePickerSectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        let cell: RoundedTextCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundedTextCollectionViewCell.reuseIdentifier, for: indexPath) as! RoundedTextCollectionViewCell
        if let source: PersonalizationInfoValue = self.sources?[indexPath.row] {
            cell.title = source.description()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.sources?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let source: PersonalizationInfoValue = self.sources?[indexPath.row] else {
            return CGSize.zero
        }
        
        if source == .market_return_6 {
            return CGSize(width: 56.0, height: 40)
        } else if source == .market_return_15 {
            return CGSize(width: 63.0, height: 40)
        } else if source == .market_return_25 || source == .market_return_50 {
            return CGSize(width: 64.0, height: 40)
        }
        
        let title = source.description()
        let width = title.sizeOfString(usingFont: UIFont.proDisplaySemibold(CGFloat(16.0))).width
        var size = CGSize.init(width: (ceil(width) + CGFloat(24.0)), height: CGFloat(40))
        let maxWidth = UIScreen.main.bounds.size.width - 26.0
        if size.width > maxWidth {
            size.width = maxWidth
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return itemSpacing
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let sources = sources else {return}
        guard let indexPaths = self.collectionView?.indexPathsForSelectedItems else {return}
        let selected = indexPaths.map { indexPath in
            sources[indexPath.row]
        }
        self.delegate?.personalizationTitlePickerDidPickSources(sender: self, sources: selected)
    }
}
