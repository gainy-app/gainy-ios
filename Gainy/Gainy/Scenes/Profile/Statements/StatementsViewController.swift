//
//  StatementsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import UIKit
import Apollo
import GainyAPI

enum StatementType: Int, CaseIterable {
    case monthlyStatement
    case tax
    case tradeConfirmation
    
    func key() -> String {
        switch self {
        case .monthlyStatement: return "MONTHLY_STATEMENT"
        case .tax: return "TAX"
        case .tradeConfirmation: return "TRADE_CONFIRMATION"
        }
    }
    
    func name() -> String {
        switch self {
        case .monthlyStatement: return "Monthly statements"
        case .tax: return "Tax documents"
        case .tradeConfirmation: return "Trade confiramation"
        }
    }
    
    static func typeForStatement(statement: TradingGetStatementsQuery.Data.AppTradingStatement) -> StatementType? {
        
        for statementType in StatementType.allCases {
            if statementType.key() == statement.type {
                return statementType
            }
        }
        return nil
    }
}

final class StatementsViewController: BaseViewController {
    
    weak var mainCoordinator: MainCoordinator?
    private var allDocuments: [TradingGetStatementsQuery.Data.AppTradingStatement] = []
    private var documentGroups: [[TradingGetStatementsQuery.Data.AppTradingStatement]] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpNavigationBar()
        self.loadDocumentGroups { success in
            if success {
                self.collectionView.reloadData()
            } else {
                self.showError()
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib.init(nibName: "StatementsCell", bundle:Bundle.main), forCellWithReuseIdentifier: "StatementsCell")

            self.collectionView.allowsSelection = true
            self.collectionView.allowsMultipleSelection = false
        }
    }
    
    private func showError() {
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("No documents found", comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
            self.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func loadDocumentGroups(_ completion: @escaping (Bool) -> Void) {
        self.showNetworkLoader()
        Task {
            async let statements = UserProfileManager.shared.getProfileDWStatements()
            let allStatements = await statements
            await MainActor.run {
                self.hideLoader()
                self.allDocuments = allStatements
                
                for statementType in StatementType.allCases {
                    let currentGroup = allStatements.filter({ item in
                        item.type == statementType.key()
                    })
                    if currentGroup.count > 0 {
                        self.documentGroups.append(currentGroup)
                    }
                }
                completion(self.documentGroups.count > 0)
            }
        }
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
        self.title = NSLocalizedString("Documents", comment: "Documents").uppercased()
        
    }
    
    @objc private func backButtonTap(sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension StatementsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let statementGroup = self.documentGroups[indexPath.row]
        guard let statement = statementGroup.first else { return false }
        guard let statementType = StatementType.typeForStatement(statement: statement) else { return false }
        
        GainyAnalytics.logEvent("profile_document_group_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileView", "name" : statementType.name()])
        
        if let vc = self.mainCoordinator?.viewControllerFactory.instantiateStatementDetails() {
            vc.statements = statementGroup
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return false
    }
}

extension StatementsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documentGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StatementsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatementsCell", for: indexPath) as! StatementsCell
        let statementGroup = self.documentGroups[indexPath.row]
        guard let statement = statementGroup.first else { return cell }
        guard let statementType = StatementType.typeForStatement(statement: statement) else { return cell }
        
        cell.statementsGroupName = statementType.name()
        return cell
    }
}
