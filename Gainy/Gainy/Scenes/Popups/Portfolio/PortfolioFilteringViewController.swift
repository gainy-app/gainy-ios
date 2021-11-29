//
//  PortfolioFilteringViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/20/21.
//

import UIKit

protocol PortfolioFilteringViewControllerDelegate: AnyObject {
    // WIP Borysov - coming soon
}

class PortfolioFilteringViewController: BaseViewController {
    
    public weak var delegate: PortfolioFilteringViewControllerDelegate?
    
    private var brokers: [PlaidAccountDataSource] = []
    
    private var interests: [InfoDataSouce] = []
    private var categories: [InfoDataSouce] = []
    private var securityTypes: [InfoDataSouce] = []
    
    private var includeClosedPositions: Bool = false
    private var onlyLongCapitalGainTax: Bool = false
    
    public func cofigure(_ brokers: [PlaidAccountDataSource],
                         _ interests: [InfoDataSouce],
                         _ categories: [InfoDataSouce],
                         _ securityTypes: [InfoDataSouce],
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
        case 2: let cell: SwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.cellIdentifier, for: indexPath) as! SwitchTableViewCell
            
            if indexPath.row == 0 {
                cell.customTitleLabel.text = "Include closed positions"
                cell.valueSwitch.setOn(self.includeClosedPositions, animated: false)
            } else if indexPath.row == 1 {
                cell.customTitleLabel.text = "Only long capital gain tax"
                cell.valueSwitch.setOn(self.onlyLongCapitalGainTax, animated: false)
            }
            cell.delegate = self
            cell.dotsImageView.isHidden = (indexPath.row == 1) ? true : false
            return cell
        default: return UITableViewCell.newAutoLayout()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return self.brokers.count
        case 1: return 3
        case 2: return 2
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if indexPath.section == 1 {
            let type: InfoDataSouceType?
            switch indexPath.row {
            case 0: type = InfoDataSouceType.Interst
            case 1: type = InfoDataSouceType.Category
            case 2: type = InfoDataSouceType.SecurityType
            default: return nil
            }
            if let type = type {
                // WIP Borysov - coming soon : Show PickInfoDataViewController
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 64.0
    }
}

extension PortfolioFilteringViewController: SwitchTableViewCellDelegate {
    
    func switchValueChanged(_ sender: SwitchTableViewCell) {
        // WIP Borysov - coming soon : save changed value
    }
}
