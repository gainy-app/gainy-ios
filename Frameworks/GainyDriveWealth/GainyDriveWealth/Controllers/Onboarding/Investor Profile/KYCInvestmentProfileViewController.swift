//
//  KYCInvestmentProfileViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import GainyAPI

public enum InvestmentProfileQuestionType {
    case annualIncome
    case netWorth
    case liquidNetWorth
    case experience
    case objectives
    case riskTolerance
}

final class KYCInvestmentProfileViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEventAMP("dw_kyc_ip_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        self.scrollView.isScrollEnabled = true

        self.updateNextButtonState()
    }

    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var incomeTextFieldControl: GainyTextFieldControl! {
        didSet {
            var placeholderIncome = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileAnnualIncome?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let income = cache.investor_profile_annual_income {
                    placeholderIncome = String(income)
                }
            }
            var choicesIncome: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileAnnualIncome?.choices?.compactMap({ item in
                if let item = item, item.name == placeholderIncome || item.value == placeholderIncome {
                    self.selectedIncome = item
                }
                return item
            }) ?? []
        
            if choicesIncome.count == 0 {
                choicesIncome = [
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice.init(value: "25000", name: "Under $25,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice.init(value: "100000", name: "$25,000 to $100,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice.init(value: "500000", name: "$100,000 to $500,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice.init(value: "1000000", name: "$500,000 to $1,000,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice.init(value: "5000000", name: "Over $1,000,000")
                ]
                for income in choicesIncome {
                    if income.name == placeholderIncome || income.value == placeholderIncome {
                        self.selectedIncome = income
                    }
                }
            }
            self.allIncome = choicesIncome
            let defaultValue = self.selectedIncome?.name ?? ""
            
            self.incomeTextFieldControl.delegate = self
            self.incomeTextFieldControl.configureWithText(text: defaultValue, placeholder: "Annual income", smallPlaceholder: "Annual income")
            self.incomeTextFieldControl.textFieldEnabled = false
            self.incomeTextFieldControl.configureWith(placeholderInset: 7.0)
        }
    }
    
    @IBOutlet private weak var totalNetWorthTextFieldControl: GainyTextFieldControl! {
        didSet {
            var placeholderNetWorth = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileNetWorthTotal?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let netWorth = cache.investor_profile_net_worth_total {
                    placeholderNetWorth = String(netWorth)
                }
            }
            var choicesNetWorth: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileNetWorthTotal?.choices?.compactMap({ item in
                if let item = item, item.name == placeholderNetWorth || item.value == placeholderNetWorth {
                    self.selectedNetWorth = item
                }
                return item
            }) ?? []
            if choicesNetWorth.count == 0 {
                choicesNetWorth = [
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice.init(value: "50000", name: "Under $50,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice.init(value: "200000", name: "$50,000 to $200,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice.init(value: "500000", name: "$200,000 to $500,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice.init(value: "1000000", name: "$500,000 to $1,000,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice.init(value: "5000000", name: "$1,000,000 to $5,000,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice.init(value: "10000000", name: "Over $5,000,000")
                ]
                for netWorth in choicesNetWorth {
                    if netWorth.name == placeholderNetWorth || netWorth.value == placeholderNetWorth{
                        self.selectedNetWorth = netWorth
                    }
                }
            }
            self.allNetWorth = choicesNetWorth
            let defaultValue = self.selectedNetWorth?.name ?? ""
            
            self.totalNetWorthTextFieldControl.delegate = self
            self.totalNetWorthTextFieldControl.configureWithText(text: defaultValue, placeholder: "Estimated total net worth", smallPlaceholder: "Estimated total net worth")
            self.totalNetWorthTextFieldControl.textFieldEnabled = false
            self.totalNetWorthTextFieldControl.configureWith(placeholderInset: 7.0)
        }
    }
    
    @IBOutlet private weak var liquidNetWorthFieldControl: GainyTextFieldControl! {
        didSet {
            var placeholderNetWorth = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileNetWorthLiquid?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let netWorth = cache.investor_profile_net_worth_liquid {
                    placeholderNetWorth = String(netWorth)
                }
            }
            var choicesNetWorth: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileNetWorthLiquid?.choices?.compactMap({ item in
                if let item = item, item.name == placeholderNetWorth || item.value == placeholderNetWorth {
                    self.selectedLiquidNetWorth = item
                }
                return item
            }) ?? []
            if choicesNetWorth.count == 0 {
                choicesNetWorth = [
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice.init(value: "50000", name: "Under $50,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice.init(value: "200000", name: "$50,000 to $200,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice.init(value: "500000", name: "$200,000 to $500,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice.init(value: "1000000", name: "$500,000 to $1,000,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice.init(value: "5000000", name: "$1,000,000 to $5,000,000"),
                    KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice.init(value: "10000000", name: "Over $5,000,000")
                ]
                for netWorth in choicesNetWorth {
                    if netWorth.name == placeholderNetWorth || netWorth.value == placeholderNetWorth{
                        self.selectedLiquidNetWorth = netWorth
                    }
                }
            }
            self.allLiquidNetWorth = choicesNetWorth
            let defaultValue = self.selectedLiquidNetWorth?.name ?? ""
            
            self.liquidNetWorthFieldControl.delegate = self
            self.liquidNetWorthFieldControl.configureWithText(text: defaultValue, placeholder: "Estimated liquid net worth", smallPlaceholder: "Estimated liquid net worth")
            self.liquidNetWorthFieldControl.textFieldEnabled = false
            self.liquidNetWorthFieldControl.configureWith(placeholderInset: 7.0)
        }
    }
    
    @IBOutlet private weak var experienceButton: GainyButton! {
        didSet {
            experienceButton.configureWithTitle(title: "", color: UIColor.clear, state: .normal)
            experienceButton.configureWithTitle(title: "", color: UIColor.clear, state: .disabled)
            experienceButton.configureWithCornerRadius(radius: 16.0)
            experienceButton.configureWithBackgroundColor(color: UIColor(hexString: "#FFFFFF") ?? UIColor.white)
            experienceButton.configureWithBackgroundColor(color: UIColor(hexString: "#FFFFFF") ?? UIColor.white)
        }
    }
    
    @IBOutlet private weak var objectivesButton: GainyButton! {
        didSet {
            objectivesButton.configureWithTitle(title: "", color: UIColor.clear, state: .normal)
            objectivesButton.configureWithTitle(title: "", color: UIColor.clear, state: .disabled)
            objectivesButton.configureWithCornerRadius(radius: 16.0)
            objectivesButton.configureWithBackgroundColor(color: UIColor(hexString: "#FFFFFF") ?? UIColor.white)
            objectivesButton.configureWithBackgroundColor(color: UIColor(hexString: "#FFFFFF") ?? UIColor.white)
        }
    }
    
    @IBOutlet private weak var riskButton: GainyButton! {
        didSet {
            riskButton.configureWithTitle(title: "", color: UIColor.clear, state: .normal)
            riskButton.configureWithTitle(title: "", color: UIColor.clear, state: .disabled)
            riskButton.configureWithCornerRadius(radius: 16.0)
            riskButton.configureWithBackgroundColor(color: UIColor(hexString: "#FFFFFF") ?? UIColor.white)
            riskButton.configureWithBackgroundColor(color: UIColor(hexString: "#FFFFFF") ?? UIColor.white)
        }
    }
    
    @IBOutlet private weak var riskLabel: UILabel! {
        didSet {
            var placeholder = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileRiskTolerance?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let value = cache.investor_profile_risk_tolerance {
                    placeholder = String(value)
                }
            }
            let choices: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileRiskTolerance.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileRiskTolerance?.choices?.compactMap({ item in
                if let item = item, item.name == placeholder || item.value == placeholder {
                    self.selectedRiskTolerance = item
                }
                return item
            }) ?? []
            self.allRiskTolerance = choices
            if let name = self.selectedRiskTolerance?.name {
                self.riskLabel.text = name
                self.riskLabel.textColor = UIColor.black
            }
        }
    }
    
    @IBOutlet private weak var objectivesLabel: UILabel! {
        didSet {
            var placeholder = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileObjectives?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let value = cache.investor_profile_objectives {
                    placeholder = String(value)
                }
            }
            let choices: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileObjective.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileObjectives?.choices?.compactMap({ item in
                if let item = item, item.name == placeholder || item.value == placeholder {
                    self.selectedObjective = item
                }
                return item
            }) ?? []
            self.allObjectives = choices
            if let name = self.selectedObjective?.name {
                self.objectivesLabel.text = name
                self.objectivesLabel.textColor = UIColor.black
            }
        }
    }
    
    @IBOutlet private weak var experienceLabel: UILabel! {
        didSet {
            var placeholder = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileExperience?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let value = cache.investor_profile_experience {
                    placeholder = String(value)
                }
            }
            let choices: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileExperience.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.investorProfileExperience?.choices?.compactMap({ item in
                if let item = item, item.name == placeholder || item.value == placeholder {
                    self.selectedInvestmentExperience = item
                }
                return item
            }) ?? []
            self.allInvestmentExperience = choices
            if let name = self.selectedInvestmentExperience?.name {
                self.experienceLabel.text = name
                self.experienceLabel.textColor = UIColor.black
            }
        }
    }
    
    @IBOutlet private weak var nextButton: GainyButton! {
        didSet {
            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .normal)
            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .disabled)
            nextButton.configureWithCornerRadius(radius: 16.0)
            nextButton.configureWithBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.configureWithHighligtedBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func experienceButtonAction(_ sender: Any) {
        
        let array = self.allInvestmentExperience.compactMap { item in
            return [item.value : item.name]
        }
        self.coordinator?.showKYCKeyValueSearch(delegate: self, keyValuesArray: array)
        self.currentQuestion = .experience
    }
    
    @IBAction func objectiveButtonAction(_ sender: Any) {
        
        let array = self.allObjectives.compactMap { item in
            return [item.value : item.name]
        }
        self.coordinator?.showKYCKeyValueSearch(delegate: self, keyValuesArray: array)
        self.currentQuestion = .objectives
    }
    
    @IBAction func riskButtonAction(_ sender: Any) {
        let array = self.allRiskTolerance.compactMap { item in
            return [item.value : item.name]
        }
        self.coordinator?.showKYCKeyValueSearch(delegate: self, keyValuesArray: array)
        self.currentQuestion = .riskTolerance
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        let valid =
        self.selectedIncome != nil &&
        self.selectedNetWorth != nil &&
        self.selectedLiquidNetWorth != nil &&
        self.selectedInvestmentExperience != nil &&
        self.selectedObjective != nil &&
        self.selectedRiskTolerance != nil
        guard valid == true else {return}
        
        let income = Int(self.selectedIncome!.value)
        let netWorth = Int(self.selectedNetWorth!.value)
        let liquidNetWorth = Int(self.selectedLiquidNetWorth!.value)
        guard let income = income, let netWorth = netWorth, let liquidNetWorth = liquidNetWorth else {return}
        let investmentExperience = self.selectedInvestmentExperience!.value
        let objectives = self.selectedObjective!.value
        let RiskTolerance = self.selectedRiskTolerance!.value
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.investor_profile_annual_income = income
            cache.investor_profile_net_worth_total = netWorth
            cache.investor_profile_net_worth_liquid = liquidNetWorth
            cache.investor_profile_experience = investmentExperience
            cache.investor_profile_objectives = objectives
            cache.investor_profile_risk_tolerance = RiskTolerance
            cache.investor_profile_filled = true
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCGainyCustomerAgreementView()
        GainyAnalytics.logEventAMP("dw_kyc_ip_e", params: ["income" : income, "netWorth" : netWorth, "liquidNetWorth" : liquidNetWorth, "investmentExperience" : investmentExperience, "objectives" : objectives, "riskTolerance" : RiskTolerance  ])
    }
    
    private var currentQuestion: InvestmentProfileQuestionType? = nil
    
    private var selectedIncome: KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice? = nil
    private var selectedNetWorth: KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice? = nil
    private var selectedLiquidNetWorth: KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice? = nil
    private var selectedInvestmentExperience: KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileExperience.Choice? = nil
    private var selectedObjective: KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileObjective.Choice? = nil
    private var selectedRiskTolerance: KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileRiskTolerance.Choice? = nil
    
    private var allIncome: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice] = []
    private var allNetWorth: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice] = []
    private var allLiquidNetWorth: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthLiquid.Choice] = []
    private var allInvestmentExperience: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileExperience.Choice] = []
    private var allObjectives: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileObjective.Choice] = []
    private var allRiskTolerance: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileRiskTolerance.Choice] = []
    
    private func updateNextButtonState() {
  
        let valid =
        self.selectedIncome != nil &&
        self.selectedNetWorth != nil &&
        self.selectedLiquidNetWorth != nil &&
        self.selectedInvestmentExperience != nil &&
        self.selectedObjective != nil &&
        self.selectedRiskTolerance != nil
        
        self.nextButton.isEnabled = valid
    }
}

