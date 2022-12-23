//
//  PersonalizationIndicatorsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/6/21.
//

import UIKit
import AVFoundation

enum PersonalizationTab: Int {
    case investmentsGoals = 0
    case marketReturns
    case investmentHorizon
    case moneySourceView
    case damageOfFailure
    case stockMarketRisks
    case investingApproach
}

class PersonalizationIndicatorsViewController: BaseViewController {
 
    public weak var coordinator: OnboardingCoordinator?
    public weak var mainCoordinator: MainCoordinator?
    
    @IBOutlet weak var firstSectionStackViewVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondSectionStackViewVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdSectionStackViewVerticalConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstSectionStackView: UIStackView!
    @IBOutlet weak var secondSectionStackView: UIStackView!
    @IBOutlet weak var thirdSectionStackView: UIStackView!
    
    @IBOutlet weak var lastSectionStackView: UIStackView!
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sliderViewInvestmentGoals: PersonalizationSliderSectionView!
    @IBOutlet weak var marketReturnsSourceView: PersonalizationTitlePickerSectionView!
    
    @IBOutlet weak var sliderViewInvestmentHorizon: PersonalizationSliderSectionView!
    @IBOutlet weak var urgentMoneySourceView: PersonalizationTitlePickerSectionView!
    
    @IBOutlet weak var sliderViewDamageOfFailure: PersonalizationSliderSectionView!
    @IBOutlet weak var sliderViewStockMarketRisks: PersonalizationSliderSectionView!
    
