//
//  IntroductionViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/30/21.
//

import UIKit
import PureLayout

class IntroductionViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var captionsTopConstraint: NSLayoutConstraint!
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
        NSLocalizedString("Collections\ntailored to\nyou", comment: "Collections tailored to you"),
        NSLocalizedString("Highlights\nand\nindustry\nbenchmarks", comment: "Highlights and industry benchmarks"),
        NSLocalizedString("Search,\nfilters,\nand stock\ncomparison", comment: "Search, filters, and stock comparison"),
        NSLocalizedString("Yes, it's\npersonalized", comment: "Yes, it's personalized")
    ]
    private let captionSizes = [Float(156), Float(204), Float(204), Float(108)]
    
    
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
        
        switch self.currentCaptionIndex {
        case 0:
            self.coordinator?.popModule()
        case 1:
            self.captionsCollectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .centeredHorizontally, animated: true)
            self.currentCaptionIndex = 0
            self.indicatorViewProgressObject?.progress = Float(0.0)
        case 2:
            self.captionsCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: true)
            self.currentCaptionIndex = 1
            self.indicatorViewProgressObject?.progress = Float(0.25)
        case 3:
            self.captionsCollectionView.scrollToItem(at: IndexPath.init(row: 2, section: 0), at: .centeredHorizontally, animated: true)
            self.currentCaptionIndex = 2
            self.indicatorViewProgressObject?.progress = Float(0.75)
            self.setProgressIndicatorHidden(hidden: false)
            
        default: fatalError("Unhandled behaviour")
        }
        
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        self.coordinator?.popToRootModule()
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        
        switch self.currentCaptionIndex {
        case 0:
            self.captionsCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: true)
            self.currentCaptionIndex = 1
            self.indicatorViewProgressObject?.progress = Float(0.25)
        case 1:
            self.captionsCollectionView.scrollToItem(at: IndexPath.init(row: 2, section: 0), at: .centeredHorizontally, animated: true)
            self.currentCaptionIndex = 2
            self.indicatorViewProgressObject?.progress = Float(0.75)
        case 2:
            self.captionsCollectionView.scrollToItem(at: IndexPath.init(row: 3, section: 0), at: .centeredHorizontally, animated: true)
            self.currentCaptionIndex = 3
            self.indicatorViewProgressObject?.progress = Float(1.0)
            self.setProgressIndicatorHidden(hidden: true)
            
        case 3:
            
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
        self.captionsTopConstraint.constant = UIScreen.main.bounds.height * 0.5 - 72
        
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
        let personaliseTitle = NSLocalizedString("Let's personalise it!", comment: "Let's personalise it!")
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
        let captionHeight = captionSizes[indexPath.row]
        cell.captionHeight = captionHeight
        cell.captionText = caption
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.captions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let caption = self.captions[indexPath.row]
        let width = UIScreen.main.bounds.size.width
        var size = CGSize.init(width: width, height: 260)

        return size
    }
}
