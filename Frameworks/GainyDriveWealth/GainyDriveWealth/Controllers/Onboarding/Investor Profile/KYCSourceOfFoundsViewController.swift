//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import GainyAPI

public enum SourceOfFounds: Int, CaseIterable {
    case savings = 0
    case gift
    case gambling
    case disabilityPayments
    case creditCard
    case none
    
    func description() -> String {
        
        switch self {
        case .savings: return "Savings"
        case .gift: return "Gift or inheritance"
        case .gambling: return "Gambling"
        case .disabilityPayments: return "Unemployment or disability payments"
        case .creditCard: return "Credit card"
        case .none: return "None of this"
        }
    }
}

final class KYCSourceOfFoundsViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        
        // TODO: KYC - Question - no source of founds
        
        self.collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib.init(nibName: "SingleRowCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "SingleRowCell")

            self.collectionView.allowsSelection = true
            self.collectionView.allowsMultipleSelection = false
        }
    }
    
    @IBOutlet private weak var nextButton: GainyButton! {
        didSet {
            nextButton.configureWithTitle(title: "Next", color: UIColor.white, state: .normal)
            nextButton.configureWithTitle(title: "Next", color: UIColor.white, state: .disabled)
            nextButton.configureWithCornerRadius(radius: 16.0)
            nextButton.configureWithBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.configureWithHighligtedBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.isEnabled = false
        }
    }
    
    @IBOutlet private weak var backButton: GainyButton! {
        didSet {
            backButton.configureWithTitle(title: "", color: UIColor.white, state: .normal)
            backButton.configureWithTitle(title: "", color: UIColor.white, state: .disabled)
            backButton.configureWithCornerRadius(radius: 16.0)
            backButton.configureWithBackgroundColor(color: UIColor.white)
            backButton.configureWithHighligtedBackgroundColor(color: UIColor.white)
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        self.coordinator?.showKYCAdditionalQuestionsView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private var selectedSourceOfFounds: SourceOfFounds? = nil
    private let allSourceOfFounds = SourceOfFounds.allCases
}


extension KYCSourceOfFoundsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 44.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let state = self.allSourceOfFounds[indexPath.row]
        self.nextButton.isEnabled = true
        self.selectedSourceOfFounds = state
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        self.nextButton.isEnabled = false
        self.selectedSourceOfFounds = nil
    }
}

extension KYCSourceOfFoundsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allSourceOfFounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SingleRowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleRowCell", for: indexPath) as! SingleRowCell
        cell.text = self.allSourceOfFounds[indexPath.row].description()
        return cell
    }
}