    @IBOutlet weak var investingApproachSourceView: PersonalizationTitlePickerSectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    private var nextButtonUnavailable: Bool = true {
        didSet {
            self.nextButton.layer.borderColor = UIColor.clear.cgColor
            self.nextButton.backgroundColor = self.nextButtonUnavailable ? UIColor.init(hexString: "#B1BDC8"): UIColor.init(hexString: "#0062FF")
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    private var indicatorViewProgressObject: ClockwiseProgressIndicatorViewObject?
    private var indicatorView: UIView?
    private var currentTab: PersonalizationTab = .investmentsGoals
    
    private var selectedMarketReturns: [PersonalizationInfoValue]?
    private var selectedSources: [PersonalizationInfoValue]?
    private var selectedApproaches: [PersonalizationInfoValue]?
    
    private var videoURL: URL?
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.addIndicatorView()
        self.setUpNavigationBar()
        
        self.setUpInvestmentGoalsView()
        self.setUpMarketReturnsView()
        
        self.setUpInvestmentHorizonView()
        self.setUpUrgentMoneySourceView()
        
        self.setUpDamageOfFailureView()
        self.setUpStockMarketRisksView()
        
        self.setUpInvestingApproachSourceView()
        self.setNextButtonHidden(isHidden: false)
        self.nextButtonUnavailable = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.setupPlayer(forTab: .investmentsGoals)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.title = NSLocalizedString("Personalization", comment: "Personalization").uppercased()
        if self.currentTab == .stockMarketRisks {
            self.indicatorViewProgressObject?.progress = Float(0.90)
        }
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupPlayer(forTab tab: PersonalizationTab) {
        
        var url: URL?
        switch tab {
        case .investmentsGoals:
            url = Bundle.main.url(forResource:"investment_goals", withExtension: "mp4")
        case .marketReturns:
            url = Bundle.main.url(forResource:"investment_goals", withExtension: "mp4")
        case .investmentHorizon:
            url = Bundle.main.url(forResource:"investment_horizon", withExtension: "mp4")
        case .moneySourceView:
            url = Bundle.main.url(forResource:"investment_horizon", withExtension: "mp4")
        case .damageOfFailure:
            url = Bundle.main.url(forResource:"investment_failure", withExtension: "mp4")
        case .stockMarketRisks:
            url = Bundle.main.url(forResource:"investment_failure", withExtension: "mp4")
        case .investingApproach:
            url = nil
        }
        
        guard let url = url else {
            return
        }
        
        if let videoURL = videoURL, videoURL.absoluteString == url.absoluteString {
            avPlayer.seek(to: .zero)
            avPlayer.play()
            return
        }
        
        self.videoURL = url
        
        if let layer = avPlayerLayer {
            layer.removeFromSuperlayer()
        }
        avPlayer = AVPlayer(url: url)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        avPlayerLayer.frame = view.layer.bounds
        self.playerView.backgroundColor = .clear
        self.playerView.layer.insertSublayer(avPlayerLayer, at: 0)
        
        avPlayer.play()
    }
    
    @objc func backButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("indicators_back_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        if self.currentTab == .investmentsGoals {
            
            if self.mainCoordinator != nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.coordinator?.popModule()
            }
            return
        }
        
        self.setCurrentTab(newTab: PersonalizationTab.init(rawValue: self.currentTab.rawValue - 1) ?? self.currentTab)
        let rect = CGRect.init(x: self.view.frame.size.width * CGFloat(self.currentTab.rawValue / 2), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("indicators_close_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        if self.mainCoordinator != nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.coordinator?.popToRootModule()
        }
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        
        if self.nextButtonUnavailable {
            NotificationManager.shared.showMessage(title: "", text: "Please, select the values above to proceed", cancelTitle: "OK", actions: nil)
            return
        }
        
        GainyAnalytics.logEvent("indicators_next_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        if self.currentTab == .investingApproach {
            
            if let mainCoordinator = self.mainCoordinator {
                let vc = OnboardingFinalizingViewController.instantiate(.onboarding)
                vc.mainCoordinator = mainCoordinator
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
            if let coordinator = self.coordinator {
                if coordinator.authorizationManager.isAuthorized() {
                    self.coordinator?.pushPersonalInfoViewController()
                } else {
                    self.coordinator?.pushAuthorizationViewController(isOnboardingDone: true)
                }
            }
            NotificationCenter.default.post(name: Notification.Name.init("startProfileTabUpdateNotification"), object: nil)
            return
        }
        
        self.setCurrentTab(newTab: PersonalizationTab.init(rawValue: self.currentTab.rawValue + 1) ?? self.currentTab)
        let rect = CGRect.init(x: self.view.frame.size.width * CGFloat(self.currentTab.rawValue / 2), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    private func setCurrentTab(newTab: PersonalizationTab) {
        
        let middleDfaultOffset = 150.0
        self.currentTab = newTab
        self.nextButtonUnavailable = (self.currentTab.rawValue % 2 == 0)
        
        let nextButtonTitle = NSLocalizedString("Next", comment: "Next button title")
        self.nextButton.setTitle(nextButtonTitle, for: UIControl.State.normal)
        if (self.currentTab.rawValue % 2 == 0) {
            self.setupPlayer(forTab: newTab)
        }
        
        self.playerView.isHidden = newTab == .investingApproach
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.view.setNeedsLayout()
            let show = self.currentTab.rawValue % 2 == 0
            if show {
                self.playerView.alpha = 1.0
                self.playerViewTopConstraint.constant = 0.0
            } else {
                self.playerView.alpha = 0.0
                self.playerViewTopConstraint.constant = -self.view.bounds.size.height
            }
            self.view.layoutIfNeeded()
        } completion: { success in
            
        }
        
        switch self.currentTab {
        case .investmentsGoals:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "investmentGoals", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.0)
            self.setMarketReturnsHidden(isHidden: true)
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.25) {
                self.firstSectionStackViewVerticalConstraint.constant = middleDfaultOffset
                self.view.layoutIfNeeded()
            } completion: { success in

            }
        case .marketReturns:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "marketReturns", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.25)
            self.setMarketReturnsHidden(isHidden: false)
            if let selectedMarketReturns = self.selectedMarketReturns {
                self.nextButtonUnavailable = selectedMarketReturns.count == 0
            } else {
                self.nextButtonUnavailable = true
            }
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.25) {
                self.firstSectionStackViewVerticalConstraint.constant = 0.0
                self.view.layoutIfNeeded()
            } completion: { success in

            }
        case .investmentHorizon:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "investmentHorizon", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.25)
            self.setMoneySourceViewHidden(isHidden: true)
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.25) {
                self.secondSectionStackViewVerticalConstraint.constant = middleDfaultOffset
                self.view.layoutIfNeeded()
            } completion: { success in

            }
        case .moneySourceView:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "moneySourceView", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.50)
            self.setMoneySourceViewHidden(isHidden: false)
            if let selectedSources = self.selectedSources {
                self.nextButtonUnavailable = selectedSources.count == 0
            } else {
                self.nextButtonUnavailable = true
            }
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.25) {
                self.secondSectionStackViewVerticalConstraint.constant = 0
                self.view.layoutIfNeeded()
            } completion: { success in

            }
        case .damageOfFailure:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "damageOfFailure", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.50)
            self.setStockMarketRisksHidden(isHidden: true)
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.25) {
                self.thirdSectionStackViewVerticalConstraint.constant = middleDfaultOffset
                self.view.layoutIfNeeded()
            } completion: { success in

            }
        case .stockMarketRisks:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "stockMarketRisks", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.75)
            self.setStockMarketRisksHidden(isHidden: false)
            self.nextButtonUnavailable = self.sliderViewStockMarketRisks.isInitialLayout
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.25) {
                self.thirdSectionStackViewVerticalConstraint.constant = 0
                self.view.layoutIfNeeded()
            } completion: { success in

            }
        case .investingApproach:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "investingApproach", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.90)
            let doneButtonTitle = NSLocalizedString("Next", comment: "Next button title")
            self.nextButton.setTitle(doneButtonTitle, for: UIControl.State.normal)
            if let selectedApproaches = self.selectedApproaches {
                self.nextButtonUnavailable = selectedApproaches.count == 0
            } else {
                self.nextButtonUnavailable = true
            }
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
        self.title = NSLocalizedString("Personalization", comment: "Personalization").uppercased()
        let backImage = UIImage(named: "iconArrowLeft")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.black
        if self.mainCoordinator != nil {
            self.navigationItem.leftBarButtonItems = [closeItem]
            self.mainCoordinator?.onboardingInfoBuilder.profileInterestIDs = []
        } else {
            self.navigationItem.leftBarButtonItems = [backItem]
            self.navigationItem.rightBarButtonItems = [closeItem]
        }
    }
    
    public func addIndicatorView() {
        
        let progressObject = ClockwiseProgressIndicatorViewObject.init(progress: 0.0, color: UIColor.black)
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
    
    private func setUpInvestmentGoalsView() {
        
        let title = NSLocalizedString("Investments goals", comment: "Investment Goals Title")
        let description = NSLocalizedString("What are your annual return expectations? Usually, the riskier you go the more money you make but the chance to lose increases as well.", comment: "Investment Goals Description")
        self.sliderViewInvestmentGoals.configureWith(title: title)
        self.sliderViewInvestmentGoals.configureWith(description: description)
        let minValueCaption = NSLocalizedString("Less risky", comment: "Investment Goals Min Caption")
        let maxValueCaption = NSLocalizedString("More rewards", comment: "Investment Goals Max Caption")
        self.sliderViewInvestmentGoals.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewInvestmentGoals.delegate = self
        self.sliderViewInvestmentGoals.configureWith(currentValue: 0.5)
    }
    
    private func setUpMarketReturnsView() {
        
        let title = NSLocalizedString("Average annual market return", comment: "Market Returns Title")
        let description = NSLocalizedString("Please tell us, what is an average market\nreturn in your opinion.", comment: "Market Returns Description")
        
        self.marketReturnsSourceView.configureWith(title: title)
        self.marketReturnsSourceView.configureWith(description: description)
        self.marketReturnsSourceView.itemSpacing = CGFloat(16.0)
        let sources: [PersonalizationInfoValue] = [.market_return_6,
                                                   .market_return_15,
                                                   .market_return_25,
                                                   .market_return_50]
        self.marketReturnsSourceView.configureWith(sources: sources)
        self.marketReturnsSourceView.delegate = self
    }
    
    private func setUpInvestmentHorizonView() {
        
        let title = NSLocalizedString("Investment horizon", comment: "Investment Horizon Title")
        let description = NSLocalizedString("When do you plan to use money that you\ninvested?", comment: "Investment Horizon Description")
        self.sliderViewInvestmentHorizon.configureWith(title: title)
        self.sliderViewInvestmentHorizon.configureWith(description: description)
        let minValueCaption = NSLocalizedString("Short", comment: "Investment Horizon Min Caption")
        let maxValueCaption = NSLocalizedString("Long", comment: "Investment Horizon Max Caption")
        self.sliderViewInvestmentHorizon.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewInvestmentHorizon.delegate = self
        self.sliderViewInvestmentHorizon.configureWith(currentValue: 0.5)
    }
    
    private func setUpUrgentMoneySourceView() {
        
        let title = NSLocalizedString("Urgent money source", comment: "Urgent Money Source Title")
        let description = NSLocalizedString("Where do you get money for unexpected large\npurchases?", comment: "Urgent Money Source Description")
        self.urgentMoneySourceView.configureWith(title: title)
        self.urgentMoneySourceView.configureWith(description: description)
        let sources: [PersonalizationInfoValue] = [.checking_savings,
                                                   .stock_investments,
                                                   .credit_card,
                                                   .other_loans]
        self.urgentMoneySourceView.configureWith(sources: sources)
        self.urgentMoneySourceView.delegate = self
    }
    
    private func setUpDamageOfFailureView() {
        
        let title = NSLocalizedString("Damage of failure", comment: "Damage of failure Title")
        let description = NSLocalizedString("If the investment doesn’t pan out, how serious\nis the consequence?", comment: "Damage of failure Description")
        self.sliderViewDamageOfFailure.configureWith(title: title)
        self.sliderViewDamageOfFailure.configureWith(description: description)
        let minValueCaption = NSLocalizedString("Very sensitive", comment: "Damage of failure Min Caption")
        let maxValueCaption = NSLocalizedString("Less sensitive", comment: "Damage of failure Max Caption")
        self.sliderViewDamageOfFailure.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewDamageOfFailure.delegate = self
        self.sliderViewDamageOfFailure.configureWith(currentValue: 0.5)
    }
    
    private func setUpStockMarketRisksView() {
        
        let title = NSLocalizedString("Stock market risks", comment: "Stock market risks Title")
        let description = NSLocalizedString("How risky do you think stock market is?", comment: "Stock market risks Description")
        self.sliderViewStockMarketRisks.configureWith(title: title)
        self.sliderViewStockMarketRisks.configureWith(description: description)
        let minValueCaption = NSLocalizedString("Less risky", comment: "Stock market risks Min Caption")
        let maxValueCaption = NSLocalizedString("Very risky", comment: "Stock market risks Max Caption")
        self.sliderViewStockMarketRisks.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewStockMarketRisks.delegate = self
        self.sliderViewStockMarketRisks.configureWith(currentValue: 0.5)
    }
    
    private func setUpInvestingApproachSourceView() {
        
        let title = NSLocalizedString("What is your experience\nwith trading?", comment: "Investing approach Title")
        let description = NSLocalizedString("What is your experience with trading?", comment: "Investing approach Description")
        self.investingApproachSourceView.configureWith(title: title)
        self.investingApproachSourceView.configureWith(description: "")
        let sources: [PersonalizationInfoValue] = [.never_tried,
                                                   .very_little,
                                                   .companies_i_believe_in,
                                                   .etfs_and_safe_stocks,
                                                   .advanced,
                                                   .daily_trader,
                                                   .investment_funds,
                                                   .professional,
                                                   .dont_trade_after_bad_experience]
        self.investingApproachSourceView.configureWith(sources: sources)
        self.investingApproachSourceView.delegate = self
    }
}

