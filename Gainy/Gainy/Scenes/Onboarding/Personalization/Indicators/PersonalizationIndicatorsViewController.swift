//
//  PersonalizationIndicatorsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/6/21.
//

import UIKit

enum PersonalizationTab: Int {
    case investmentGoals = 0
    case marketReturns
    case investmentHorizon
    case moneySourceView
    case damageOfFailure
    case stockMarketRisks
    case investingApproach
}

class PersonalizationIndicatorsViewController: BaseViewController {
 
    public weak var coordinator: OnboardingCoordinator?
    
    @IBOutlet weak var firstSectionStackView: UIStackView!
    @IBOutlet weak var secondSectionStackView: UIStackView!
    @IBOutlet weak var thirdSectionStackView: UIStackView!
    @IBOutlet weak var lastSectionStackView: UIStackView!
    
    @IBOutlet weak var sliderViewInvestmentGoals: PersonalizationSliderSectionView!
    @IBOutlet weak var sliderViewMarketReturns: PersonalizationSliderSectionView!
    
    @IBOutlet weak var sliderViewInvestmentHorizon: PersonalizationSliderSectionView!
    @IBOutlet weak var urgentMoneySourceView: PersonalizationTitlePickerSectionView!
    
    @IBOutlet weak var sliderViewDamageOfFailure: PersonalizationSliderSectionView!
    @IBOutlet weak var sliderViewStockMarketRisks: PersonalizationSliderSectionView!
    
    @IBOutlet weak var investingApproachSourceView: PersonalizationTitlePickerSectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    private var indicatorViewProgressObject: ClockwiseProgressIndicatorViewProgress?
    private var indicatorView: UIView?
    private var currentTab: PersonalizationTab = .investmentGoals
    
