//
//  DWTTFOrdersViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 16.01.2023.
//

import UIKit
import GainyCommon

public final class DWTTFOrdersViewController: DWBaseViewController {
    
    //MARK: - DI
    
    var tradingHistory: [GainyTradingHistory] = []
    
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            
            self.collectionView.register(UINib.init(nibName: "OrderCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "OrderCell")
            self.collectionView.register(UINib.init(nibName: "OrderHeaderView", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "OrderHeaderView")
            
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
    }
    
    
    
    private var tradingSections: [Date] = []
    private var tradingHistorybyDate: [Date : [GainyTradingHistory]] = [:]
    
    //MARK: - Life Cycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gainyNavigationBar.configureWithItems(items: [.close])
        gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        loadState()
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    private func loadState() {
        
        titleLbl.text = tradingHistory.first?.name ?? ""
        tradingSections = []
        tradingHistorybyDate = [:]
        
        tradingHistorybyDate = Dictionary(grouping: tradingHistory) { $0.date.startOfDay}
        tradingSections = tradingHistorybyDate.keys.sorted(by: {$0 > $1})
        
        self.collectionView.reloadData()
    }
}

extension DWTTFOrdersViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 88.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 48)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionDate = tradingSections[indexPath.section]
        
        guard let history = tradingHistorybyDate[sectionDate]?[indexPath.row] else {return}
        
        var mode: DWHistoryOrderMode = .other(history: GainyTradingHistory())
        if let tradingCollectionVersion = history.tradingCollectionVersion {
            if tradingCollectionVersion.targetAmountDelta ?? 0.0  >= 0.0 {
                mode = .buy(history: history)
            } else {
                mode = .sell(history: history)
            }
        } else {
            if let tradingOrder = history.tradingOrder {
                if tradingOrder.targetAmountDelta ?? 0.0 >= 0.0 {
                    mode = .buy(history: history)
                } else {
                    mode = .sell(history: history)
                }
            } else {
                mode = .other(history: history)
            }
        }
        
        coordinator?.showHistoryOrderDetails(amount: Double(history.amount ?? 0.0),
                                             name: history.name ?? "",
                                             mode: mode)
    }
}

extension DWTTFOrdersViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tradingSections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tradingHistorybyDate[tradingSections[section]]?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: OrderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! OrderCell
        let sectionDate = tradingSections[indexPath.section]
        if let history = tradingHistorybyDate[sectionDate]?[indexPath.row] {
            cell.tradingHistory = history
        }
        cell.contentView.backgroundColor = UIColor(hexString: "#F7F8F9")
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OrderHeaderView", for: indexPath) as! OrderHeaderView
            
            let date = tradingSections[indexPath.section]
            
            if #available(iOS 15, *) {
                let now = Date.now
                if now.hasSame(.year, as: date) && now.hasSame(.month, as: date) && now.hasSame(.day, as: date) {
                    headerView.titleLabel.text = "Today"
                } else {
                    headerView.titleLabel.text = AppDateFormatter.shared.string(from: date, dateFormat: .MMMMddyyyy)
                }
            } else {
                headerView.titleLabel.text = AppDateFormatter.shared.string(from: date, dateFormat: .MMMMddyyyy)
            }
            result = headerView
        default: fatalError("Unhandlad behaviour")
        }
        return result
    }
}
