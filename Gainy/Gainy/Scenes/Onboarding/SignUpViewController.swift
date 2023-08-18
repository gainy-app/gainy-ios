//
//  SignUpViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 27.04.2023.
//

import UIKit
import GainyCommon

struct SignUpCellModel {
    let title: String
    var mainImage: UIImage
}

final class SignUpViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var enterWithAppleButton: BorderButton!
    @IBOutlet private weak var enterWithGoogleButton: BorderButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    // MARK: - Private properties
    private var cellModels: [SignUpCellModel] = []
    
    weak var coordinator: OnboardingCoordinator?
    weak var authorizationManager: AuthorizationManager?
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //self.setUpNavigationBar()
        self.setUpContent()
        delay(1.0) {
            self.showIDFAIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        delay(0.3) {
            self.collectionView.reloadData()
            self.startTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.stopTimer()
    }
    
    @UserDefaultBool("isIDFAShown")
    private var isIDFAShown: Bool
    
    private func showIDFAIfNeeded() {
        guard !isIDFAShown else {return}
        let idfaVC = IDFARequestViewController.instantiate(.popups)
        idfaVC.delegate = self
        idfaVC.modalPresentationStyle = .fullScreen
        self.present(idfaVC, animated: true, completion: nil)
    }
    
    //MARK: - Timer
    private var stepTimer: Timer?
    
    private func startTimer() {
        stopTimer()
        stepTimer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true, block: {[weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }
            if self.pageControl.currentPage < self.cellModels.count {
                DispatchQueue.main.async {
                    self.collectionView.setContentOffset(.init(x: CGFloat(self.pageControl.currentPage + 1) * UIScreen.main.bounds.width, y: 0), animated: true)
                    GainyAnalytics.logEventAMP("intro_\(self.pageControl.currentPage + 2)_shown")
                }
            } else {
                self.stopTimer()
            }
        })
        stepTimer?.tolerance = 0.5
        if let stepTimer {
            RunLoop.current.add(stepTimer, forMode: .common)
        }
    }
    
    private func stopTimer() {
        stepTimer?.invalidate()
        stepTimer = nil
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var isAppleTap = false
    @IBAction func enterWithAppleButtonTap(_ sender: Any) {
        isAppleTap = true
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.", report: true)
            GainyAnalytics.logEvent("no_internet")
            return
        }
        showNetworkLoader()
        GainyAnalytics.logEvent("enter_with_acc_tapped", params: ["accountType": "apple"])
        self.authorizationManager?.authorizeWithApple(completion: { authorizationStatus in
            runOnMain{
                self.handleAuthorizationStatus(authorizationStatus: authorizationStatus)
            }
        })
    }
    
    @IBAction func enterWithGoogleButtonTap(_ sender: Any) {
        isAppleTap = false
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.", report: true)
            GainyAnalytics.logEvent("no_internet")
            return
        }
        showNetworkLoader()
        GainyAnalytics.logEvent("enter_with_acc_tapped", params: ["accountType": "google"])
        self.authorizationManager?.authorizeWithGoogle(self, completion: { authorizationStatus in
            DispatchQueue.main.async { [weak self] in
                self?.handleAuthorizationStatus(authorizationStatus: authorizationStatus)
            }
        })
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("authorization_close_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        self.coordinator?.popToRootModule()
    }
    
    @objc func backButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("authorization_back_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        self.coordinator?.popModule()
    }
    
    private func handleAuthorizationStatus(authorizationStatus: AuthorizationStatus) {
        
        self.hideLoader()
        if authorizationStatus == .authorizedFully {
            GainyAnalytics.logEventAMP("authorization_fully_authorized", params:["accountType": isAppleTap ? "apple" : "google"])
            if let finishFlow = self.coordinator?.finishFlow {
                self.coordinator?.dismissModule()
                finishFlow()
            }
            if GainyAnalytics.shared.isLogin {
                GainyAnalytics.logEvent("af_login", params: ["af_registration_method" : isAppleTap ? "apple" : "google"])
                GainyAnalytics.logEvent("login_success", params: ["af_registration_method" : isAppleTap ? "apple" : "google"])
            }
        } else if authorizationStatus == .authorizedNeedCreateProfile {
            
            if RemoteConfigManager.shared.blockUsage {
                GainyAnalytics.logEventAMP("authorization_need_create_profile")
                let alertVC = UIAlertController(title: "Registration blocked", message: "Sorry, we are not accepting new users currently since company is terminating. Existing users can only withdraw and not invest.", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction.init(title: "OK", style: .destructive))
                self.present(alertVC, animated: true)
                return
            } else {
                self.coordinator?.pushPersonalInfoViewController()
            }
        } else if authorizationStatus != .authorizingCancelled {
            GainyAnalytics.logEvent("authorization_failed", params:["accountType": isAppleTap ? "apple" : "google"])
            NotificationManager.shared.showError("Sorry... Failed to authorize. Please try again later.", report: true)
        } else if authorizationStatus == .authorizingCancelled {
            GainyAnalytics.logEvent("authorization_cancelled", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        }
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14),
                NSAttributedString.Key.kern: 1.25]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.title = ""
        let backImage = UIImage(named: "iconArrowLeft")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.navigationItem.rightBarButtonItems = [closeItem]
    }
    
    private func setUpContent() {
        cellModels = [SignUpCellModel.init(title: "Invest in the next big thing without hours of research", mainImage: UIImage(named: "sign_up_intro1")!),
                      SignUpCellModel.init(title: "Make safer investments with risk optimization and diversification", mainImage: UIImage(named: "sign_up_intro2")!),
                      SignUpCellModel.init(title: "Personalized investment advice based on your goals", mainImage: UIImage(named: "sign_up_intro3")!),
                      SignUpCellModel.init(title: "Succeed in any market conditions with proven strategies", mainImage: UIImage(named: "sign_up_intro4")!)]
        configure()
        self.enterWithAppleButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
        self.enterWithGoogleButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
    }
        
}


// MARK: - UICollectionViewDataSource
extension SignUpViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = cellModels[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintCell.reuseIdentifier, for: indexPath) as? HintCell else { return UICollectionViewCell() }
        cell.configure(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (cellModels.count - 1) {
            stopTimer()
        } else {
            startTimer()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SignUpViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: UIScreen.main.bounds.width,
                           height: collectionView.bounds.height)
        print(size)
        return size
    }
}

private extension SignUpViewController {
    func configure() {
        collectionView.register(HintCell.nib, forCellWithReuseIdentifier: HintCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = cellModels.count
        pageControl.currentPage = 0
        GainyAnalytics.logEventAMP("intro_1_shown")
    }
}

extension SignUpViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        GainyAnalytics.logEventAMP("intro_\(pageControl.currentPage + 1)_shown")
    }
}

extension SignUpViewController: IDFARequestViewControllerDelegate {
    
    func didChooseResponse() {
        
        isIDFAShown = true
    }
}
