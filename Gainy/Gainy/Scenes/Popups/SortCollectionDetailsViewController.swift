//
//  SortCollectionDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit
import PureLayout

extension Dictionary where Value: Equatable {
    func key(forValue value: Value) -> Key? {
        return first { $0.1 == value }?.0
    }
}

protocol SortCollectionDetailsViewControllerDelegate: AnyObject {
    func selectionChanged(vc: SortCollectionDetailsViewController, sorting: String)
}

final class SortCollectionDetailsViewController: BaseViewController {
    
    weak var delegate: SortCollectionDetailsViewControllerDelegate?
    var showWeight: Bool = true
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
        }
    }
    @IBOutlet var dotImageView: UIImageView!
    @IBOutlet var weightButton: UIButton!
    
    @IBOutlet var matchScoreButton: UIButton! {
        didSet {
            let isOnboarded = UserProfileManager.shared.isOnboarded
            self.matchScoreButton.isHidden = !isOnboarded
        }
    }
    
    @IBOutlet var sortBtns: [UIButton]!
    @IBOutlet weak var ascBtn: UIButton! {
        didSet {
            ascBtn.setImage(UIImage(named: "arrow-up-green"), for: .selected)
            ascBtn.setTitle("ascending".uppercased(), for: UIControl.State.selected)
            
            ascBtn.setImage(UIImage(named: "arrow-down-red"), for: .normal)
            ascBtn.setTitle("descending".uppercased(), for: UIControl.State.normal)
            ascBtn.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 8.0)
            ascBtn.titleLabel?.font = UIFont.compactRoundedMedium(9.0)
            
            var colorHex = "#0FC642"
            var color = UIColor.init(hexString: colorHex, alpha: 1.0)
            ascBtn.setTitleColor(color, for: UIControl.State.selected)
            colorHex = "#FC506F"
            color = UIColor.init(hexString: colorHex, alpha: 1.0)
            ascBtn.setTitleColor(color, for: UIControl.State.normal)
        }
    }
    
    var collectionId: Int = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preloadSorting()
    }
    
    private var ascConstraints: [NSLayoutConstraint] = []
    
    private func btnsMapping() ->  [MarketDataField: Int]  {
        
        let defaultSortingList = MarketDataField.rawOrder
        var tickerMetrics = UserProfileManager.shared.profileMetricsSettings.filter { item in
            item.collectionId == self.collectionId
        }
        tickerMetrics = tickerMetrics.sorted { left, right in
            left.order < right.order
        }
        var sortingList: [MarketDataField] = []
        
        if tickerMetrics.count == 0 {
            if self.showWeight {
                sortingList = defaultSortingList
            } else {
                sortingList = defaultSortingList
                sortingList.removeLast()
            }
        } else {
            for item in tickerMetrics {
                for metric in MarketDataField.allCases {
                    if metric.fieldName == item.fieldName {
                        sortingList.append(metric)
                    }
                }
            }
            if self.showWeight {
                sortingList.append(.weight)
            }
        }
        
        sortingList.insert(.matchScore, at: 0)
        
        var result: [MarketDataField: Int] = [:]
        for (index, item) in sortingList.enumerated() {
            result[item] = index
        }
        return result
    }
    
    private func preloadSorting() {
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionId)
        view.removeConstraints(ascConstraints)
        ascConstraints.removeAll()
        
        ascConstraints.append(contentsOf: ascBtn.autoSetDimensions(to: CGSize.init(width: 84, height: 24)))
        if let storedBtnIdx = btnsMapping()[settings.sortingValue()] {
            for (_, val) in sortBtns.enumerated() {
                val.isSelected = val.tag == storedBtnIdx
                
                if val.tag == storedBtnIdx {
                    
                    ascConstraints.append(ascBtn.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -24))
                    ascConstraints.append(ascBtn.autoAlignAxis(.horizontal, toSameAxisOf: val))
                }
            }
        }
        
        //Setting Asc/Desc
        ascBtn.isSelected = settings.ascending
        ascBtn.setImage(UIImage(named: settings.ascending ? "arrow-up-green" : "arrow-down-red"), for: .normal)
        let colorHex = settings.ascending ? "#25EA5C" : "#FC506F"
        let color = UIColor.init(hexString: colorHex, alpha: 0.1)
        ascBtn.backgroundColor = color
        
        if !self.showWeight {
            self.dotImageView.removeFromSuperview()
            self.weightButton.removeFromSuperview()
        }
        
        for (index, val) in sortBtns.enumerated() {
            
            if let key = btnsMapping().key(forValue: index) {
                val.setTitle(key.title, for: .normal)
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        
        guard !sender.isSelected else {
            ascBtn.isSelected.toggle()
            CollectionsDetailsSettingsManager.shared.changeAscendingForId(collectionId, ascending: ascBtn.isSelected)
            delegate?.selectionChanged(vc: self, sorting: (btnsMapping().key(forValue: sender.tag) ?? .matchScore).title)
            return
        }
        
        view.removeConstraints(ascConstraints)
        ascConstraints.removeAll()
        
        ascConstraints.append(contentsOf: ascBtn.autoSetDimensions(to: CGSize.init(width: 84, height: 24)))
        
        for (ind, val) in sortBtns.enumerated() {
            val.isSelected = ind == sender.tag
            
            if val.isSelected {
                ascConstraints.append(ascBtn.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -24))
                ascConstraints.append(ascBtn.autoAlignAxis(.horizontal, toSameAxisOf: val))
            }
        }
        
        if let key = btnsMapping().key(forValue: sender.tag) {
            CollectionsDetailsSettingsManager.shared.changeSortingForId(collectionId, sorting: key)
        }
        
        delegate?.selectionChanged(vc: self, sorting: CollectionsDetailsSettingsManager.shared.sortingsForCollectionID(collectionID: collectionId)[sender.tag])
    }
    
    @IBAction func ascTapped(_ sender: UIButton) {
        ascBtn.isSelected.toggle()
        CollectionsDetailsSettingsManager.shared.changeAscendingForId(collectionId, ascending: ascBtn.isSelected)

        delegate?.selectionChanged(vc: self, sorting: (btnsMapping().key(forValue: sortBtns.first(where: {$0.isSelected})?.tag ?? 0) ?? .enterpriseValueToSales).title)
    }
}
