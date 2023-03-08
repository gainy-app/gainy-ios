//
//  IntroductionViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/30/21.
//

import UIKit
import PureLayout
import AVFoundation

class IntroductionViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var captionsCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeftConstraint: NSLayoutConstraint!
    
    public weak var coordinator: OnboardingCoordinator?

    private var indicatorViewProgressObject: ClockwiseProgressIndicatorViewObject?
    private var indicatorView: UIView?
    
    private var nextButtonImage: UIImageView = UIImageView.newAutoLayout()
    
    private var currentCaptionIndex = 0 {
        didSet {
            if UserDefaults.isFirstLaunch() {
                GainyAnalytics.logEvent("intro_\(currentCaptionIndex)_shown")
            }
        }
    }
    private let captions = [
        NSLocalizedString("Every TTF is made up of carefully picked stocks around a central theme or cause, e.g. EV, FinTech, Cybersecurity.", comment: "Every TTF is made up of carefully picked stocks around a central theme or cause, e.g. EV, FinTech, Cybersecurity."),
        NSLocalizedString("TTFs are automatically rebalanced when a new company becomes available or an existing stock is underperforming.", comment: "TTFs are automatically rebalanced when a new company becomes available or an existing stock is underperforming."),
        NSLocalizedString("Invest a set amount starting from $10 into a theme that excites you and Gainy will do the rest.", comment: "Invest a set amount starting from $10 into a theme that excites you and Gainy will do the rest."),
        NSLocalizedString("Safely connect all your brokerage accounts and track how your portfolio performs in one place.", comment: "Safely connect all your brokerage accounts and track how your portfolio performs in one place.")
    ]
    private let imageNames = [
        "Screen 1",
        "Screen 2",
        "Screen 3",
        "Screen 4",
    ]
    
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.addIndicatorView()
        self.setUpNavigationBar()
        self.setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.title = NSLocalizedString("Introduction", comment: "Introduction").uppercased()
        self.setUpNavigationBar()
        self.startLoading()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopLoading()
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
    
    @objc func backButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("introduction_back_button_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
        let rect = CGRect(x: 0.0, y: self.captionsCollectionView.bounds.height * CGFloat(self.currentCaptionIndex - 1), width: self.view.bounds.width, height: self.captionsCollectionView.bounds.height)
        self.captionsCollectionView.scrollRectToVisible(rect, animated: true)
        switch self.currentCaptionIndex {
        case 0:
            GainyAnalytics.logEvent("back_to_launch_screen", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
            self.coordinator?.popModule()
        case 1:
            GainyAnalytics.logEvent("back_to_first_introduction", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
            self.captionsCollectionView.scrollRectToVisible(rect, animated: true)
            self.currentCaptionIndex = 0
            self.indicatorViewProgressObject?.progress = Float(0.0)
        case 2:
            GainyAnalytics.logEvent("back_to_second_introduction", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
            self.captionsCollectionView.scrollRectToVisible(rect, animated: true)
            self.currentCaptionIndex = 1 
            self.indicatorViewProgressObject?.progress = Float(0.25)
        case 3:
            GainyAnalytics.logEvent("back_to_third_introduction", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
            self.captionsCollectionView.scrollRectToVisible(rect, animated: true)
            self.currentCaptionIndex = 2
            self.indicatorViewProgressObject?.progress = Float(0.75)
            self.setProgressIndicatorHidden(hidden: false)
            
        default: fatalError("Unhandled behaviour")
        }
        
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("introduction_close_button_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
        self.coordinator?.popToRootModule()
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("introduction_next_button_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
        let rect = CGRect(x: 0.0, y: self.captionsCollectionView.bounds.height * CGFloat(self.currentCaptionIndex + 1), width: self.view.bounds.width, height: self.captionsCollectionView.bounds.height)
        switch self.currentCaptionIndex {
        case 0:
            GainyAnalytics.logEvent("next_to_second_introduction", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
            self.captionsCollectionView.scrollRectToVisible(rect, animated: true)
            self.currentCaptionIndex = 1
            self.indicatorViewProgressObject?.progress = Float(0.25)
        case 1:
            GainyAnalytics.logEvent("next_to_third_introduction", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
            self.captionsCollectionView.scrollRectToVisible(rect, animated: true)
            self.currentCaptionIndex = 2
            self.indicatorViewProgressObject?.progress = Float(0.75)
        case 2:
            GainyAnalytics.logEvent("next_to_last_introduction", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
            self.captionsCollectionView.scrollRectToVisible(rect, animated: true)
            self.currentCaptionIndex = 3
            self.indicatorViewProgressObject?.progress = Float(1.0)
            self.setProgressIndicatorHidden(hidden: true)
            
        case 3:
            GainyAnalytics.logEvent("next_to_personalization", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
            if let coordinator = self.coordinator {
                if coordinator.authorizationManager.isAuthorized() {
                    self.coordinator?.pushPersonalInfoViewController()
                } else {
                    self.coordinator?.pushAuthorizationViewController(isOnboardingDone: true)
                }
            }
        default: fatalError("Unhandled behaviour")
        }
    }
        
    private func setUpCollectionView() {
        
        self.captionsCollectionView.delegate = self
        self.captionsCollectionView.dataSource = self
        self.captionsCollectionView.register(UINib.init(nibName: "IntroductionCaptionCell", bundle: Bundle.main), forCellWithReuseIdentifier: IntroductionCaptionCell.reuseIdentifier)
        self.captionsCollectionView.contentInset = UIEdgeInsets.init(top: CGFloat(0.0), left: CGFloat(0.0), bottom: CGFloat(0.0), right: CGFloat(0.0))
        self.captionsCollectionView.contentInsetAdjustmentBehavior = .never
        self.captionsCollectionView.isScrollEnabled = true
        self.captionsCollectionView.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout.init()
        layout.headerReferenceSize = CGSize.zero
        layout.footerReferenceSize = CGSize.zero
        layout.sectionInset = UIEdgeInsets.init(top: 0, left:0, bottom:0, right:0)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = .vertical
        self.captionsCollectionView.collectionViewLayout = layout;
        self.captionsCollectionView.contentInset = UIEdgeInsets.zero
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.compactRoundedSemibold(14),
                NSAttributedString.Key.kern: 1.1]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.title = NSLocalizedString("Introduction", comment: "Introduction").uppercased()
        let backImage = UIImage(named: "iconArrowLeft")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.white
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItems = [backItem]
        self.navigationItem.rightBarButtonItems = [closeItem]
        
        let image = UIImage.init(named: "arrow-down-white")
        self.nextButtonImage.image = image
        self.nextButton.addSubview(self.nextButtonImage)
        self.nextButtonImage.translatesAutoresizingMaskIntoConstraints = false
        self.nextButtonImage.autoSetDimensions(to: CGSize.init(width: 14, height: 8))
        self.nextButtonImage.autoCenterInSuperview()
    }
    
    public func addIndicatorView() {
        let progressObject = ClockwiseProgressIndicatorViewObject.init(progress: 0.0, color: UIColor.white)
        let progressView = ClockwiseProgressIndicatorView(progressObject: progressObject)
        let hosting = CustomHostingController.init(shouldShowNavigationBar: false, rootView: progressView)
        hosting.view.frame = CGRect.init(x: 0, y: 0, width: 35, height: 35)
        hosting.view.backgroundColor = UIColor.clear
        view.addSubview(hosting.view)
        hosting.view.autoPinEdge(.leading, to: .leading, of: view, withOffset: CGFloat(30.5))
        hosting.view.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: CGFloat(25.5))
        hosting.view.autoSetDimension(.height, toSize: CGFloat(35))
        hosting.view.autoSetDimension(.width, toSize: CGFloat(35))
        self.indicatorViewProgressObject = progressObject
        self.indicatorView = hosting.view
    }
    
    private func setProgressIndicatorHidden(hidden: Bool) {
        
        let nextTitle = ""
        let personaliseTitle = NSLocalizedString("Start to gain more!", comment: "Start to gain more!")
        let nextButtonTitle = hidden ? personaliseTitle : nextTitle
        
        self.nextButtonImage.isHidden = hidden
        UIView.animate(withDuration: 0.175) {
            
            self.nextButtonImage.alpha = 0.0
            self.nextButton.titleLabel?.alpha = 0.0
            
        } completion: { success in
            
            self.nextButton.setTitle(nextButtonTitle, for: UIControl.State.normal)
            UIView.animate(withDuration: 0.175) {
                
                self.nextButtonImage.alpha = 1.0
                self.nextButton.titleLabel?.alpha = 1.0
            }
        }
        
        self.view.setNeedsLayout()
        self.nextButtonRightConstraint.constant = hidden ? 40.0 : 24.0
        self.nextButtonHeightConstraint.constant = hidden ? 64.0 : 48.0
        self.nextButtonWidthConstraint.constant = hidden ? UIScreen.main.bounds.width - 80 : 48.0
        
        UIView.animate(withDuration: 0.35) {
            
            self.indicatorView?.alpha = hidden ? 0.0 : 1.0
            self.view.layoutIfNeeded()
        }
    }
}

extension IntroductionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: IntroductionCaptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: IntroductionCaptionCell.reuseIdentifier, for: indexPath) as! IntroductionCaptionCell
        let caption = captions[indexPath.row]
        let imageName = imageNames[indexPath.row]
        
        cell.captionText = caption
        cell.imageName = imageName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.captions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.size.width
        let size = CGSize.init(width: width, height: collectionView.frame.height)

        return size
    }
}

extension IntroductionViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let middle = scrollView.contentOffset.y + (self.captionsCollectionView.bounds.height / 2.0)
        let height = self.captionsCollectionView.bounds.height
        let currentIndex = Int(middle) / Int(height)
        switch currentIndex {
        case 0:
            self.setProgressIndicatorHidden(hidden: false)
            self.indicatorViewProgressObject?.progress = Float(0.0)
        case 1:
            self.setProgressIndicatorHidden(hidden: false)
            self.indicatorViewProgressObject?.progress = Float(0.25)
        case 2:
            self.setProgressIndicatorHidden(hidden: false)
            self.indicatorViewProgressObject?.progress = Float(0.75)
        
        case 3:
            self.indicatorViewProgressObject?.progress = Float(1.0)
            self.setProgressIndicatorHidden(hidden: true)
        
        default: break
        }
        self.currentCaptionIndex = currentIndex
    }
    
    
}
