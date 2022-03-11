//
//  PortfolioFilteringViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/20/21.
//

import UIKit

protocol PortfolioFilteringViewControllerDelegate: AnyObject {
    
    func didChangeFilterSettings(_ sender: PortfolioFilteringViewController)
}

class PortfolioFilteringViewController: BaseViewController {
    
    public weak var delegate: PortfolioFilteringViewControllerDelegate?
    
    private var brokers: [PlaidAccountDataSource] = []
    
    private var interests: [InfoDataSource] = []
    private var categories: [InfoDataSource] = []
    private var securityTypes: [InfoDataSource] = []
    
    private var includeClosedPositions: Bool = false
    private var onlyLongCapitalGainTax: Bool = false
    
    public func configure(_ brokers: [PlaidAccountDataSource],
                         _ interests: [InfoDataSource],
                         _ categories: [InfoDataSource],
                         _ securityTypes: [InfoDataSource],
                         _ includeClosedPositions: Bool,
                         _ onlyLongCapitalGainTax: Bool) {
        
        self.brokers = brokers
        
        self.interests = interests
        self.categories = categories
        self.securityTypes = securityTypes
        
        self.includeClosedPositions = includeClosedPositions
        self.onlyLongCapitalGainTax = onlyLongCapitalGainTax
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.sectionHeaderHeight = UITableView.automaticDimension
            tableView.sectionFooterHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 64.0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.backgroundColor = .clear
            tableView.showsHorizontalScrollIndicator = false
            tableView.showsVerticalScrollIndicator = false
            tableView.register(UINib.init(nibName: "SwitchTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: SwitchTableViewCell.cellIdentifier)
            tableView.register(UINib.init(nibName: "ListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: ListTableViewCell.cellIdentifier)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }

}

extension PortfolioFilteringViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0: let cell: SwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.cellIdentifier, for: indexPath) as! SwitchTableViewCell
            let broker = brokers[indexPath.row]
            cell.customTitleLabel.text = broker.accountData.name
            cell.valueSwitch.setOn(broker.enabled, animated: false)
            cell.dotsImageView.isHidden = false
            cell.delegate = self
            return cell
        case 1: let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdentifier, for: indexPath) as! ListTableViewCell
            if indexPath.row == 0 {
                cell.customTitleLabel.text = "Interests"
            } else if indexPath.row == 1 {
                cell.customTitleLabel.text = "Categories"
            } else if indexPath.row == 2 {
                cell.customTitleLabel.text = "Security types"
            }
            cell.dotsImageView.isHidden = false
            return cell
        default: return UITableViewCell.newAutoLayout()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return self.brokers.count
        case 1: return 2
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if indexPath.section == 1 {
            
            let infoDataVC: PortfolioInfoDataViewController = PortfolioInfoDataViewController.instantiate(.portfolio)
            switch indexPath.row {
            case 0:
                infoDataVC.configure(with: self.interests)
            case 1:
                infoDataVC.configure(with: self.categories)
            case 2:
                infoDataVC.configure(with: self.securityTypes)
            default: return nil
            }
            
            infoDataVC.delegate = self
            infoDataVC.dismissHandler = {
                self.tableView.reloadData()
            }
            let navigationController = UINavigationController.init(rootViewController: infoDataVC)
            self.present(navigationController, animated: true, completion: nil)
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 64.0
    }
}

extension PortfolioFilteringViewController: SwitchTableViewCellDelegate {
    
    func switchValueChanged(_ sender: SwitchTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: sender) else {
            return
        }
        
        switch indexPath.section {
        case 0:
            guard let userID = UserProfileManager.shared.profileID else {return}
            let accountData = self.brokers[indexPath.row].accountData
            self.brokers[indexPath.row] = PlaidAccountDataSource.init(accountData: accountData, enabled: sender.valueSwitch.isOn)
            let disabledBrokers = self.brokers.filter { item in
                !item.enabled
            }
            let disabledAccounts = disabledBrokers.map { item in
                item.accountData
            }
            PortfolioSettingsManager.shared.changedisabledAccountsForUserId(userID, disabledAccounts: disabledAccounts)
            self.delegate?.didChangeFilterSettings(self)
        default: return
        }
    }
}

extension PortfolioFilteringViewController: PortfolioInfoDataViewControllerDelegate {
    
    func didChangeInfoData(_ sender: AnyObject?, _ updatedDataSource: [InfoDataSource]) {
        
        guard let userID = UserProfileManager.shared.profileID else {return}
        guard let type = updatedDataSource.first?.type else {return}
        
        switch type {
        case .Interst:
            self.interests = updatedDataSource
            PortfolioSettingsManager.shared.changeInterestsForUserId(userID, interests: updatedDataSource)
        case .Category:
            self.categories = updatedDataSource
            PortfolioSettingsManager.shared.changeCategoriesForUserId(userID, categories: updatedDataSource)
        case .SecurityType:
            self.securityTypes = updatedDataSource
            PortfolioSettingsManager.shared.changeSecurityTypesForUserId(userID, securityTypes: updatedDataSource)
        }
        
        self.delegate?.didChangeFilterSettings(self)
    }
}
