//
//  StatementDetailsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import UIKit
import GainyAPI

final class StatementDetailsViewController: BaseViewController {
    
    public var statements: [TradingGetStatementsQuery.Data.AppTradingStatement] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpNavigationBar()
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib.init(nibName: "StatementCell", bundle:Bundle.main), forCellWithReuseIdentifier: "StatementCell")

            self.collectionView.allowsSelection = true
            self.collectionView.allowsMultipleSelection = false
        }
    }
    
    private func loadShareUrlAsync(statementID: Int, statementName: String) {
        self.showNetworkLoader()
        Task {
            async let result = UserProfileManager.shared.getProfileDWStatementUrl(statementID: statementID)
            let statementUrlString = await result
            await MainActor.run {
                self.hideLoader()
                if let statementUrlString = statementUrlString {
                    if let statementUrl = URL.init(string: statementUrlString) {
                        let activity = UIActivityViewController(activityItems: ["Download URL for \(statementName)", statementUrl], applicationActivities: nil)
                        self.present(activity, animated: true)
                    } else {
                        let activity = UIActivityViewController(activityItems: ["Download URL for \(statementName)", statementUrlString], applicationActivities: nil)
                        self.present(activity, animated: true)
                    }
                } else {
                    // TODO: DW - Just for testing, remove once prod DW API ready and show error
                    if let statementUrl = URL.init(string: "https://www.gainy.app/about") {
                        let activity = UIActivityViewController(activityItems: ["Download URL for \(statementName) [EXAMPLE]", statementUrl], applicationActivities: nil)
                        self.present(activity, animated: true)
                    }
                    //self.showError()
                }
            }
        }
    }
    
    private func showError() {
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("No sharing url found", comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedSemibold(14),
            NSAttributedString.Key.kern: 1.25]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backImage = UIImage(named: "iconArrowLeft")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.navigationItem.rightBarButtonItems = [closeItem]
        self.title = NSLocalizedString("Account statements", comment: "Account statements").uppercased()
        
    }
    
    @objc private func backButtonTap(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func closeButtonTap(sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension StatementDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let statement = self.statements[indexPath.row]
        GainyAnalytics.logEvent("profile_document_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DocumentDetailsView", "name" : statement.displayName])
        self.loadShareUrlAsync(statementID: statement.id, statementName: statement.displayName)
        return false
    }
}

extension StatementDetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StatementCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatementCell", for: indexPath) as! StatementCell
        let statement = self.statements[indexPath.row]
        cell.statementName = statement.displayName
        return cell
    }
}
