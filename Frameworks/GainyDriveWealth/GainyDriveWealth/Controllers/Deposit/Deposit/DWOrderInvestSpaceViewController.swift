//
//  DWOrderInvestSpaceViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 05.10.2022.
//

import UIKit
import GainyCommon
import AVFoundation
import SwiftHEXColors
import MessageUI

public enum DWOrderInvestSpaceStatus: Int {
    case order = 0, sell, kycSubmittted, kycPending, kycApproved, kycDocs, kycInfo, kycRejected
}

final class DWOrderInvestSpaceViewController: DWBaseViewController {
    
    var amount: Double = 0.0
    var collectionId: Int = 0
    var symbol: String = ""
    var name: String = ""
    
    var mode: DWOrderInvestSpaceStatus = .order
    var type: DWOrderProductMode = .ttf
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplaySemibold(32)
        }
    }
    
    @IBOutlet private weak var cornerView: UIView! {
        didSet {
            cornerView.layer.cornerRadius = 16.0
            cornerView.clipsToBounds = true
        }
    }
    @IBOutlet private weak var statusLbl: UILabel! {
        didSet {
            statusLbl.font = UIFont.compactRoundedSemibold(16)
        }
    }
    
    @IBOutlet private weak var subTitleLbl: UILabel! {
        didSet {
            subTitleLbl.font = UIFont.proDisplaySemibold(16)
        }
    }
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Done", color: UIColor.white, state: .normal)
        }
    }
    
    @IBOutlet private weak var detailsBtn: UIButton! {
        didSet {
            detailsBtn.titleLabel?.font = .proDisplayRegular(16)
            detailsBtn.layer.cornerRadius = 18.0
            detailsBtn.clipsToBounds = true
        }
    }
    @IBOutlet private weak var mainImageView: UIImageView!
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    //MARK: - Player
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadState()
        startLoading()
        gainyNavigationBar.isHidden = true
    }
    
    private func loadState() {
        GainyAnalytics.logEvent("dw_kyc_status_view", params: ["mode" : mode.rawValue, "type" : type.rawValue])
        switch mode {
        case .order:
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
            subTitleLbl.isHidden = true
            cornerView.isHidden = true
            break
        case .sell:
            titleLbl.text = "You’ve sold \(abs(amount).price) of \(name)"
            subTitleLbl.isHidden = true
            cornerView.isHidden = true
            break
        case .kycSubmittted:
            titleLbl.text = "Thanks for your time!\nStay tuned until you are approved."
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Ok", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_done")
            subTitleLbl.isHidden = true
            cornerView.isHidden = true
            break
        case .kycPending:
            titleLbl.text = "Your KYC status"
            detailsBtn.isHidden = true
            nextBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Enable Notifications", color: UIColor.Gainy.mainText!, state: .normal)
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                
                guard granted else {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.nextBtn.isHidden = false
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (_) in
                            })
                        }
                    }
                    
                    return
                }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }                
            }
            
            nextBtn.configureWithTitle(title: "Ok", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_pending")
            subTitleLbl.text = "Thanks for your time!\nWe need a few days to verify your information."
            subTitleLbl.isHidden = false
            cornerView.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#FCB224")
            statusLbl.text = "PENDING"
            break
        case .kycApproved:
            titleLbl.text = "Your KYC status"
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Deposit", color: UIColor.Gainy.mainText!, state: .normal)
            nextBtn.backgroundColor = UIColor(hexString: "#3BF06E")
            mainImageView.image = UIImage(nameDW: "dw_kyc_approved")
            subTitleLbl.text = "Your account is open. Deposit funds and invest now."
            subTitleLbl.isHidden = false
            cornerView.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#3BF06E")
            statusLbl.text = "APPROVED"
            break
        case .kycDocs:
            titleLbl.text = "Your KYC status"
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Upload Documents", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_docs")
            subTitleLbl.text = "We need some more information from you.\nPlease upload your Driver’s License."
            subTitleLbl.isHidden = false
            cornerView.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#E7EAEE")
            statusLbl.text = "DOCUMENTS REQUIRED"
            break
        case .kycInfo:
            titleLbl.text = "Your KYC status"
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Go to form", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_info")
            subTitleLbl.text = "We need some more information from you.\nPlease fill out the form."
            subTitleLbl.isHidden = false
            cornerView.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#E7EAEE")
            statusLbl.text = "INFO REQUIRED"
            break
        case .kycRejected:
            titleLbl.text = "Your KYC status"
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Contact us", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_rejected")
            subTitleLbl.text = "We need some more information from you.\nPlease contact us."
            subTitleLbl.isHidden = false
            cornerView.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#F95664")
            statusLbl.text = "REJECTED"
            break
        }
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    func startLoading() {
        setupPlayer()
        avPlayer.play()
    }
    
    func stopLoading() {
        avPlayer.pause()
        avPlayerLayer.removeFromSuperlayer()
    }
    
    func setupPlayer() {
        let theURL = Bundle.main.url(forResource:"Space", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.bounds
        self.view.layer.insertSublayer(avPlayerLayer, at: 0)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero, completionHandler: nil)
    }
    
    
    //MARK: - Actions
    
    @IBAction func closeAction(_ sender: Any) {
        plainDismiss()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        switch mode {
        case .order:
            coordinator?.navController.dismiss(animated: true)
            break
        case .kycApproved:
            coordinator?.showDeposit()
        case .kycDocs:
            coordinator?.showAddDocuments()
        case .kycInfo:
            coordinator?.showKYCMainMenu()
        case .kycRejected:
            coordinator?.showContactUs(delegate: self)
        default:
            plainDismiss()
        }
    }
    
    @IBAction func showDetailsAction(_ sender: Any) {
        coordinator?.showOrderDetails(amount: amount,
                                      name: name,
                                      mode: mode == .order ? .original : .sell)
    }
}

extension DWOrderInvestSpaceViewController: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}

