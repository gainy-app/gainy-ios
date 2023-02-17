//
//  SortPortfolioDetailsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/21/21.
//

import UIKit

protocol SortPortfolioPieChartTickersViewControllerDelegate: AnyObject {
    func selectionChanged(vc: SortPortfolioPieChartTickersViewController, sorting: PortfolioSortingField, ascending: Bool)
}


// TODO: Rewrite this and Floating Panel to system action scheet or something like that
final class SortPortfolioPieChartTickersViewController: BaseViewController {

    weak var delegate: SortPortfolioPieChartTickersViewControllerDelegate?
    
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

    var isDemoProfile: Bool = false
    
    var profileToUse: Int? {
        if isDemoProfile {
            return Constants.Plaid.demoProfileID
        } else {
            return UserProfileManager.shared.profileID
        }
    }
    private var ascConstraints: [NSLayoutConstraint] = []
    
    private func btnsMapping() ->  [PortfolioSortingField: Int]  {
        
        let defaultSortingList = PortfolioSortingField.tickersRawOrder
        var result: [PortfolioSortingField: Int] = [:]
        for (index, item) in defaultSortingList.enumerated() {
            result[item] = index
        }
        return result
    }
    
    private func preloadSorting() {
        
        guard let userID = self.profileToUse else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        let sorting = settings.sortingValue(mode: settings.pieChartMode)
        let ascending = settings.ascending(mode: settings.pieChartMode)
        view.removeConstraints(ascConstraints)
        ascConstraints.removeAll()

        ascConstraints.append(contentsOf: ascBtn.autoSetDimensions(to: CGSize.init(width: 84, height: 24)))
        if let storedBtnIdx = btnsMapping()[sorting] {
            for (_, val) in sortBtns.enumerated() {
                val.isSelected = val.tag == storedBtnIdx

                if val.tag == storedBtnIdx {

                    ascConstraints.append(ascBtn.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -24))
                    ascConstraints.append(ascBtn.autoAlignAxis(.horizontal, toSameAxisOf: val))
                }
            }
        }

        //Setting Asc/Desc
        ascBtn.isSelected = ascending
        let colorHex = ascending ? "#25EA5C" : "#FC506F"
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
        
        guard let userID = self.profileToUse else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        guard !sender.isSelected else {
            ascBtn.isSelected.toggle()
            
            var pieChartAscending: [PieChartMode : Bool] = settings.pieChartAscending
            pieChartAscending[settings.pieChartMode] = ascBtn.isSelected
            PortfolioSettingsManager.pieShared.changePieChartAscendingForUserId(userID, pieChartAscending: pieChartAscending)
            let sorting = PortfolioSettingsManager.pieShared.sortingsForUserID(userID: userID, mode: settings.pieChartMode)
            delegate?.selectionChanged(vc: self, sorting: sender.tag == sorting.count ? sorting[sender.tag - 1] : sorting[sender.tag], ascending: ascBtn.isSelected)
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

        var tag = sender.tag
        if self.isDemoProfile, sender.tag == btnsMapping().count  {
            tag -= 1
        }
        if let key = btnsMapping().key(forValue: tag) {
            var pieChartSorting: [PieChartMode : PortfolioSortingField] = settings.pieChartSorting
            pieChartSorting[settings.pieChartMode] = key
            PortfolioSettingsManager.pieShared.changePieChartSortingForUserId(userID, pieChartSorting: pieChartSorting)
        }
        let sorting = PortfolioSettingsManager.pieShared.sortingsForUserID(userID: userID, mode: settings.pieChartMode)
        delegate?.selectionChanged(vc: self, sorting: sender.tag == sorting.count ? sorting[sender.tag - 1] : sorting[sender.tag], ascending: ascBtn.isSelected)
    }
    
    @IBAction func ascTapped(_ sender: UIButton) {
        guard let userID = self.profileToUse else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        ascBtn.isSelected.toggle()
        var pieChartAscending: [PieChartMode : Bool] = settings.pieChartAscending
        pieChartAscending[settings.pieChartMode] = ascBtn.isSelected
        PortfolioSettingsManager.pieShared.changePieChartAscendingForUserId(userID, pieChartAscending: pieChartAscending)
        delegate?.selectionChanged(vc: self, sorting: settings.pieChartSorting[settings.pieChartMode] ?? .weight, ascending: ascBtn.isSelected)
    }
}
