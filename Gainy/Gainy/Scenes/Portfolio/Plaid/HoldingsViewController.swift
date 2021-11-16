//
//  HoldingsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.11.2021.
//

import UIKit

final class HoldingsViewController: BaseViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel.dataSource
        }
    }
    //MARK: - Inner
    private let viewModel = HoldingsViewModel()
    
    //MARK: - Life Cycle
    
}
