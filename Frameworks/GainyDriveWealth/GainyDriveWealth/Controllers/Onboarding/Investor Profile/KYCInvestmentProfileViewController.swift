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

final class KYCInvestmentProfileViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.scrollView.isScrollEnabled = true
        
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
        // TODO: KYC Question - NO choices in form data for annual and net worth
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
        
        self.incomeCollectionView.reloadData()
        self.netWorthCollectionView.reloadData()
        self.updateNextButtonState()
    }

    @IBOutlet private weak var scrollView: UIScrollView!
 
    @IBOutlet weak var incomeCollectionView: UICollectionView! {
        didSet {
            incomeCollectionView.delegate = self
            incomeCollectionView.dataSource = self
            incomeCollectionView.isScrollEnabled = false
            incomeCollectionView.register(UINib.init(nibName: "SingleRowCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "SingleRowCell")

            self.incomeCollectionView.allowsSelection = true
            self.incomeCollectionView.allowsMultipleSelection = false
        }
    }
    
    @IBOutlet weak var netWorthCollectionView: UICollectionView! {
        didSet {
            netWorthCollectionView.delegate = self
            netWorthCollectionView.dataSource = self
            netWorthCollectionView.isScrollEnabled = false
            netWorthCollectionView.register(UINib.init(nibName: "SingleRowCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "SingleRowCell")

            self.netWorthCollectionView.allowsSelection = true
            self.netWorthCollectionView.allowsMultipleSelection = false
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard self.selectedIncome != nil, self.selectedNetWorth != nil else {return}
        guard let income = Int(self.selectedIncome!.value), let netWorth = Int(self.selectedNetWorth!.value) else {return}
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.investor_profile_annual_income = income
            cache.investor_profile_net_worth_total = netWorth
            cache.investor_profile_filled = true
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
    }
    
    private var selectedIncome: KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice? = nil
    private var selectedNetWorth: KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice? = nil
    
    private var allIncome: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileAnnualIncome.Choice] = []
    private var allNetWorth: [KycGetFormConfigQuery.Data.KycGetFormConfig.InvestorProfileNetWorthTotal.Choice] = []
    
    private func updateNextButtonState() {
        guard self.selectedIncome != nil, self.selectedNetWorth != nil else {
            self.nextButton.isEnabled = false
            return
        }
        
        self.nextButton.isEnabled = true
    }
}

extension KYCInvestmentProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 44.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.incomeCollectionView {
            let income = self.allIncome[indexPath.row]
            self.selectedIncome = income
            if self.selectedNetWorth == nil {
                self.scrollView.scrollRectToVisible(self.netWorthCollectionView.frame, animated: true)
            }
        } else {
            let netWorth = self.allNetWorth[indexPath.row]
            self.selectedNetWorth = netWorth
            if self.selectedIncome == nil {
                self.scrollView.scrollRectToVisible(self.incomeCollectionView.frame, animated: true)
            }
        }
        self.updateNextButtonState()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == self.incomeCollectionView {
            self.selectedIncome = nil
        } else {
            self.selectedNetWorth = nil
        }
        self.updateNextButtonState()
    }
}

extension KYCInvestmentProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.incomeCollectionView {
            return self.allIncome.count
        } else {
            return self.allNetWorth.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SingleRowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleRowCell", for: indexPath) as! SingleRowCell
        if collectionView == self.incomeCollectionView {
            cell.text = self.allIncome[indexPath.row].name
            if let income = self.selectedIncome, income.value == self.allIncome[indexPath.row].value {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            }
        } else {
            cell.text = self.allNetWorth[indexPath.row].name
            if let netWorth = self.selectedNetWorth, netWorth.value == self.allNetWorth[indexPath.row].value {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            }
        }
        return cell
    }
}
