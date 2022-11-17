//
//  DWSelectAccountViewController.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 31.10.22.
//

import UIKit
import GainyCommon
import GainyAPI
import Combine

final class DWSelectAccountViewController: DWBaseViewController {
    
    private var accounts: [GainyFundingAccount] = [] {
        didSet {
            tableView.reloadData()
            selectAccount()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var connectAccountButton: GainyButton! {
        didSet {
            connectAccountButton.configureWithTitle(title: "Connect new account", color: .white, state: .normal)
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            
            tableView.register(DWSelectAccountTableCell.self, forCellReuseIdentifier: DWSelectAccountTableCell.reuseIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfile.fundingAccountsPublisher.sink(receiveValue: { [weak self] accounts in
            self?.accounts = accounts
        })
        .store(in: &cancellables)
        gainyNavigationBar.isHidden = true
    }
    
    override func plaidLinked(token: Int, plaidAccounts: [PlaidAccountToLink]) {
        super.plaidLinked(token: token, plaidAccounts: plaidAccounts)
        
        hideLoader()
        showPlaidAccsToLink(token: token, plaidAccounts: plaidAccounts)
    }
    
    private func selectAccount() {
        guard let selectedFundingAccountId = userProfile.selectedFundingAccount?.id,
              let selectedAccount = accounts.firstIndex(where: { $0.id == selectedFundingAccountId }) else { return }
        tableView.selectRow(at: .init(row: selectedAccount, section: 0), animated: true, scrollPosition: .top)
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
    
    /// Showing Plaid account which can be added as Trading
    /// - Parameters:
    ///   - token: Plaid token
    ///   - plaidAaccounts: Plaid accounts
    private func showPlaidAccsToLink(token: Int, plaidAccounts: [PlaidAccountToLink]) {
        let alertController = UIAlertController(title: "Plaid Account Link", message: "Which account you would like to add?", preferredStyle: .actionSheet)
        
        for plaidAaccount in plaidAccounts {
            let sendButton = UIAlertAction(title: "\(plaidAaccount.name) - $\(amountFormatter.string(from: NSNumber(value: plaidAaccount.balanceAvailable)) ?? "")", style: .default, handler: { (action) -> Void in
                
                self.showNetworkLoader()
                Task {
                    do {
                        let createdLinkToken = try await self.dwAPI.linkTradingAccount(accessToken: token, plaidAccount: plaidAaccount)
                    } catch {
                        print("Create link failed: \(error)")
                    }
                    await MainActor.run {
                        self.hideLoader()
                    }
                }
            })
            alertController.addAction(sendButton)
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            
        })
        alertController.addAction(cancelBtn)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didTapConnect(_ sender: Any) {
        startFundingAccountLink(profileID: self.dwAPI.userProfile.profileID ?? 0)
    }
}

extension DWSelectAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = accounts[indexPath.row]
        let cell: DWSelectAccountTableCell = tableView.dequeueReusableCell(withIdentifier: DWSelectAccountTableCell.reuseIdentifier) as! DWSelectAccountTableCell
        if indexPath.row == accounts.count {
            cell.configure(with: item.name ?? "", isLast: true)
        } else {
            cell.configure(with: item.name ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = accounts[indexPath.row]
        userProfile.selectedFundingAccount = item
        dismiss(animated: true) { [weak self] in
            self?.dismissHandler?()
        }
    }
}
