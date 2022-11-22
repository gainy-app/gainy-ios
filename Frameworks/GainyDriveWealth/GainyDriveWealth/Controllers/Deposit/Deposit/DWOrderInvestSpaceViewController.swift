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

final class DWOrderInvestSpaceViewController: DWBaseViewController {
    
    var amount: Double = 0.0
    var collectionId: Int = 0
    var name: String = ""
    
    enum Mode {
        case order, sell, kycSubmittted, kycPending, kycApproved, kycDocs, kycInfo, kycRejected
    }
    
    var mode: Mode = .order
    
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
    }
    
    private func loadState() {
        
        switch mode {
        case .order:
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
            subTitleLbl.isHidden = true
            cornerView.isHidden = true
            break
        case .sell:
            titleLbl.text = "You’ve sold \(amount.price) of \(name)"
            subTitleLbl.isHidden = true
            cornerView.isHidden = true
            break
        case .kycSubmittted:
            titleLbl.text = "Thanks for your time!"
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Ok", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_done")
            subTitleLbl.isHidden = true
            cornerView.isHidden = true
            break
        case .kycPending:
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Ok", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_pending")
            subTitleLbl.text = "Thanks for your time!\nWe need a few days to verify your information."
            subTitleLbl.isHidden = false
            cornerView.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#FCB224")
            statusLbl.text = "PENDING"
            break
        case .kycApproved:
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Ok", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_approved")
            subTitleLbl.text = "We have checked all your data.\nStart invest in TTF right now!"
            subTitleLbl.isHidden = false
            cornerView.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#3BF06E")
            statusLbl.text = "APPROVED"
            break
        case .kycDocs:
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Ok", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_docs")
            subTitleLbl.text = "We need some more information from you.\nPlease upload your Driver’s License."
            subTitleLbl.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#E7EAEE")
            statusLbl.text = "DOCUMENTS REQUIRED"
            break
        case .kycInfo:
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Ok", color: UIColor.white, state: .normal)
            mainImageView.image = UIImage(nameDW: "dw_kyc_info")
            subTitleLbl.text = "We need some more information from you.\nPlease fill out the form."
            subTitleLbl.isHidden = false
            cornerView.isHidden = false
            cornerView.backgroundColor = UIColor(hexString: "#E7EAEE")
            statusLbl.text = "INFO REQUIRED"
            break
        case .kycRejected:
            detailsBtn.isHidden = true
            nextBtn.configureWithTitle(title: "Ok", color: UIColor.white, state: .normal)
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
    
    @IBAction func doneAction(_ sender: Any) {
        if mode == .order {
            coordinator?.navController.dismiss(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    @IBAction func showDetailsAction(_ sender: Any) {
        coordinator?.showOrderDetails(amount: amount,
                                      collectionId: collectionId,
                                      name: name,
                                      mode: mode == .order ? .original : .sell)
    }
}

