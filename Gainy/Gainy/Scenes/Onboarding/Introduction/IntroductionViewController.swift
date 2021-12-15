//
//  IntroductionViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/30/21.
//

import UIKit
import PureLayout

class IntroductionViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var captionsCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeftConstraint: NSLayoutConstraint!
    
    public weak var coordinator: OnboardingCoordinator?

    private var indicatorViewProgressObject: ClockwiseProgressIndicatorViewProgress?
    private var indicatorView: UIView?
    
    private var currentCaptionIndex = 0
    private let captions = [
        NSLocalizedString("Discover collections\nof stocks that match\nyour goals", comment: "Discover collections\nof stocks that match\nyour goals"),
        NSLocalizedString("See highlights\nand benchmarks\nto support yourn\ndecisions", comment: "See highlights\nand benchmarks\nto support yourn\ndecisions"),
        NSLocalizedString("Connect all your\nbrokerage accounts\nand get insights on\nhow to improve them", comment: "Connect all your\nbrokerage accounts\nand get insights on\nhow to improve them"),
        NSLocalizedString("Compare and sell\nunderperforming\nstocks and improve\nyour gains", comment: "Compare and sell\nunderperforming\nstocks and improve\nyour gains")
    ]
    private let imageNames = [
        "Screen 1",
        "Screen 2",
        "Screen 3",
        "Screen 4",
    ]
    
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
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func backButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("introduction_back_button_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Introduction"])
        let rect = CGRect(x: self.view.bounds.width * CGFloat(self.currentCaptionIndex - 1), y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height)
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
        let rect = CGRect(x: self.view.bounds.width * CGFloat(self.currentCaptionIndex + 1), y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height)
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
            self.coordinator?.pushPersonalizationPickInterestsViewController()
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
        layout.scrollDirection = .horizontal
        self.captionsCollectionView.collectionViewLayout = layout;
        self.captionsCollectionView.contentInset = UIEdgeInsets.zero
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.title = NSLocalizedString("Introduction", comment: "Introduction").uppercased()
        let backImage = UIImage(named: "iconArrowLeft")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.navigationItem.rightBarButtonItems = [closeItem]
    }
    
    public func addIndicatorView() {
        let progressObject = ClockwiseProgressIndicatorViewProgress.init(progress: 0.0)
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
        
        let nextTitle = NSLocalizedString("Next", comment: "Next")
        let personaliseTitle = NSLocalizedString("Start to gain more!", comment: "Start to gain more!")
        let nextButtonTitle = hidden ? personaliseTitle : nextTitle
        
        UIView.animate(withDuration: 0.175) {
            
            self.nextButton.titleLabel?.alpha = 0.0
            
        } completion: { success in
            
            self.nextButton.setTitle(nextButtonTitle, for: UIControl.State.normal)
            UIView.animate(withDuration: 0.175) {
                
                self.nextButton.titleLabel?.alpha = 1.0
            }
        }
        
        self.view.setNeedsLayout()
        self.nextButtonRightConstraint.constant = hidden ? 40.0 : 24.0
        self.nextButtonHeightConstraint.constant = hidden ? 64.0 : 48.0
        self.nextButtonWidthConstraint.constant = hidden ? UIScreen.main.bounds.width - 80 : 104.0
        
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
        
        let middle = scrollView.contentOffset.x + (self.view.bounds.width / 2.0)
        let width = self.view.bounds.width
        let currentIndex = Int(middle) / Int(width)
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
