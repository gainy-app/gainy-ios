//
//  SortDiscoveryViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/21/21.
//

import UIKit

protocol SortDiscoveryViewControllerDelegate: AnyObject {
    func selectionChanged(vc: SortDiscoveryViewController, sorting: RecommendedCollectionsSortingSettings.RecommendedCollectionSortingField, ascending: Bool)
}

final class SortDiscoveryViewController: BaseViewController {

    weak var delegate: SortDiscoveryViewControllerDelegate?
    
    var settingsManager: SortingSettingsManagable = RecommendedCollectionsSortingSettingsManager.shared
    
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
        trackMS()
    }
    
    fileprivate func trackMS() {
        let isOnboarded = UserProfileManager.shared.isOnboarded
        self.matchScoreButton.isHidden = !isOnboarded
        
        NotificationCenter.default.publisher(for: NotificationManager.startProfileTabUpdateNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] _ in
            let isOnboarded = UserProfileManager.shared.isOnboarded
            self?.matchScoreButton.isHidden = !isOnboarded
        }.store(in: &cancellables)
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
    
    private func btnsMapping() ->  [RecommendedCollectionsSortingSettings.RecommendedCollectionSortingField: Int]  {
        
        let defaultSortingList = RecommendedCollectionsSortingSettings.RecommendedCollectionSortingField.allCases
        var result: [RecommendedCollectionsSortingSettings.RecommendedCollectionSortingField: Int] = [:]
        for (index, item) in defaultSortingList.enumerated() {
            result[item] = index
        }
        return result
    }
    
    private func preloadSorting() {
        
        guard let userID = self.profileToUse else {
            return
        }
        let settings = settingsManager.getSettingByID(userID)
        
        let sorting = settings.sorting
        let ascending = settings.ascending
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
        let settings = settingsManager.getSettingByID(userID)
        guard !sender.isSelected else {
            ascBtn.isSelected.toggle()

            settingsManager.changeAscendingForId(userID, ascending: ascBtn.isSelected)
            delegate?.selectionChanged(vc: self, sorting: settings.sortingFieldsToShow[sender.tag], ascending: ascBtn.isSelected)
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
            settingsManager.changeSortingForId(userID, sorting: key, performancePeriod: settings.performancePeriod)
        }
        delegate?.selectionChanged(vc: self, sorting: settings.sortingFieldsToShow[sender.tag], ascending: ascBtn.isSelected)
    }
    
    @IBAction func ascTapped(_ sender: UIButton) {
        guard let userID = self.profileToUse else {
            return
        }
        let settings = settingsManager.getSettingByID(userID)
        
        ascBtn.isSelected.toggle()
        settingsManager.changeAscendingForId(userID, ascending: ascBtn.isSelected)
        delegate?.selectionChanged(vc: self, sorting: settings.sortingFieldsToShow[sender.tag], ascending: ascBtn.isSelected)
    }
}
