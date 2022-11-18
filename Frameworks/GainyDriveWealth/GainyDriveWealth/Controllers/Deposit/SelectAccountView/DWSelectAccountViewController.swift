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
    
    var isNeedToDelete: Bool = false
    
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
    
    private func selectAccount() {
        guard let selectedFundingAccountId = userProfile.selectedFundingAccount?.id,
              let selectedAccount = accounts.firstIndex(where: { $0.id == selectedFundingAccountId }) else { return }
        tableView.selectRow(at: .init(row: selectedAccount, section: 0), animated: true, scrollPosition: .top)
    }
    
    @IBAction func didTapConnect(_ sender: Any) {
        coordinator?.startFundingAccountLink(profileID: self.dwAPI.userProfile.profileID ?? 0, from: self)
    }
    
    private func delete(_ account: GainyFundingAccount) {
        showNetworkLoader()
        Task() {
            do {
                let result = try await dwAPI.deleteFundingAccount(account: account)
                print("RESULT of delete: \(result.ok)")
                await MainActor.run {
                    hideLoader()
                }
            }
            catch {
                print(error)
                await MainActor.run {
                    hideLoader()
                }
            }
        }
    }
}

extension DWSelectAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = accounts[indexPath.row]
        let cell: DWSelectAccountTableCell = tableView.dequeueReusableCell(withIdentifier: DWSelectAccountTableCell.reuseIdentifier) as! DWSelectAccountTableCell
        if indexPath.row == accounts.count - 1 {
            cell.configure(with: account.name ?? "", isLast: true, isNeedToDelete: isNeedToDelete)
        } else {
            cell.configure(with: account.name ?? "", isNeedToDelete: isNeedToDelete)
        }
        cell.didTapDelete = { [weak self] in
            self?.delete(account)
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
