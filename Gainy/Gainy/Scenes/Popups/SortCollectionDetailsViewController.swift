//
//  SortCollectionDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit

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
    @IBOutlet weak var ascBtn: UIButton!
    
    
    var collectionId: Int = 0
    //TO-DO: Remove it from here
    weak var collectionCell: CollectionDetailsViewCell?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prelaodSorting()
    }
    
    let btnsMapping: [MarketDataField: Int] = [.evs : 0, .growsRateYOY: 1, .marketCap: 2, .monthToDay: 3, .netProfit: 4]
    
    private func prelaodSorting() {
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionId)
        
        if let storedBtnIdx = btnsMapping[settings.sorting] {
            for (_, val) in sortBtns.enumerated() {
                val.isSelected = val.tag == storedBtnIdx
            }
        }
    }    
    
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        for (ind, val) in sortBtns.enumerated() {
            val.isSelected = ind == sender.tag
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
        default:
            break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            self?.collectionCell?.sortSections()
        }
        
        delegate?.selectionChanged(vc: self, sorting: CollectionsDetailsSettingsManager.shared.sortings[sender.tag])
    }
}