extension PersonalizationIndicatorsViewController {
    
    func setNextButtonHidden(isHidden: Bool) {
        
        UIView.animate(withDuration: 0.25) {
            self.nextButton.isHidden = isHidden
            self.nextButton.alpha = isHidden ? 0.0 : 1.0
        }
    }
    
    func setMarketReturnsHidden(isHidden: Bool) {
        
        self.marketReturnsSourceView.isHidden = isHidden
        self.firstSectionStackView.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.marketReturnsSourceView.alpha = isHidden ? 0.0 : 1.0
            self.firstSectionStackView.layoutIfNeeded()
        }
    }
    
    func setMoneySourceViewHidden(isHidden: Bool) {
        
        self.urgentMoneySourceView.isHidden = isHidden
        self.secondSectionStackView.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.urgentMoneySourceView.alpha = isHidden ? 0.0 : 1.0
            self.secondSectionStackView.layoutIfNeeded()
        }
    }
    
    func setStockMarketRisksHidden(isHidden: Bool) {
        
        self.sliderViewStockMarketRisks.isHidden = isHidden
        self.thirdSectionStackView.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.sliderViewStockMarketRisks.alpha = isHidden ? 0.0 : 1.0
            self.thirdSectionStackView.layoutIfNeeded()
        }
    }
}

