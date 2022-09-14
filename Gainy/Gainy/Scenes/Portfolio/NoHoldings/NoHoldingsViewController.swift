//
//  NoHoldingsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.12.2021.
//

import Foundation
import UIKit
import MessageUI
import GainyAPI

protocol NoHoldingsViewControllerDelegate: AnyObject {
    func plaidLinked(vc: NoHoldingsViewController)
}

final class NoHoldingsViewController: BaseViewController {
    
    weak var delegate: NoHoldingsViewControllerDelegate?
    
    //MARK: - Outlets
    
    //MARK: - Plaid Listeners
        
    override func plaidLinked() {
        super.plaidLinked()
        
        GainyAnalytics.logEvent("portfolio_plaid_link_success")
        delegate?.plaidLinked(vc: self)
    }
    
    override func plaidLinkFailed() {
        super.plaidLinkFailed()
        GainyAnalytics.logEvent("portfolio_plaid_link_failed")
    }
    
    @IBOutlet weak var infoLbl: UITextView!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLbl.delegate = self
        let str = "Sorry, we could not get enough data to display the information correctly. Try to reconnect your account or contact us in Profile".mutableAttr(font: .proDisplayRegular(16), color: UIColor(named: "mainText")!)
        let foundRange = str.mutableString.range(of: "contact us in Profile")
        if foundRange.location != NSNotFound {
            str.addAttribute(NSAttributedString.Key.link, value: "", range: foundRange)
        }
        infoLbl.attributedText = str
    }
    
    //MARK: - Actions
    @IBAction func reloadAction(_ sender: Any) {
        
        GainyAnalytics.logEvent("portfolio_plaid_reconnect_pressed")
        guard let profileID = UserProfileManager.shared.profileID else {return}
        guard let plaidID = UserProfileManager.shared.linkPlaidID else {return}
        
        showNetworkLoader()
        
        let query = UnlinkPlaidAccountMutation(publicTokenID: plaidID)
        Network.shared.apollo.perform(mutation: query) { result in           
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
    }
}

extension NoHoldingsViewController: UITextViewDelegate {
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

//        return false
//    }
    
    @available(iOS 10.0, *)
   func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
   {
               if MFMailComposeViewController.canSendMail() {
                   let mailComposer = MFMailComposeViewController()
                   mailComposer.mailComposeDelegate = self
                   let recipientEmail = "support@gainy.app"
                   mailComposer.setToRecipients([recipientEmail])
                   present(mailComposer, animated: true)
       
               }
       return false
   }

   @available(iOS, deprecated: 10.0)
   func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange) -> Bool
   {
       if MFMailComposeViewController.canSendMail() {
           let mailComposer = MFMailComposeViewController()
           mailComposer.mailComposeDelegate = self
           let recipientEmail = "support@gainy.app"
           mailComposer.setToRecipients([recipientEmail])
           present(mailComposer, animated: true)

       }
      return false
   }
}

extension NoHoldingsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
