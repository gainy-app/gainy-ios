//
//  SortPortfolioDetailsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/21/21.
//

import UIKit

protocol SortPortfolioDetailsViewControllerDelegate: AnyObject {
    func selectionChanged(vc: SortPortfolioDetailsViewController, sorting: PortfolioSortingField, ascending: Bool)
}

final class SortPortfolioDetailsViewController: BaseViewController {

    weak var delegate: SortPortfolioDetailsViewControllerDelegate?
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preloadSorting()
    }

    
    private var ascConstraints: [NSLayoutConstraint] = []
    
    private func btnsMapping() ->  [PortfolioSortingField: Int]  {
        
        let defaultSortingList = PortfolioSortingField.rawOrder
        var result: [PortfolioSortingField: Int] = [:]
        for (index, item) in defaultSortingList.enumerated() {
            result[item] = index
        }
        return result
    }
    
    private func preloadSorting() {
        
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        
        let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID)
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

        for (index, val) in sortBtns.enumerated() {

            if let key = btnsMapping().key(forValue: index) {
                val.setTitle(key.title, for: .normal)
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func sortBtnTapped(_ sender: UIButton) {
        
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        
        guard !sender.isSelected else {
            ascBtn.isSelected.toggle()
            PortfolioSettingsManager.shared.changeAscendingForUserId(userID, ascending: ascBtn.isSelected)
            delegate?.selectionChanged(vc: self, sorting: (btnsMapping().key(forValue: sender.tag) ?? .matchScore), ascending: ascBtn.isSelected)
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
            PortfolioSettingsManager.shared.changeSortingForUserId(userID, sorting: key)
        }
        delegate?.selectionChanged(vc: self, sorting: PortfolioSettingsManager.shared.sortingsForUserID(userID: userID)[sender.tag], ascending: ascBtn.isSelected)
    }
    
    @IBAction func ascTapped(_ sender: UIButton) {
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        
        ascBtn.isSelected.toggle()
        PortfolioSettingsManager.shared.changeAscendingForUserId(userID, ascending: ascBtn.isSelected)
        delegate?.selectionChanged(vc: self, sorting: (btnsMapping().key(forValue: sortBtns.first(where: {$0.isSelected})?.tag ?? 0) ?? .matchScore), ascending: ascBtn.isSelected)
    }
}
