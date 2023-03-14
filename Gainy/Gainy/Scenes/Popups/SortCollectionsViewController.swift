//
//  SortCollectionsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit
import PureLayout

protocol SortCollectionsViewControllerDelegate: AnyObject {
    func selectionChanged(vc: SortCollectionsViewController, sorting: String, isAscending: Bool)
}

final class SortCollectionsViewController: BaseViewController {
    
    weak var delegate: SortCollectionsViewControllerDelegate?
    
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
        }
    }
    
    @IBOutlet var matchScoreButton: UIButton! {
        didSet {
            let isOnboarded = UserProfileManager.shared.isOnboarded
            self.matchScoreButton.isHidden = !isOnboarded
        }
    }
    
    @IBOutlet var sortBtns: [BorderButton]!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preloadSorting()
    }
    
    func updateButtons() {
        let isOnboarded = UserProfileManager.shared.isOnboarded
        self.matchScoreButton.isHidden = !isOnboarded
    }
    
    private var ascConstraints: [NSLayoutConstraint] = []
    
    private func btnsMapping() ->  [CollectionsSortingSettings.SortingField: Int]  {
        
        var result: [CollectionsSortingSettings.SortingField: Int] = [:]
        for (index, item) in CollectionsSortingSettings.SortingField.allCases.enumerated() {
            result[item] = index
        }
        return result

    }
    
    private func preloadSorting() {
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        
        let settings = CollectionsSortingSettingsManager.shared.getSettingByID(profileID)
        view.removeConstraints(ascConstraints)
        ascConstraints.removeAll()
        
        ascConstraints.append(contentsOf: ascBtn.autoSetDimensions(to: CGSize.init(width: 84, height: 24)))
        if let storedBtnIdx = btnsMapping()[settings.sorting] {
            for (_, val) in sortBtns.enumerated() {
                val.isSelected = val.tag == storedBtnIdx
                if UserProfileManager.shared.collectionsReordered {
                    val.isSelected = false
                }
                
                if val.tag == storedBtnIdx {
                    
                    ascConstraints.append(ascBtn.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -24))
                    ascConstraints.append(ascBtn.autoAlignAxis(.horizontal, toSameAxisOf: val))
                }
            }
        }
        
        ascBtn.isHidden = UserProfileManager.shared.collectionsReordered
        //Setting Asc/Desc
        ascBtn.isSelected = settings.ascending
        ascBtn.setImage(UIImage(named: settings.ascending ? "arrow-up-green" : "arrow-down-red"), for: .normal)
        let colorHex = settings.ascending ? "#25EA5C" : "#FC506F"
        let color = UIColor.init(hexString: colorHex, alpha: 0.1)
        ascBtn.backgroundColor = color
        
        for (index, val) in sortBtns.enumerated() {
            
            if let key = btnsMapping().key(forValue: index) {
                val.setTitle(key.title, for: .normal)
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        guard !sender.isSelected else {
            ascBtn.isSelected.toggle()
            CollectionsSortingSettingsManager.shared.changeAscendingForId(profileID, ascending: ascBtn.isSelected)
            delegate?.selectionChanged(vc: self, sorting: (btnsMapping().key(forValue: sender.tag) ?? .matchScore).title, isAscending: ascBtn.isSelected)
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
            CollectionsSortingSettingsManager.shared.changeSortingForId(profileID, sorting: key)
        }
        
        let fields = CollectionsSortingSettings.SortingField.allCases.map { item in
            return item.title
        }
        delegate?.selectionChanged(vc: self, sorting: fields[sender.tag], isAscending: ascBtn.isSelected)
    }
    
    @IBAction func ascTapped(_ sender: UIButton) {
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        ascBtn.isSelected.toggle()
        CollectionsSortingSettingsManager.shared.changeAscendingForId(profileID, ascending: ascBtn.isSelected)

        delegate?.selectionChanged(vc: self, sorting: (btnsMapping().key(forValue: sortBtns.first(where: {$0.isSelected})?.tag ?? 0) ?? .matchScore).title, isAscending: ascBtn.isSelected)
    }
}
