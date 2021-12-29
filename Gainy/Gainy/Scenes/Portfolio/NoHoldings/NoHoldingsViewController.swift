//
//  NoHoldingsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.12.2021.
//

import Foundation
import UIKit
import MessageUI

protocol NoHoldingsViewControllerDelegate: AnyObject {
    func reconnectPressed(vc: NoHoldingsViewController)
}

final class NoHoldingsViewController: BaseViewController {
    
    weak var delegate: NoHoldingsViewControllerDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var infoLbl: UITextView!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLbl.delegate = self
        let str = "Sorry, we could not get enough data to display the information correctly. Try to reconnect your account or contact us".mutableAttr(font: .proDisplayRegular(16), color: UIColor(named: "mainText")!)
        let foundRange = str.mutableString.range(of: "contact us")
        if foundRange.location != NSNotFound {
            str.addAttribute(NSAttributedString.Key.link, value: "https:\\www.google.com", range: foundRange)
        }
        infoLbl.attributedText = str
    }
    
    //MARK: - Actions
    @IBAction func reloadAction(_ sender: Any) {
        delegate?.reconnectPressed(vc: self)
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