extension PersonalizationIndicatorsViewController: PersonalizationTitlePickerSectionViewDelegate {
    
    func personalizationTitlePickerDidPickSources(sender: PersonalizationTitlePickerSectionView, sources: [PersonalizationInfoValue]?) {
        if marketReturnsSourceView == sender {
            self.selectedMarketReturns = sources
            if let selectedMarketReturns = self.selectedMarketReturns {
                self.nextButtonUnavailable = selectedMarketReturns.count == 0
                if (selectedMarketReturns.count == 0) {
                    self.coordinator?.onboardingInfoBuilder.averageMarketReturn = nil
                    self.mainCoordinator?.onboardingInfoBuilder.averageMarketReturn = nil
                } else {
                    if let source = sources?.first {
                        var averageMarketReturn = source.description()
                        averageMarketReturn.removeLast()
                        if let averageMarketReturnValue = Int(averageMarketReturn) {
                            self.coordinator?.onboardingInfoBuilder.averageMarketReturn = averageMarketReturnValue
                            self.mainCoordinator?.onboardingInfoBuilder.averageMarketReturn = averageMarketReturnValue
                            GainyAnalytics.logEvent("average_market_return_picked", params: ["average_market_return" : "\(averageMarketReturnValue)", "ec" : "PersonalizationIndicators"])
                        }
                    }
                }
            } else {
                self.nextButtonUnavailable = true
                self.coordinator?.onboardingInfoBuilder.averageMarketReturn = nil
                self.mainCoordinator?.onboardingInfoBuilder.averageMarketReturn = nil
            }
        }
        else if self.urgentMoneySourceView == sender {
            self.selectedSources = sources
            if let selectedSources = self.selectedSources {
                self.nextButtonUnavailable = selectedSources.count == 0
                if (selectedSources.count == 0) {
                    self.coordinator?.onboardingInfoBuilder.unexpectedPurchasesSource = nil
                    self.mainCoordinator?.onboardingInfoBuilder.unexpectedPurchasesSource = nil
                } else {
                    if let source = sources?.first {
                        let unexpectedPurchasesSource = "\(source)"
                        self.coordinator?.onboardingInfoBuilder.unexpectedPurchasesSource = unexpectedPurchasesSource
                        self.mainCoordinator?.onboardingInfoBuilder.unexpectedPurchasesSource = unexpectedPurchasesSource
                        GainyAnalytics.logEvent("unexpected_purchases_source_picked", params: ["source" : unexpectedPurchasesSource, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
                    }
                }
            } else {
                self.nextButtonUnavailable = true
                self.coordinator?.onboardingInfoBuilder.unexpectedPurchasesSource = nil
                self.mainCoordinator?.onboardingInfoBuilder.unexpectedPurchasesSource = nil
            }
        } else if self.investingApproachSourceView == sender {
            self.selectedApproaches = sources
            if let selectedApproaches = self.selectedApproaches {
                self.nextButtonUnavailable = selectedApproaches.count == 0
                if (selectedApproaches.count == 0) {
                    self.coordinator?.onboardingInfoBuilder.tradingExperience = nil
                    self.mainCoordinator?.onboardingInfoBuilder.tradingExperience = nil
                } else {
                    if let selectedApproach = sources?.first {
                        let tradingExperience = "\(selectedApproach)"
                        self.coordinator?.onboardingInfoBuilder.tradingExperience = tradingExperience
                        self.mainCoordinator?.onboardingInfoBuilder.tradingExperience = tradingExperience
                        GainyAnalytics.logEvent("trading_experience_picked", params: ["experience" : tradingExperience, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
                    }
                }
            } else {
                self.nextButtonUnavailable = true
                self.coordinator?.onboardingInfoBuilder.tradingExperience = nil
                self.mainCoordinator?.onboardingInfoBuilder.tradingExperience = nil
            }
            // TODO: Borysov - Add UI with next 2 sliders in the collection view, if the first (never tried) value is selected
            self.coordinator?.onboardingInfoBuilder.ifMarketDrops20IWillBuy = 0.5
            self.coordinator?.onboardingInfoBuilder.ifMarketDrops40IWillBuy = 0.5
            self.mainCoordinator?.onboardingInfoBuilder.ifMarketDrops20IWillBuy = 0.5
            self.mainCoordinator?.onboardingInfoBuilder.ifMarketDrops40IWillBuy = 0.5
        }
    }
}

extension PersonalizationIndicatorsViewController: PersonalizationSliderSectionViewDelegate {
    
    func sliderSectionViewFormattedValueString(sender: PersonalizationSliderSectionView, currentValue: Float) -> String {
        
        if sender == self.sliderViewInvestmentGoals {
            var investmentGoalsMessage = NSLocalizedString("Safe 6-12%", comment: "Investment Goals Safe 6-12%")
            var investmentGoalsExplanation = NSLocalizedString("Passive trading", comment: "passive trading")
            let value = Int(100 * currentValue)
            if value >= 0 && value <= 25 {
                investmentGoalsMessage = NSLocalizedString("Safe (6-12%)", comment: "Investment Goals Safe 6-12%")
                investmentGoalsExplanation = NSLocalizedString("Passive trading", comment: "passive trading")
            } else if value > 25 && value <= 50 {
                investmentGoalsMessage = NSLocalizedString("Moderate (12-24%)", comment: "Investment Goals Moderate 12-24%")
                investmentGoalsExplanation = NSLocalizedString("Mix of single stocks and ETFs", comment: "mix of single stocks and ETFs")
            } else if value > 50 && value <= 75 {
                investmentGoalsMessage = NSLocalizedString("Growth (25-50%)", comment: "Investment Goals Growth 25-50%")
                investmentGoalsExplanation = NSLocalizedString("Trading once a while and follow major events", comment: "trading once a while and follow major events")
            } else if value >= 75 && value <= 100 {
                investmentGoalsMessage = NSLocalizedString("Speculative play (50%+)", comment: "Investment Goals Speculative play 50%+")
                investmentGoalsExplanation = NSLocalizedString("Daily market analysis and high risks", comment: "daily market analysis and high risks")
            }
            self.sliderViewInvestmentGoals.configureWith(explanation: investmentGoalsExplanation)
            return investmentGoalsMessage
        } else if sender == self.sliderViewInvestmentHorizon {
            var investmentHorizonMessage = NSLocalizedString("Might need it urgently (ex. bills or savings)", comment: "Investment Horizon Might need it urgently")
            let value = Int(100 * currentValue)
            if value >= 0 && value <= 25 {
                investmentHorizonMessage = NSLocalizedString("Might need it urgently (ex. bills or savings)", comment: "Investment Horizon Might need it urgently")
            } else if value > 25 && value <= 50 {
                investmentHorizonMessage = NSLocalizedString("Within 1 year (ex. car)", comment: "Investment Horizon Within 1 year")
            } else if value > 50 && value <= 75 {
                investmentHorizonMessage = NSLocalizedString("Within 5 years (ex. house)", comment: "Investment Horizon Within 5 years")
            } else if value >= 75 && value <= 100 {
                investmentHorizonMessage = NSLocalizedString("After 10+ years (ex. retirement)", comment: "Investment Horizon After 10+ years")
            }
            return investmentHorizonMessage
        } else if sender == self.sliderViewDamageOfFailure {
            var damageOfFailureMessage = NSLocalizedString("I will need to spend less", comment: "Damage Of Failure Spend Less")
            let value = Int(100 * currentValue)
            if value >= 0 && value < 25 {
                damageOfFailureMessage = NSLocalizedString("I won’t have rent/food money", comment: "Damage Of Failure I won’t have rent/food money")
            } else if value >= 25 && value < 50 {
                damageOfFailureMessage = NSLocalizedString("I will need to save more and spend less", comment: "Damage Of Failure I will need to save more and spend less")
            } else if value >= 50 && value < 75 {
                damageOfFailureMessage = NSLocalizedString("I will have to delay large purchases", comment: "Damage Of Failure I will have to delay large purchases")
            } else if value >= 75 && value <= 100 {
                damageOfFailureMessage = NSLocalizedString("This is complete funny money I can lose", comment: "Damage Of Failure This is complete funny money I can lose")
            }
            return damageOfFailureMessage
        } else if sender == self.sliderViewStockMarketRisks {
            var damageOfFailureMessage = NSLocalizedString("Somewhat risky", comment: "Stock market risks somewhat")
            let value = Int(100 * currentValue)
            if value >= 0 && value <= 15 {
                damageOfFailureMessage = NSLocalizedString("Mostly safe", comment: "Stock market risks mostly safe")
            } else if value >= 15 && value <= 30 {
                damageOfFailureMessage = NSLocalizedString("Less risky", comment: "Stock market risks less risky")
            } else if value >= 30 && value <= 60 {
                damageOfFailureMessage = NSLocalizedString("Somewhat risky", comment: "Stock market risks somewhat")
            } else if value >= 60 && value <= 85 {
                damageOfFailureMessage = NSLocalizedString("Risky", comment: "Stock market risks risky")
            } else if value > 85 && value <= 100 {
                damageOfFailureMessage = NSLocalizedString("Very risky", comment: "Stock market risks very risky")
            }
            return damageOfFailureMessage
        }
        
        return "\(currentValue)"
    }
    
    func sliderSectionViewDidPickValue(sender: PersonalizationSliderSectionView, currentValue: Float) {
        
        if sender == self.sliderViewInvestmentGoals {
            self.setCurrentTab(newTab: .marketReturns)
            self.coordinator?.onboardingInfoBuilder.riskLevel = currentValue
            self.mainCoordinator?.onboardingInfoBuilder.riskLevel = currentValue
            GainyAnalytics.logEvent("risk_level_picked", params: ["risk_level" : "\(currentValue)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        } else if sender == self.sliderViewInvestmentHorizon {
            self.setCurrentTab(newTab: .moneySourceView)
            self.coordinator?.onboardingInfoBuilder.investmentHorizon = currentValue
            self.mainCoordinator?.onboardingInfoBuilder.investmentHorizon = currentValue
            GainyAnalytics.logEvent("investment_horizon_picked", params: ["investment_horizon" : "\(currentValue)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        } else if sender == self.sliderViewDamageOfFailure {
            self.setCurrentTab(newTab: .stockMarketRisks)
            self.coordinator?.onboardingInfoBuilder.damageOfFailure = (1.0 - currentValue)
            self.mainCoordinator?.onboardingInfoBuilder.damageOfFailure = (1.0 - currentValue)
            GainyAnalytics.logEvent("damage_of_failure_picked", params: ["damage_of_failure" : "\((1.0 - currentValue))", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        } else {
            self.nextButtonUnavailable = false
            if sender == self.sliderViewStockMarketRisks {
                var stockMarketRisks = "very_safe"
                let value = Int(100 * currentValue)
                if value >= 0 && value <= 15 {
                    stockMarketRisks = "very_safe"
                } else if value >= 15 && value <= 30 {
                    stockMarketRisks = "somewhat_safe"
                } else if value >= 30 && value <= 60 {
                    stockMarketRisks = "neutral"
                } else if value >= 60 && value <= 85 {
                    stockMarketRisks = "somewhat_risky"
                } else if value > 85 && value <= 100 {
                    stockMarketRisks = "very_risky"
                }
                self.coordinator?.onboardingInfoBuilder.stockMarketRiskLevel = stockMarketRisks
                self.mainCoordinator?.onboardingInfoBuilder.stockMarketRiskLevel = stockMarketRisks
                GainyAnalytics.logEvent("stock_market_risks_picked", params: ["stock_market_risks" : stockMarketRisks, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            }
        }
    }
}
