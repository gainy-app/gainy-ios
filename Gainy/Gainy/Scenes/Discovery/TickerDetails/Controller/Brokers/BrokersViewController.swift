//
//  BrokersViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/8/21.
//

import UIKit
import MessageUI

protocol BrokersViewControllerDelegate: AnyObject {
    
    func didDismissBrokersViewController()
}

final class BrokersViewController: BaseViewController {

    private let brokers: [BrokerData] = [.Robinhood, .Etrade, .Ameritrade, .Public, .Webull, .Stash, .coinbase, .InteractiveBrokers, .CharlesSchwab, .Fidelity]
    public var symbol: String?
    public weak var delegate: BrokersViewControllerDelegate?
    @IBOutlet weak var brokersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.brokersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.brokersCollectionView.delegate = self
        self.brokersCollectionView.allowsSelection = true
        self.brokersCollectionView.allowsMultipleSelection = false
        self.brokersCollectionView.dataSource = self
        self.brokersCollectionView.register(UINib.init(nibName: "BrokerViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: BrokerViewCell.reuseIdentifier)
        self.brokersCollectionView.register(UINib.init(nibName: "BrokerFooterView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: BrokerFooterView.reuseIdentifier)
        self.brokersCollectionView.reloadData()
    }
}

extension BrokersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.brokers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrokerViewCell.reuseIdentifier, for: indexPath) as! BrokerViewCell
        
        let brokerData = brokers[indexPath.row]
        cell.brokerData = brokerData
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BrokerFooterView.reuseIdentifier, for: indexPath) as! BrokerFooterView
            footerView.delegate = self
            result = footerView
        default: fatalError("Unhandlad behaviour")
        }
        return result
    }
}

extension BrokersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: collectionView.frame.width - 20.0, height: 64)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension BrokersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let symbol = self.symbol else {
            return
        }
        let broker = self.brokers[indexPath.row]
        UserProfileManager.shared.selectedBrokerToTrade = broker
        if let url = broker.brokerURLWithSymbol(symbol: symbol) {
            WebPresenter.openLink(vc: self, url: url)
        }
        self.dismiss(animated: true)
        self.delegate?.didDismissBrokersViewController()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize.init(width: collectionView.frame.size.width, height: 80.0)
    }
}

extension BrokersViewController: BrokerFooterViewDelegate {
    
    func didRequestNewBroker() {
        
        GainyAnalytics.logEvent("request_new_broker", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "BrokersView"])
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            let recipientEmail = "support@gainy.app"
            mailComposer.setToRecipients([recipientEmail])
            present(mailComposer, animated: true)
            
        } else if let emailUrl = URL.init(string: "support@gainy.app") {
            WebPresenter.openLink(vc: self, url: emailUrl)
        }
    }
}

extension BrokersViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
