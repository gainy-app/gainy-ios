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
    }
}
