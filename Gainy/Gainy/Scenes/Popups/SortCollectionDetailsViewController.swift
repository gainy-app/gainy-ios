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
    
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
        }
    }
    @IBOutlet var sortBtns: [UIButton]!
    @IBOutlet weak var ascBtn: UIButton! {
        didSet {
            ascBtn.setImage(UIImage(named: "arrow-down"), for: .selected)
            ascBtn.setImage(UIImage(named: "arrow-up"), for: .normal)
        }
    }
    
    var collectionId: Int = 0
    //TO-DO: Remove it from here
    weak var collectionCell: CollectionDetailsViewCell?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preloadSorting()
    }
    
    private let btnsMapping: [MarketDataField: Int] = [.matchScore: 5, .evs : 0, .growsRateYOY: 1, .marketCap: 2, .monthToDay: 3, .netProfit: 4]
    private var ascConstraints: [NSLayoutConstraint] = []
    
    private func preloadSorting() {
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionId)
        ascBtn.autoSetDimensions(to: CGSize.init(width: 44, height: 44))
                                 
        view.removeConstraints(ascConstraints)
        
        if let storedBtnIdx = btnsMapping[settings.sorting] {
            for (idx, val) in sortBtns.enumerated() {
                val.isSelected = val.tag == storedBtnIdx
                
                if val.tag == storedBtnIdx {
                    
                    ascConstraints.append(ascBtn.autoPinEdge(.leading, to: .leading, of: view, withOffset: 60))
                    ascConstraints.append(ascBtn.autoPinEdge(.top, to: .top, of: view, withOffset: 68.0 + 46.0 * CGFloat(idx)))
                }
            }
        }
        
        //Setting Asc/Desc
        ascBtn.isSelected = settings.ascending
        ascBtn.setImage(UIImage(named: settings.ascending ? "arrow-up" : "arrow-down"), for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        
        guard !sender.isSelected else {
            ascBtn.isSelected.toggle()
            CollectionsDetailsSettingsManager.shared.changeAscendingForId(collectionId, ascending: ascBtn.isSelected)
            
            delegate?.selectionChanged(vc: self, sorting: (btnsMapping.key(forValue: sender.tag) ?? .matchScore).title)
            return
        }
        
        view.removeConstraints(ascBtn.constraints)
        
        for (ind, val) in sortBtns.enumerated() {
            val.isSelected = ind == sender.tag
            
            if val.isSelected {
                ascConstraints.append(ascBtn.autoPinEdge(.leading, to: .leading, of: view, withOffset: 100))
                ascConstraints.append(ascBtn.autoPinEdge(.top, to: .top, of: view, withOffset: 68.0 + 40.0 * CGFloat(btnsMapping[btnsMapping.key(forValue: ind)!] ?? 0)))
            }
        }
        switch sender.tag {
        case 0:
            CollectionsDetailsSettingsManager.shared.changeSortingForId(collectionId, sorting: .evs)
        case 1:
            CollectionsDetailsSettingsManager.shared.changeSortingForId(collectionId, sorting: .growsRateYOY)
        case 2:
            CollectionsDetailsSettingsManager.shared.changeSortingForId(collectionId, sorting: .marketCap)
        case 3:
            CollectionsDetailsSettingsManager.shared.changeSortingForId(collectionId, sorting: .monthToDay)
        case 4:
            CollectionsDetailsSettingsManager.shared.changeSortingForId(collectionId, sorting: .netProfit)
        case 5:
            CollectionsDetailsSettingsManager.shared.changeSortingForId(collectionId, sorting: .matchScore)
        default:
            break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            self?.collectionCell?.sortSections()
        }
        
        delegate?.selectionChanged(vc: self, sorting: CollectionsDetailsSettingsManager.shared.sortings[sender.tag])
    }
    
    @IBAction func ascTapped(_ sender: UIButton) {
        ascBtn.isSelected.toggle()
        CollectionsDetailsSettingsManager.shared.changeAscendingForId(collectionId, ascending: ascBtn.isSelected)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            self?.collectionCell?.sortSections()
        }
        delegate?.selectionChanged(vc: self, sorting: (btnsMapping.key(forValue: sortBtns.first(where: {$0.isSelected})?.tag ?? 0) ?? .evs).title)
    }
}
