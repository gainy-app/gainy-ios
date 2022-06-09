//
//  PurchaseViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.05.2022.
//

import UIKit
import Foundation
import AVFoundation

final class PurchaseViewController: BaseViewController {
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - Player
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    //MARK: - Outlets
    @IBOutlet private weak var spacemanView: UIImageView!
    @IBOutlet private weak var extraCover: UIImageView!
    @IBOutlet private weak var orbitView: UIImageView!
    @IBOutlet private weak var purchasesView: PurchasesProductsView! {
        didSet {
            purchasesView.delegate = self
        }
    }
    @IBOutlet private weak var purchasesScroll: UIScrollView! {
        didSet {
            purchasesScroll.delegate = self
        }
    }
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var restoreBtn: BorderButton!
    @IBOutlet private weak var inviteView: PurchaseInviteView!
    @IBOutlet private weak var infoLbl: UILabel!
    
    private var isPurchasing: Bool = false {
        didSet {
            purchaseBtn.isEnabled = !isPurchasing
            restoreBtn.isEnabled = !isPurchasing
            if isPurchasing {
                indicatorView.startAnimating()
            } else {
                indicatorView.stopAnimating()
            }
        }
    }
    
    private var isInvite: Bool = false {
        didSet {
            UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveLinear, .beginFromCurrentState]) {
                self.spacemanView.transform = .init(scaleX: self.isInvite ? 0.83 : 1.0, y: self.isInvite ? 0.83 : 1.0)
                self.extraCover.alpha = self.isInvite ? 1.0 : 0.0
                self.orbitView.transform = .init(scaleX: self.isInvite ? 0.9 : 0.7, y: self.isInvite ? 0.9 : 0.7)
            } completion: { done in
                if done {
                    
                }
            }
            
            if isInvite {
                inviteView.isSelected = true
                purchaseBtn.setTitle("Share link".uppercased(), for: .normal)
                infoLbl.text = purchasesView.selectedProduct?.terms ?? ""
            } else {
                inviteView.isSelected = false
                purchaseBtn.setTitle("Continue".uppercased(), for: .normal)
                infoLbl.text = "Premium subscription is required to get access to unlimited TTF views for selected period. The subscription will not renew automatically with the price and duration given above. Payment will be charged to your Apple ID account at the confirmation of purchase. You can manage and cancel your subscriptions by going to your account settings on the App Store after purchase."
            }
        }
    }
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern(kern: 1.25, color: .white)
        }
    }
    
    @IBOutlet private weak var purchaseBtn: UIButton! {
        didSet {
            purchaseBtn.layer.cornerRadius = 20
            
            let backGradientView = GradientPlainBackgroundView()
            backGradientView.startColor = UIColor(hexString: "1B44F7")
            backGradientView.endColor = UIColor(hexString: "357CFD")
            backGradientView.startPoint = .init(x: 0, y: 0.5)
            backGradientView.endPoint = .init(x: 1, y: 0.5)
            backGradientView.isUserInteractionEnabled = false
            purchaseBtn.addSubview(backGradientView)
            backGradientView.autoPinEdgesToSuperviewEdges()
            
            purchaseBtn.backgroundColor = UIColor(hexString: "#1B45FB")!
            purchaseBtn.layer.shadowColor = UIColor(hexString: "4484FF")!.cgColor
            purchaseBtn.layer.shadowOffset = CGSize(width: 0, height: 4)
            purchaseBtn.layer.shadowRadius = 24
            purchaseBtn.layer.shadowOpacity = 0.64
            purchaseBtn.layer.cornerRadius = 20.0
            purchaseBtn.clipsToBounds = true
            purchaseBtn.isUserInteractionEnabled = true
            
            purchaseBtn.addTarget(self, action: #selector(purchaseAction), for: .touchUpInside)
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        self.setupPlayer()
        self.orbitView.transform = .init(scaleX: self.isInvite ? 1.0 : 0.7, y: self.isInvite ? 1.0 : 0.7)
        avPlayer.play()
        paused = false
        
        NotificationCenter.default.publisher(for: NotificationManager.subscriptionChangedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] notif in
                if let subscriptionType = notif.userInfo?["type"] as? SuscriptionType {
                    if subscriptionType == .pro {
                        self?.dismiss(animated: true)
                    } else {
                        
                    }
                    self?.isPurchasing = false
                }
            }
            .store(in: &self.cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        infoLbl.text = purchasesView.selectedProduct?.terms ?? ""
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayerLayer.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero, completionHandler: nil)
    }
    
    func setupPlayer() {
        let theURL = Bundle.main.url(forResource:"Gradient_Stars", withExtension: "mp4")
        
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        avPlayerLayer.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
    }
    
    
    //MARK: - Actions
    
    @IBAction private func closeAction() {
        dismiss(animated: true)
    }
    
    @IBAction @objc func purchaseAction() {
        if isInvite {
            generateInvite()
        } else {
            if let product = purchasesView.selectedProduct {
                isPurchasing = true
                SubscriptionManager.shared.purchaseProduct(product: product)
            }
        }
    }
    
    private func generateInvite() {
        SubscriptionManager.shared.generateInviteLink {[weak self] url in
            let items = [url]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            runOnMain {
                self?.present(ac, animated: true)
            }
        }
    }
    
    @IBAction @objc func restoreAction() {
        isPurchasing = true
        SubscriptionManager.shared.restorePurchases {[weak self] subscriptionType in
            DispatchQueue.main.async {
                if subscriptionType == .pro {
                    self?.dismiss(animated: true)
                } else {
                    NotificationManager.shared.showError("Purchase is not completed. If payment completed - Restore the purchase.")
                }
                self?.isPurchasing = false
            }
        }
    }
    
    @IBAction @objc func policyAction() {
        GainyAnalytics.logEvent("content_privacy_policy_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PurchaseViewController"])
        if let url = URL(string: Constants.Links.privacy) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction @objc func termsAction() {
        GainyAnalytics.logEvent("content_terms_of_service_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PurchaseViewController"])
        if let url = URL(string: Constants.Links.tos) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PurchaseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > (UIScreen.main.bounds.width - 48) / 2.0 {            
            self.isInvite = true
            pageControl.currentPage = 1
        } else {
            
            self.isInvite = false
            pageControl.currentPage = 0
        }
    }
}

extension PurchaseViewController: PurchasesProductsViewDelegate {
    func productChanged(view: PurchasesProductsView, product: Product) {
        guard !isInvite else {return}
        
        infoLbl.text = purchasesView.selectedProduct?.terms ?? ""
    }
}
