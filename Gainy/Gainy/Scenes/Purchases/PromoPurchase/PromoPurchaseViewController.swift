//
//  PromoPurchaseViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 14.06.2022.
//

import UIKit
import Foundation
import AVFoundation
import GainyAPI

final class PromoPurchaseViewController: BaseViewController {
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - Player
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    //MARK: - Outlets
    @IBOutlet private weak var spacemanView: UIImageView!
    @IBOutlet private weak var extraCover: UIImageView!
    @IBOutlet private weak var orbitView: UIImageView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var restoreBtn: BorderButton!
    @IBOutlet private weak var infoLbl: UILabel!
    @IBOutlet private weak var productsView: PromoPurchasesProductsView! {
        didSet {
            productsView.delegate = self
        }
    }
    @IBOutlet private weak var mainScroll: UIScrollView!
    @IBOutlet private weak var bottomMargin: NSLayoutConstraint!
    
    private var isPurchasing: Bool = false {
        didSet {
            productsView.blockUI = isPurchasing
            purchaseBtn.isEnabled = !isPurchasing
            restoreBtn.isEnabled = !isPurchasing
            if isPurchasing {
                indicatorView.startAnimating()
            } else {
                indicatorView.stopAnimating()
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
        
        self.orbitView.transform = .init(scaleX: 0.7, y: 0.7)
        
        paused = false
        
        NotificationCenter.default.publisher(for: NotificationManager.subscriptionChangedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] notif in
                if let subscriptionType = notif.userInfo?["type"] as? SuscriptionType {
                    if subscriptionType == .pro {
                        self?.dismiss(animated: true)
                        GainyAnalytics.logEvent("dismiss_purchase_view")
                    } else {
                        
                    }
                    self?.isPurchasing = false
                }
            }
            .store(in: &self.cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        infoLbl.text = productsView.selectedProduct?.terms ?? ""
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPlayer()
        avPlayer.play()
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
        GainyAnalytics.logEvent("hide_purchase_view")
    }
    
    @IBAction @objc func purchaseAction() {
        
        if let product = productsView.selectedProduct {
            isPurchasing = true
            SubscriptionManager.shared.purchaseProduct(product: product)
            GainyAnalytics.logEvent("purchase_subscribe_tap")
        }
    }
    
    @IBAction @objc func restoreAction() {
        GainyAnalytics.logEvent("purchase_restore_tap")
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
        GainyAnalytics.logEvent("purchase_policy_tap")
        GainyAnalytics.logEvent("content_privacy_policy_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PromoPurchaseViewController"])
        if let url = URL(string: Constants.Links.privacy) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction @objc func termsAction() {
        GainyAnalytics.logEvent("purchase_tos_tap")
        GainyAnalytics.logEvent("content_terms_of_service_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PromoPurchaseViewController"])
        if let url = URL(string: Constants.Links.tos) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    //MARK: - Keyboard
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        
        bottomMargin.constant = 16.0 + (keyboardSize?.height ?? 0.0)
        
        mainScroll.setContentOffset(.init(x: 0, y: 350), animated: true)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        
        bottomMargin.constant = 16.0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PromoPurchaseViewController: PromoPurchasesProductsViewDelegate {
    func applyPromo(view: PromoPurchasesProductsView) {
        GainyAnalytics.logEvent("purchase_promo_apply_tap", params: ["code" : productsView.promoCode])
        self.isPurchasing = true
        let promoCode = productsView.promoCode
        Network.shared.apollo.fetch(query: ValidatePromoCodeQuery.init(code: promoCode)) {[weak self] result in
            switch result {
            case .success(let data):
                if let config = data.data?.getPromocode?.config {
                    if let productsMap = self?.getDictionary(config)?["tariff_mapping"] as? [String : String] {
                        let productId = productsMap[self?.productsView.selectedProduct?.identifier ?? ""]
                        GainyAnalytics.logEvent("purchase_promo_apply_done", params: ["code" : promoCode, "productId" : productId])
                        let product = Product.getProductByID(productId ?? "")
                    DispatchQueue.main.async {
                        self?.isPurchasing = false
                        self?.productsView.isCodeValid = true
                        self?.productsView.selectedProduct = product
                        self?.infoLbl.text = self?.productsView.selectedProduct?.terms ?? ""
                    }
                    } else {
                        DispatchQueue.main.async {
                            GainyAnalytics.logEvent("purchase_promo_apply_failed", params: ["code" : promoCode])
                            self?.productsView.isCodeValid = false
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        GainyAnalytics.logEvent("purchase_promo_apply_failed", params: ["code" : promoCode])
                        self?.productsView.isCodeValid = false
                    }
                }
                DispatchQueue.main.async {
                    self?.isPurchasing = false
                }
                break
            case .failure(_):
                DispatchQueue.main.async {
                    GainyAnalytics.logEvent("purchase_promo_apply_failed", params: ["code" : promoCode])
                    self?.isPurchasing = false
                    self?.productsView.isCodeValid = false
                }
                break
            }
        }
    }
    
    private func getDictionary(_ str: String) -> [String: Any]? {
        let data = Data(str.utf8)

        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // try to read out a string array
                return json
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return nil
    }
}

