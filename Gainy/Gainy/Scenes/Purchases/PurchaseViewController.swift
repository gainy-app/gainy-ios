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
    @IBOutlet weak var promoProductView: PromoPurchasesProductsView! {
        didSet {
            promoProductView.delegate = self
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
    @IBOutlet private weak var applyCodeButton: UIButton!
    @IBOutlet private weak var inviteView: PurchaseInviteView!
    @IBOutlet private weak var infoLbl: UILabel!
    @IBOutlet private weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet private weak var mainScroll: UIScrollView!
    
    private var isPurchasing: Bool = false {
        didSet {
            promoProductView.blockUI = isPurchasing
            purchaseBtn.isEnabled = !isPurchasing
            restoreBtn.isEnabled = !isPurchasing
            if isPurchasing {
                indicatorView.startAnimating()
            } else {
                indicatorView.stopAnimating()
            }
        }
    }
    
    private var isPromoMode: Bool = false {
        didSet {
            if isPromoMode {
                pageControl.isHidden = true
                purchasesScroll.isHidden = true
                promoProductView.isHidden = false
                applyCodeButton.setTitle("Cancel code", for: .normal)
                infoLbl.text = promoProductView.selectedProduct?.terms ?? ""
                purchaseBtn.setTitle("Continue".uppercased(), for: .normal)
            } else {
                pageControl.isHidden = false
                purchasesScroll.isHidden = false
                promoProductView.isHidden = true
                applyCodeButton.setTitle("Apply code", for: .normal)
                updateWithInvite(isInvite)
            }
        }
    }
    
    private var isInvite: Bool = false {
        didSet {
            updateWithInvite(isInvite)
        }
    }
    
    private func updateWithInvite(_ isInvite: Bool) {
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
            infoLbl.text = "Free month will be granted after other user will signup using the provided link. You need to check the Profile regarding your subscription status.\nIf user already created a profile in Gainy - no promotion will be granted.\nInvite can be used only once by other user. Amount of invites are unlimited."
        } else {
            inviteView.isSelected = false
            purchaseBtn.setTitle("Continue".uppercased(), for: .normal)
            infoLbl.text = purchasesView.selectedProduct?.terms ?? ""
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
        
        self.orbitView.transform = .init(scaleX: self.isInvite ? 1.0 : 0.7, y: self.isInvite ? 1.0 : 0.7)
        
        paused = false
        
        NotificationCenter.default.publisher(for: NotificationManager.subscriptionChangedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] notif in
                if let subscriptionType = notif.userInfo?["type"] as? SuscriptionType {
                    if subscriptionType == .pro {
                            self?.dismiss(animated: true)
                            self?.cancellables.removeAll()
                            GainyAnalytics.logEvent("dismiss_purchase_view")
                    }
                    self?.isPurchasing = false
                }
            }
            .store(in: &self.cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        applyCodeButton.isHidden = !RemoteConfigManager.shared.isApplyCodeBtnVisible
        infoLbl.text = purchasesView.selectedProduct?.terms ?? ""
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
    
    //MARK: - Actions
    
    @IBAction private func closeAction() {
        dismiss(animated: true)
        GainyAnalytics.logEvent("hide_purchase_view")
    }
    
    @IBAction @objc func purchaseAction() {
        if isPromoMode {
            if let product = promoProductView.selectedProduct {
                isPurchasing = true
                SubscriptionManager.shared.purchaseProduct(product: product, with: promoProductView.isCodeValid ? promoProductView.promoCode : "")
                GainyAnalytics.logEvent("purchase_subscribe_tap")
            }
        } else {
            if isInvite {
                generateInvite()
                GainyAnalytics.logEvent("purchase_invite_tap")
            } else {
                    if let product = purchasesView.selectedProduct {
                        isPurchasing = true
                        SubscriptionManager.shared.purchaseProduct(product: product)
                        GainyAnalytics.logEvent("purchase_subscribe_tap")
                    }
            }
        }      
    }
    
    private func generateInvite() {
        SubscriptionManager.shared.generateInviteLink {[weak self] url in
            let items = [url]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            GainyAnalytics.logEvent("purchase_invite_show")
            runOnMain {
                self?.present(ac, animated: true)
            }
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
        GainyAnalytics.logEvent("content_privacy_policy_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PurchaseViewController"])
        if let url = URL(string: Constants.Links.privacy) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction @objc func termsAction() {
        GainyAnalytics.logEvent("purchase_tos_tap")
        GainyAnalytics.logEvent("content_terms_of_service_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PurchaseViewController"])
        if let url = URL(string: Constants.Links.tos) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func applyCodeAction(_ sender: Any) {
        isPromoMode.toggle()
        if isPromoMode {
            GainyAnalytics.logEvent("purchase_enter_code_tap")
        } else {
            GainyAnalytics.logEvent("purchase_cancel_code_tap")
            promoProductView.clearPromoText()
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
        GainyAnalytics.logEvent("purchase_product_selected", params: ["productID" : purchasesView.selectedProduct?.identifier ?? ""])
        infoLbl.text = purchasesView.selectedProduct?.terms ?? ""
    }
}

extension PurchaseViewController: PromoPurchasesProductsViewDelegate {
    func applyPromo(view: PromoPurchasesProductsView) {
        GainyAnalytics.logEvent("purchase_promo_apply_tap", params: ["code" : promoProductView.promoCode])
        self.isPurchasing = true
        let promoCode = promoProductView.promoCode
        Network.shared.apollo.fetch(query: ValidatePromoCodeQuery.init(code: promoCode)) {[weak self] result in
            switch result {
            case .success(let data):
                if let config = data.data?.getPromocode?.config {
                    if let productsMap = self?.getDictionary(config)?["tariff_mapping"] as? [String : String] {
                        let productId = productsMap[self?.promoProductView.selectedProduct?.identifier ?? ""]
                        GainyAnalytics.logEvent("purchase_promo_apply_done", params: ["code" : promoCode, "productId" : productId])
                        let product = Product.getProductByID(productId ?? "")
                    DispatchQueue.main.async {
                        self?.isPurchasing = false
                        self?.promoProductView.isCodeValid = true
                        self?.promoProductView.selectedProduct = product
                        self?.infoLbl.text = self?.promoProductView.selectedProduct?.terms ?? ""
                    }
                    } else {
                        DispatchQueue.main.async {
                            GainyAnalytics.logEvent("purchase_promo_apply_failed", params: ["code" : promoCode])
                            self?.promoProductView.isCodeValid = false
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        GainyAnalytics.logEvent("purchase_promo_apply_failed", params: ["code" : promoCode])
                        self?.promoProductView.isCodeValid = false
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
                    self?.promoProductView.isCodeValid = false
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