extension KYCInvestmentProfileViewController: KYCKeyValueSearchViewControllerDelegate {
    func keyValueSearchViewController(sender: KYCKeyValueSearchViewController, didPickKey key: String, value: String) {
        guard let question = self.currentQuestion else { return }
        
        switch question {
        case .annualIncome:
            self.selectedIncome = self.allIncome.first(where: { item in
                item.name == value
            })
            self.incomeTextFieldControl.configureWithText(text: value)
        case .netWorth:
            self.selectedNetWorth = self.allNetWorth.first(where: { item in
                item.name == value
            })
            self.totalNetWorthTextFieldControl.configureWithText(text: value)
        case .liquidNetWorth:
            self.selectedLiquidNetWorth = self.allLiquidNetWorth.first(where: { item in
                item.name == value
            })
            self.liquidNetWorthFieldControl.configureWithText(text: value)
        case .experience:
            self.selectedInvestmentExperience = self.allInvestmentExperience.first(where: { item in
                item.name == value
            })
            self.experienceLabel.text = value
            self.experienceLabel.textColor = UIColor.black
        case .objectives:
            self.selectedObjective = self.allObjectives.first(where: { item in
                item.name == value
            })
            self.objectivesLabel.text = value
            self.objectivesLabel.textColor = UIColor.black
        case .riskTolerance:
            self.selectedRiskTolerance = self.allRiskTolerance.first(where: { item in
                item.name == value
            })
            self.riskLabel.text = value
            self.riskLabel.textColor = UIColor.black
        }
        
        self.currentQuestion = nil
        sender.dismiss(animated: true)
        self.updateNextButtonState()
    }
}

extension KYCInvestmentProfileViewController: GainyTextFieldControlDelegate {
    
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        sender.isEditing = false
        if sender == self.incomeTextFieldControl {
            let array = self.allIncome.compactMap { item in
                return [item.value : item.name]
            }
            self.coordinator?.showKYCKeyValueSearch(delegate: self, keyValuesArray: array)
            self.currentQuestion = .annualIncome
        } else if sender == self.totalNetWorthTextFieldControl {
            let array = self.allNetWorth.compactMap { item in
                return [item.value : item.name]
            }
            self.coordinator?.showKYCKeyValueSearch(delegate: self, keyValuesArray: array)
            self.currentQuestion = .netWorth
        } else if sender == self.liquidNetWorthFieldControl {
            let array = self.allLiquidNetWorth.compactMap { item in
                return [item.value : item.name]
            }
            self.coordinator?.showKYCKeyValueSearch(delegate: self, keyValuesArray: array)
            self.currentQuestion = .liquidNetWorth
        }
        self.coordinator?.showKYCKeyValueSearch(delegate: self, keyValuesArray: [])
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        
        sender.isEditing = false
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {
        
    }
}