    private var selectedSources: [PersonalizationInfoValue]?
    private var selectedApproaches: [PersonalizationInfoValue]?
    
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
        self.setNextButtonHidden(isHidden: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
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
    
    @objc func backButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("indicators_back_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        if self.currentTab == .investmentGoals {
            
            self.coordinator?.popModule()
            return
        }
        
        self.setCurrentTab(newTab: PersonalizationTab.init(rawValue: self.currentTab.rawValue - 1) ?? self.currentTab)
        let rect = CGRect.init(x: self.view.frame.size.width * CGFloat(self.currentTab.rawValue / 2), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("indicators_close_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        self.coordinator?.popToRootModule()
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("indicators_next_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        if self.currentTab == .investingApproach {
            
            if let email = self.coordinator?.profileInfoBuilder.email {
                if email.count > 0 {
                    self.coordinator?.pushOnboardingFinalizingViewController()
                } else {
                    self.coordinator?.presentAuthorizationViewController(isOnboardingDone: true)
                }
            } else {
                self.coordinator?.presentAuthorizationViewController(isOnboardingDone: true)
            }
            
            return
        }
        
        self.setCurrentTab(newTab: PersonalizationTab.init(rawValue: self.currentTab.rawValue + 1) ?? self.currentTab)
        let rect = CGRect.init(x: self.view.frame.size.width * CGFloat(self.currentTab.rawValue / 2), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    private func setCurrentTab(newTab: PersonalizationTab) {
        
        self.currentTab = newTab
        self.setNextButtonHidden(isHidden: self.currentTab.rawValue % 2 == 0)
        
        let nextButtonTitle = NSLocalizedString("Next", comment: "Next button title")
        self.nextButton.setTitle(nextButtonTitle, for: UIControl.State.normal)
        
        switch self.currentTab {
        case .investmentGoals:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "investmentGoals", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.0)
            self.setMarketReturnsHidden(isHidden: true)
        case .marketReturns:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "marketReturns", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.25)
            self.setMarketReturnsHidden(isHidden: false)
            self.setNextButtonHidden(isHidden: self.sliderViewMarketReturns.isInitialLayout)
        case .investmentHorizon:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "investmentHorizon", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.25)
            self.setMoneySourceViewHidden(isHidden: true)
        case .moneySourceView:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "moneySourceView", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.50)
            self.setMoneySourceViewHidden(isHidden: false)
            if let selectedSources = self.selectedSources {
                self.setNextButtonHidden(isHidden: selectedSources.count == 0)
            } else {
                self.setNextButtonHidden(isHidden: true)
            }
        case .damageOfFailure:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "damageOfFailure", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.50)
            self.setStockMarketRisksHidden(isHidden: true)
        case .stockMarketRisks:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "stockMarketRisks", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.75)
            self.setStockMarketRisksHidden(isHidden: false)
            self.setNextButtonHidden(isHidden: self.sliderViewStockMarketRisks.isInitialLayout)
        case .investingApproach:
            GainyAnalytics.logEvent("indicators_change_tab", params: ["tab" : "investingApproach", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            self.indicatorViewProgressObject?.progress = Float(0.90)
            let doneButtonTitle = NSLocalizedString("Done", comment: "Done button title")
            self.nextButton.setTitle(doneButtonTitle, for: UIControl.State.normal)
            if let selectedApproaches = self.selectedApproaches {
                self.setNextButtonHidden(isHidden: selectedApproaches.count == 0)
            } else {
                self.setNextButtonHidden(isHidden: true)
            }
        }
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = NSLocalizedString("Personalization", comment: "Personalization").uppercased()
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
    
    private func setUpInvestmentGoalsView() {
        
        let title = NSLocalizedString("Investment goals", comment: "Investment Goals Title")
        let description = NSLocalizedString("An indicator of how much you are willing to take\nrisks in order to obtain greater rewards\npotentially", comment: "Investment Goals Description")
        self.sliderViewInvestmentGoals.configureWith(title: title)
        self.sliderViewInvestmentGoals.configureWith(description: description)
        let minValueCaption = NSLocalizedString("less risky", comment: "Investment Goals Min Caption").uppercased()
        let maxValueCaption = NSLocalizedString("more rewards", comment: "Investment Goals Max Caption").uppercased()
        self.sliderViewInvestmentGoals.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewInvestmentGoals.delegate = self
        self.sliderViewInvestmentGoals.configureWith(currentValue: 0.5)
    }
    
    private func setUpMarketReturnsView() {
        
        let title = NSLocalizedString("Average market returns", comment: "Market Returns Title")
        let description = NSLocalizedString("Please tell us, what is an average market\nreturn is in your opinion", comment: "Market Returns Description")
        self.sliderViewMarketReturns.configureWith(title: title)
        self.sliderViewMarketReturns.configureWith(description: description)
        let minValueCaption = NSLocalizedString("less", comment: "Market Returns Min Caption").uppercased()
        let maxValueCaption = NSLocalizedString("more", comment: "Market Returns Max Caption").uppercased()
        self.sliderViewMarketReturns.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewMarketReturns.delegate = self
        self.sliderViewMarketReturns.configureWith(currentValue: 0.15)
    }
    
    private func setUpInvestmentHorizonView() {
        
        let title = NSLocalizedString("Investment horizon", comment: "Investment Horizon Title")
        let description = NSLocalizedString("When do you plan to use money that you\ninvested", comment: "Investment Horizon Description")
        self.sliderViewInvestmentHorizon.configureWith(title: title)
        self.sliderViewInvestmentHorizon.configureWith(description: description)
        let minValueCaption = NSLocalizedString("sooner", comment: "Investment Horizon Min Caption").uppercased()
        let maxValueCaption = NSLocalizedString("later", comment: "Investment Horizon Max Caption").uppercased()
        self.sliderViewInvestmentHorizon.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewInvestmentHorizon.delegate = self
        self.sliderViewInvestmentHorizon.configureWith(currentValue: 0.5)
    }
    
    private func setUpUrgentMoneySourceView() {
        
        let title = NSLocalizedString("Urgent money source", comment: "Urgent Money Source Title")
        let description = NSLocalizedString("Where do you get money for unexpected large\npurchases", comment: "Urgent Money Source Description")
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
        let description = NSLocalizedString("If the investment doesn’t pan out, how serious\nis the consequence", comment: "Damage of failure Description")
        self.sliderViewDamageOfFailure.configureWith(title: title)
        self.sliderViewDamageOfFailure.configureWith(description: description)
        let minValueCaption = NSLocalizedString("very sensitive", comment: "Damage of failure Min Caption").uppercased()
        let maxValueCaption = NSLocalizedString("less sensitive", comment: "Damage of failure Max Caption").uppercased()
        self.sliderViewDamageOfFailure.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewDamageOfFailure.delegate = self
        self.sliderViewDamageOfFailure.configureWith(currentValue: 0.5)
    }
    
    private func setUpStockMarketRisksView() {
        
        let title = NSLocalizedString("Stock market risks", comment: "Stock market risks Title")
        let description = NSLocalizedString("How risky do you think stock market is?", comment: "Stock market risks Description")
        self.sliderViewStockMarketRisks.configureWith(title: title)
        self.sliderViewStockMarketRisks.configureWith(description: description)
        let minValueCaption = NSLocalizedString("less risky", comment: "Stock market risks Min Caption").uppercased()
        let maxValueCaption = NSLocalizedString("very risky", comment: "Stock market risks Max Caption").uppercased()
        self.sliderViewStockMarketRisks.configureWith(minLabelText: minValueCaption, maxLabelText: maxValueCaption)
        self.sliderViewStockMarketRisks.delegate = self
        self.sliderViewStockMarketRisks.configureWith(currentValue: 0.5)
    }
    
    private func setUpInvestingApproachSourceView() {
        
        let title = NSLocalizedString("Investing approach", comment: "Investing approach Title")
        let description = NSLocalizedString("Your experience with trading", comment: "Investing approach Description")
        self.investingApproachSourceView.configureWith(title: title)
        self.investingApproachSourceView.configureWith(description: description)
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
        
        UIView.animate(withDuration: 0.25) {
            self.sliderViewMarketReturns.isHidden = isHidden
            self.sliderViewMarketReturns.alpha = isHidden ? 0.0 : 1.0
        }
    }
    
    func setMoneySourceViewHidden(isHidden: Bool) {
        
        UIView.animate(withDuration: 0.25) {
            self.urgentMoneySourceView.isHidden = isHidden
            self.urgentMoneySourceView.alpha = isHidden ? 0.0 : 1.0
        }
    }
    
    func setStockMarketRisksHidden(isHidden: Bool) {
        
        UIView.animate(withDuration: 0.25) {
            self.sliderViewStockMarketRisks.isHidden = isHidden
            self.sliderViewStockMarketRisks.alpha = isHidden ? 0.0 : 1.0
        }
    }
}

extension PersonalizationIndicatorsViewController: PersonalizationTitlePickerSectionViewDelegate {
    func personalizationTitlePickerDidPickSources(sender: PersonalizationTitlePickerSectionView, sources: [PersonalizationInfoValue]?) {
        
        if self.urgentMoneySourceView == sender {
            self.selectedSources = sources
            if let selectedSources = self.selectedSources {
                self.setNextButtonHidden(isHidden: selectedSources.count == 0)
                if (selectedSources.count == 0) {
                    self.coordinator?.profileInfoBuilder.unexpectedPurchasesSource = nil
                } else {
                    if let source = sources?.first {
                        let unexpectedPurchasesSource = "\(source)"
                        self.coordinator?.profileInfoBuilder.unexpectedPurchasesSource = unexpectedPurchasesSource
                        GainyAnalytics.logEvent("unexpected_purchases_source_picked", params: ["source" : unexpectedPurchasesSource, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
                    }
                }
            } else {
                self.setNextButtonHidden(isHidden: true)
                self.coordinator?.profileInfoBuilder.unexpectedPurchasesSource = nil
            }
        } else if self.investingApproachSourceView == sender {
            self.selectedApproaches = sources
            if let selectedApproaches = self.selectedApproaches {
                self.setNextButtonHidden(isHidden: selectedApproaches.count == 0)
                if (selectedApproaches.count == 0) {
                    self.coordinator?.profileInfoBuilder.tradingExperience = nil
                } else {
                    if let selectedApproach = sources?.first {
                        let tradingExperience = "\(selectedApproach)"
                        self.coordinator?.profileInfoBuilder.tradingExperience = tradingExperience
                        GainyAnalytics.logEvent("trading_experience_picked", params: ["experience" : tradingExperience, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
                    }
                }
            } else {
                self.setNextButtonHidden(isHidden: true)
                self.coordinator?.profileInfoBuilder.tradingExperience = nil
            }
            // TODO: Borysov - Add UI with next 2 sliders in the collection view, if the first (never tried) value is selected
            self.coordinator?.profileInfoBuilder.ifMarketDrops20IWillBuy = 0.5
            self.coordinator?.profileInfoBuilder.ifMarketDrops40IWillBuy = 0.5
        }
    }
}

extension PersonalizationIndicatorsViewController: PersonalizationSliderSectionViewDelegate {
    
    func sliderSectionViewFormattedValueString(sender: PersonalizationSliderSectionView, currentValue: Float) -> String {
        
        if sender == self.sliderViewInvestmentGoals {
            let valueDescriptionFormat = NSLocalizedString("%@ %@%%", comment: "Investment Goals Value Format")
            let minValue = 3 + 20 * currentValue
            let maxValue = 15 + 20 * currentValue
            var descriptionString = NSLocalizedString("Moderate", comment: "Moderate").uppercased()
            if minValue <= 9 {
                descriptionString = NSLocalizedString("Low", comment: "Low").uppercased()
            } else if minValue >= 18 {
                descriptionString = NSLocalizedString("High", comment: "High").uppercased()
            }
            let valueString = String.init(format: valueDescriptionFormat, descriptionString,  "\(Int(minValue))-\(Int(maxValue))")
            return valueString
            
        } else if sender == self.sliderViewMarketReturns {
            let valueDescriptionFormat = NSLocalizedString("%@%%", comment: "Market Returns")
            let value = 50 * currentValue
            let valueString = String.init(format: valueDescriptionFormat,  "\(Int(value))")
            return valueString
        } else if sender == self.sliderViewInvestmentHorizon {
            let value = Int(1 + 119 * currentValue)
            let months = value % 12
            let years = value / 12
            var yearsString: String?
            var monthsString: String?
            if years > 0 {
                let yearsFormat = NSLocalizedString("within %@ %@", comment: "Market Returns Value Years Format")
                let yearStringPart = NSLocalizedString("year", comment: "Market Returns Year")
                let yearsStringPart = NSLocalizedString("years", comment: "Market Returns Years")
                yearsString = String.init(format: yearsFormat, "\(years)", (years == 1 ? yearStringPart : yearsStringPart)).uppercased()
            }
            if months > 0 {
                let monthsFormat = NSLocalizedString("%@ %@ %@", comment: "Market Returns Value Months Format")
                let monthStringPart = NSLocalizedString("month", comment: "Market Returns Month")
                let monthsStringPart = NSLocalizedString("months", comment: "Market Returns Months")
                monthsString = String.init(format: monthsFormat, ((yearsString != nil) ? "" : "within"), "\(months)", (months == 1 ? monthStringPart : monthsStringPart)).uppercased()
            }
            var result = yearsString ?? ""
            result += monthsString ?? ""
            return result
        } else if sender == self.sliderViewDamageOfFailure {
            var damageOfFailureMessage = NSLocalizedString("I will need to spend less", comment: "Damage Of Failure Spend Less").uppercased()
            let value = Int(100 * currentValue)
            if value >= 0 && value <= 15 {
                damageOfFailureMessage = NSLocalizedString("I will need to survive", comment: "Damage Of Failure Survive").uppercased()
            } else if value >= 15 && value <= 30 {
                damageOfFailureMessage = NSLocalizedString("I will need to work hard", comment: "Damage Of Failure Work Hard").uppercased()
            } else if value >= 30 && value <= 60 {
                damageOfFailureMessage = NSLocalizedString("I will need to spend less", comment: "Damage Of Failure Spend Less").uppercased()
            } else if value >= 60 && value <= 85 {
                damageOfFailureMessage = NSLocalizedString("I will still be able to invest", comment: "Damage Of Failure Invest").uppercased()
            } else if value > 85 && value <= 100 {
                damageOfFailureMessage = NSLocalizedString("I will not feel the change", comment: "Damage Of Failure Тot Аeel Еhe Сhange").uppercased()
            }
            return damageOfFailureMessage
        } else if sender == self.sliderViewStockMarketRisks {
            var damageOfFailureMessage = NSLocalizedString("somewhat risky", comment: "Stock market risks somewhat").uppercased()
            let value = Int(100 * currentValue)
            if value >= 0 && value <= 15 {
                damageOfFailureMessage = NSLocalizedString("mostly safe", comment: "Stock market risks mostly safe").uppercased()
            } else if value >= 15 && value <= 30 {
                damageOfFailureMessage = NSLocalizedString("less risky", comment: "Stock market risks less risky").uppercased()
            } else if value >= 30 && value <= 60 {
                damageOfFailureMessage = NSLocalizedString("somewhat risky", comment: "Stock market risks somewhat").uppercased()
            } else if value >= 60 && value <= 85 {
                damageOfFailureMessage = NSLocalizedString("risky", comment: "Stock market risks risky").uppercased()
            } else if value > 85 && value <= 100 {
                damageOfFailureMessage = NSLocalizedString("very risky", comment: "Stock market risks very risky").uppercased()
            }
            return damageOfFailureMessage
        }
        
        return "\(currentValue)"
    }
    
    func sliderSectionViewDidPickValue(sender: PersonalizationSliderSectionView, currentValue: Float) {
        
        if sender == self.sliderViewInvestmentGoals {
            self.setCurrentTab(newTab: .marketReturns)
            self.coordinator?.profileInfoBuilder.riskLevel = currentValue
            GainyAnalytics.logEvent("risk_level_picked", params: ["risk_level" : "\(currentValue)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        } else if sender == self.sliderViewInvestmentHorizon {
            self.setCurrentTab(newTab: .moneySourceView)
            self.coordinator?.profileInfoBuilder.investmentHorizon = currentValue
            GainyAnalytics.logEvent("investment_horizon_picked", params: ["investment_horizon" : "\(currentValue)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        } else if sender == self.sliderViewDamageOfFailure {
            self.setCurrentTab(newTab: .stockMarketRisks)
            self.coordinator?.profileInfoBuilder.damageOfFailure = (1.0 - currentValue)
            GainyAnalytics.logEvent("damage_of_failure_picked", params: ["damage_of_failure" : "\((1.0 - currentValue))", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
        } else {
            self.setNextButtonHidden(isHidden: false)
            if sender == self.sliderViewMarketReturns {
                var averageMarketReturn = 6
                if currentValue > 0 && currentValue <= 0.25 {
                    averageMarketReturn = 6
                }
                if currentValue > 0.25 && currentValue <= 0.5 {
                    averageMarketReturn = 15
                }
                if currentValue > 0.5 && currentValue <= 0.75 {
                    averageMarketReturn = 25
                }
                if currentValue > 0.75 && currentValue <= 1.0 {
                    averageMarketReturn = 50
                }
                self.coordinator?.profileInfoBuilder.averageMarketReturn = averageMarketReturn
                GainyAnalytics.logEvent("average_market_return_picked", params: ["average_market_return" : "\(averageMarketReturn)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            } else if sender == self.sliderViewStockMarketRisks {
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
                self.coordinator?.profileInfoBuilder.stockMarketRiskLevel = stockMarketRisks
                GainyAnalytics.logEvent("stock_market_risks_picked", params: ["stock_market_risks" : "stockMarketRisks", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationIndicators"])
            }
        }
    }
}
