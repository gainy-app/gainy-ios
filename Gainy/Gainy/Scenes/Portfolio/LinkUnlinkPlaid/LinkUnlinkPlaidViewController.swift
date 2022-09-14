//
//  LinkUnlinkPlaidViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/30/21.
//

import UIKit
import GainyAPI

protocol LinkUnlinkPlaidViewControllerDelegate: AnyObject {
    func plaidLinked(controller: LinkUnlinkPlaidViewController)
    func plaidUnlinked(controller: LinkUnlinkPlaidViewController)
}

class LinkUnlinkPlaidViewController: BaseViewController {

    weak var delegate: LinkUnlinkPlaidViewControllerDelegate?
    
    private var accounts: [PlaidAccountData] = []
    
    public func configure(_ accounts: [PlaidAccountData]) {
        
        self.accounts = accounts
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
            tableView.register(UINib.init(nibName: "ButtonTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: ButtonTableViewCell.cellIdentifier)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpNavigationBar()
        tableView.reloadData()
    }

    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedSemibold(14),
                NSAttributedString.Key.kern: 1.25]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backImage = UIImage(named: "iconClose")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.title = NSLocalizedString("Connected accounts", comment: "Connected accounts").uppercased()
    }
    
    @objc private func backButtonTap(sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Plaid Listeners
    
    override func plaidLinked() {
        super.plaidLinked()
        
        delegate?.plaidLinked(controller: self)
        self.updateDataSource()
    }
    
    override func plaidLinkFailed() {
        super.plaidLinkFailed()
        
    }
    
    //MARK: - Action
    @IBAction func plaidLinkAction(_ sender: Any) {
        
        guard let profileID = UserProfileManager.shared.profileID else {return}
        
        showNetworkLoader()
        Network.shared.apollo.fetch(query: CreatePlaidLinkQuery.init(profileId: profileID, redirectUri: Constants.Plaid.redirectURI, env: "production")) {[weak self] result in
            self?.hideLoader()
            switch result {
            case .success(let graphQLResult):
                guard let linkToken = graphQLResult.data?.createPlaidLinkToken?.linkToken else {
                    return
                }
                self?.presentPlaidLinkUsingLinkToken(linkToken)
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                break
            }
        }
    }
    
    private func updateDataSource() {
       
        guard let userID = UserProfileManager.shared.profileID else { return }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID)  else { return }
                
        let brokers = UserProfileManager.shared.linkedPlaidAccounts.map { item -> PlaidAccountDataSource in
            let disabled = settings.disabledAccounts.contains { account in
                item.id == account.id
            }
            return PlaidAccountDataSource.init(accountData: item, enabled: !disabled)
        }
        let disabledBrokers = brokers.filter { item in
            !item.enabled
        }
        let disabledAccounts = disabledBrokers.map { item in
            item.accountData
        }
        PortfolioSettingsManager.shared.changeDisabledAccountsForUserId(userID, disabledAccounts: disabledAccounts)
        
        self.accounts = UserProfileManager.shared.linkedPlaidAccounts
        self.tableView.reloadData()
    }
}

extension LinkUnlinkPlaidViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.cellIdentifier, for: indexPath) as! ButtonTableViewCell
        let accountName = self.accounts[indexPath.row].name
        let needReconnect = self.accounts[indexPath.row].needReauthSince != nil
        cell.disconnectButton.isHidden = needReconnect
        cell.connectButton.isHidden = !needReconnect
        cell.customTitleLabel.text = accountName
        cell.dotsImageView.isHidden = false
        cell.delegate = self
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.accounts.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
       
        return nil
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 64.0
    }
}

extension LinkUnlinkPlaidViewController: ButtonTableViewCellDelegate {
    
    func disconnectButtonTouchUpInside(_ sender: ButtonTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let accountID = self.accounts[indexPath.row].id
        
        let yesAction = UIAlertAction.init(title: "Yes", style: .destructive) { action in
            GainyAnalytics.logEvent("plaid_account_unlinked", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "LinkUnlinkPlaidViewController"])
            self.unlinkAccount(accountID)
        }
        NotificationManager.shared.showMessage(title: "Warning", text: "Are you sure you want to unlink this Account?", cancelTitle: "No", actions: [yesAction])
    }
    
    func connectButtonTouchUpInside(_ sender: ButtonTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let accountID = self.accounts[indexPath.row].id
        guard let profileID = UserProfileManager.shared.profileID else {return}
        
        showNetworkLoader()
        
        Network.shared.apollo.fetch(query: ReCreatePlaidLinkQuery.init(profileId: profileID, accessTokenId: accountID, redirectUri: Constants.Plaid.redirectURI, env: "production")) {[weak self] result in
            self?.hideLoader()
            switch result {
            case .success(let graphQLResult):
                guard let linkToken = graphQLResult.data?.createPlaidLinkToken?.linkToken else {
                    return
                }
                self?.presentPlaidLinkUsingLinkToken(linkToken, reLink: true, accessTokenId: accountID)
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                break
            }
        }
    }
    
    private func unlinkAccount(_ accountID: Int) {
        
        self.showNetworkLoader()
        
        let query = UnlinkPlaidAccountMutation(publicTokenID: accountID)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            self.hideLoader()
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... Failed to unlink Plaid account. Please try again later.")
                return
            }
            
            UserProfileManager.shared.fetchProfile { success in
                
                self.updateDataSource()
                if !UserProfileManager.shared.isPlaidLinked {
                    self.dismiss(animated: false, completion: nil)
                    self.delegate?.plaidUnlinked(controller: self)
                }
            }
        }
    }
}
