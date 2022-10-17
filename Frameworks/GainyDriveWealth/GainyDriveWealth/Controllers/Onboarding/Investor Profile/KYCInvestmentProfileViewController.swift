//
//  KYCInvestmentProfileViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors

public enum InvestmentProfileIncome: Int, CaseIterable {
    case tier1 = 0
    case tier2
    case tier3
    case tier4
    case tier5
    case tier6
    
    func description() -> String {
        
        switch self {
        case .tier1: return "Under $25,000"
        case .tier2: return "$25,000 to $100,000"
        case .tier3: return "$25,000 to $100,000"
        case .tier4: return "$100,000 to $500,000"
        case .tier5: return "$500,000 to $1,000,000"
        case .tier6: return "Over $1,000,000"
        }
    }
}

public enum InvestmentProfileNetWorth: Int, CaseIterable {
    case tier1 = 0
    case tier2
    case tier3
    case tier4
    case tier5
    case tier6
    
    func description() -> String {
        
        switch self {
        case .tier1: return "Under $50,000"
        case .tier2: return "$50,000 to $200,000"
        case .tier3: return "$200,000 to $500,000"
        case .tier4: return "$500,000 to $1,000,000"
        case .tier5: return "$1,000,000 to $5,000,000"
        case .tier6: return "Over $5,000,000"
        }
    }
}

final class KYCInvestmentProfileViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.scrollView.isScrollEnabled = true
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
        guard self.income != nil, self.netWorth != nil else {return}
        self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
    }
    
    private var income: InvestmentProfileIncome? = nil
    private var netWorth: InvestmentProfileNetWorth? = nil
    
    private func updateNextButtonState() {
        guard self.income != nil, self.netWorth != nil else {
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
            let income = InvestmentProfileIncome.allCases[indexPath.row]
            self.income = income
            if self.netWorth == nil {
                self.scrollView.scrollRectToVisible(self.netWorthCollectionView.frame, animated: true)
            }
        } else {
            let netWorth = InvestmentProfileNetWorth.allCases[indexPath.row]
            self.netWorth = netWorth
            if self.income == nil {
                self.scrollView.scrollRectToVisible(self.incomeCollectionView.frame, animated: true)
            }
        }
        self.updateNextButtonState()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == self.incomeCollectionView {
            self.income = nil
        } else {
            self.netWorth = nil
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
            return InvestmentProfileIncome.allCases.count
        } else {
            return InvestmentProfileNetWorth.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SingleRowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleRowCell", for: indexPath) as! SingleRowCell
        if collectionView == self.incomeCollectionView {
            cell.text = InvestmentProfileIncome.allCases[indexPath.row].description()
        } else {
            cell.text = InvestmentProfileNetWorth.allCases[indexPath.row].description()
        }
        return cell
    }
}
