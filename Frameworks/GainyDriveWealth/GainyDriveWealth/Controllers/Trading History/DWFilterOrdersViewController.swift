//
//  SortCollectionsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit
import PureLayout
import GainyCommon

protocol DWFilterOrdersViewControllerDelegate: AnyObject {
    func selectionChanged(vc: DWFilterOrdersViewController, filterBy: ProfileTradingHistoryType, ascending: Bool)
}

final class DWFilterOrdersViewController: UIViewController, DWStoryboarded {
    
    weak var delegate: DWFilterOrdersViewControllerDelegate?
    var selectedSorting: ProfileTradingHistoryType = .all
    var ascending: Bool = false
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
        }
    }
    
    @IBOutlet var sortBtns: [GainyBorderButton]!
    
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
    
    private func btnsMapping() ->  [ProfileTradingHistoryType: Int]  {
        
        var result: [ProfileTradingHistoryType: Int] = [:]
        
        for (index, item) in ProfileTradingHistoryType.allCases.enumerated() {
            result[item] = index
        }
        return result

    }
    
    private func preloadSorting() {

        view.removeConstraints(ascConstraints)
        ascConstraints.removeAll()
        
        ascConstraints.append(contentsOf: ascBtn.autoSetDimensions(to: CGSize.init(width: 84, height: 24)))
        if let storedBtnIdx = btnsMapping()[self.selectedSorting] {
            for (_, val) in sortBtns.enumerated() {
                val.isSelected = val.tag == storedBtnIdx
                if val.tag == storedBtnIdx {
                    
                    ascConstraints.append(ascBtn.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -24))
                    ascConstraints.append(ascBtn.autoAlignAxis(.horizontal, toSameAxisOf: val))
                }
            }
        }
        
        //Setting Asc/Desc
        let ascending = self.ascending
        ascBtn.isSelected = ascending
        ascBtn.setImage(UIImage(named: ascending ? "arrow-up-green" : "arrow-down-red"), for: .normal)
        let colorHex = ascending ? "#25EA5C" : "#FC506F"
        let color = UIColor.init(hexString: colorHex, alpha: 0.1)
        ascBtn.backgroundColor = color
        
        for (index, val) in sortBtns.enumerated() {
            let key = btnsMapping().keys.first { item in
                return btnsMapping()[item] == index
            }
            if let key = key {
                val.setTitle(key.title, for: .normal)
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        
        guard !sender.isSelected else {
            ascBtn.isSelected.toggle()
            self.ascending = ascBtn.isSelected
            let key = btnsMapping().keys.first { item in
                return btnsMapping()[item] == sender.tag
            }
            self.selectedSorting = key ?? .all
            delegate?.selectionChanged(vc: self, filterBy: self.selectedSorting, ascending: self.ascending)
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
        
        self.ascending = ascBtn.isSelected
        let key = btnsMapping().keys.first { item in
            return btnsMapping()[item] == sender.tag
        }
        self.selectedSorting = key ?? .all
        delegate?.selectionChanged(vc: self, filterBy: self.selectedSorting, ascending: self.ascending)
    }
    
    @IBAction func ascTapped(_ sender: UIButton) {

        ascBtn.isSelected.toggle()

        
        self.ascending = ascBtn.isSelected
        let index = sortBtns.first(where: {$0.isSelected})?.tag ?? 0
        let key = btnsMapping().keys.first { item in
            return btnsMapping()[item] == index
        }
        self.selectedSorting = key ?? .all
        delegate?.selectionChanged(vc: self, filterBy: self.selectedSorting, ascending: self.ascending)
    }
}
