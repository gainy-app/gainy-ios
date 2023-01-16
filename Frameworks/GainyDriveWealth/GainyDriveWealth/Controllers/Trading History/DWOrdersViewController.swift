//
//  DWOrdersViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 05.10.2022.
//

import UIKit
import GainyCommon
import GainyAPI
import FloatingPanel

/// Profile History Types
public enum ProfileTradingHistoryType: String, CaseIterable, Codable {
    case all = "all"
    case deposit = "deposit"
    case withdraw = "withdraw"
    case tradingFee = "trading_fee"
    case ttfTransactions = "ttf_transaction"
    case tickerTransaction = "ticker_transaction"
    
    var title: String {
        get {
            switch self {
            case .all: return "All Transactions"
            case .deposit: return "Deposit"
            case .withdraw: return "Withdraw"
            case .tradingFee: return "Trading Fee"
            case .ttfTransactions: return "TTF Transactions"
            case .tickerTransaction: return "Ticker Transactions"
            }
        }
    }
}


extension GainyTradingHistory: TradingHistoryData {
    
}

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

public typealias GainyTradingHistory = TradingHistoryFrag


extension GainyTradingHistory {
    var isCancellable: Bool {
        if let tradingCollectionVersion {
            return tradingCollectionVersion.status == "PENDING"
        }
        if let tradingOrder {
            return tradingOrder.status == "PENDING"
        }
        return false
    }
    
    var isTTF: Bool {
        tradingCollectionVersion != nil
    }
    
    var isStock: Bool {
        tradingOrder != nil
    }
}

public final class DWOrdersViewController: DWBaseViewController {
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
        }
    }
    
    @IBOutlet weak var sortingLabel: UILabel!
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            
            self.collectionView.register(UINib.init(nibName: "OrderCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "OrderCell")
            self.collectionView.register(UINib.init(nibName: "OrderHeaderView", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "OrderHeaderView")
            
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
    }
    
    private var tradingHistory: [GainyTradingHistory] = []
    private var tradingSections: [Date] = []
    private var tradingHistorybyDate: [Date : [GainyTradingHistory]] = [:]
    
    //MARK: - Life Cycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gainyNavigationBar.configureWithItems(items: [.close])
        gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        setupPanel()
        loadState(filterBy: sortingVS.selectedSorting, ascending: sortingVS.ascending)
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    private var panel: FloatingPanelController!
    //    //Hosted VCs
    private lazy var sortingVS = DWFilterOrdersViewController.instantiate(.deposit) {
        didSet {
            sortingVS.delegate = self
            sortingVS.ascending = false
            sortingVS.selectedSorting = .all
        }
    }
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    
    
    private func setupPanel() {
        panel = FloatingPanelController()
        panel.layout = FilterPanelLayout()
        let appearance = SurfaceAppearance()
        
        // Define corner radius and background color
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear
        
        // Set the new appearance
        panel.surfaceView.appearance = appearance
        
        // Assign self as the delegate of the controller.
        //panel.delegate = self // Optional
        
        // Set a content view controller.
        sortingVS.delegate = self
        panel.set(contentViewController: sortingVS)
        panel.isRemovalInteractionEnabled = true
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        //fpc.addPanel(toParent: self)
    }
    
    private func loadState(filterBy: ProfileTradingHistoryType = .all, ascending: Bool = true) {
        
        tradingSections = []
        tradingHistorybyDate = [:]
        
        showNetworkLoader()
        Task {
            guard (await userProfile.getProfileStatus()) != nil else {
                await MainActor.run {
                    hideLoader()
                }
                return
            }
            
            var typesAll = [ProfileTradingHistoryType.deposit, .withdraw, .tradingFee, .ttfTransactions, .tickerTransaction]
            if filterBy != .all {
                typesAll = [filterBy]
            }
            let types = typesAll.compactMap { item in
                item.rawValue
            }
            let tradingHistory = await userProfile.getProfileTradingHistory(types: types) as! [TradingHistoryFrag]
            
            tradingHistorybyDate = Dictionary(grouping: tradingHistory) { $0.date.startOfDay}
            tradingSections = tradingHistorybyDate.keys.sorted(by: { if ascending {
                return $0 < $1} else {
                    return $0 > $1
                }})
            print(tradingSections)
            await MainActor.run {
                hideLoader()
                
                self.sortingLabel.text = filterBy.title
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func filterByAction(_ sender: Any) {
        guard self.presentedViewController == nil else {return}
        self.panel.set(contentViewController: sortingVS)
        self.present(self.panel, animated: true, completion: nil)
    }
    
    
    class FilterPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 335.0, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 335.0, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 335.0, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
        
        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            switch state {
            case .full,
                    .half,
                    .tip: return 0.3
            default: return 0.0
            }
        }
    }
}

extension DWOrdersViewController: UICollectionViewDelegateFlowLayout {
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

extension DWOrdersViewController: UICollectionViewDataSource {
    
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



//extension DWOrdersViewController: FloatingPanelControllerDelegate {
//    public func floatingPanelDidMove(_ vc: FloatingPanelController) {
//        if vc.isAttracting == false {
//
//            if let prevY = floatingPanelPreviousYPosition {
//                shouldDismissFloatingPanel = prevY < vc.surfaceLocation.y
//            }
//            let loc = vc.surfaceLocation
//            let minY = vc.surfaceLocation(for: .full).y
//            let maxY = vc.surfaceLocation(for: .tip).y
//            vc.surfaceLocation = CGPoint(x: loc.x, y: max(loc.y, minY))
//            floatingPanelPreviousYPosition = max(loc.y, minY)
//        }
//    }
//
//    public func floatingPanelDidEndDragging(_ fpc: FloatingPanelController, willAttract attract: Bool) {
//        if shouldDismissFloatingPanel {
//            self.panel.dismiss(animated: true, completion: nil)
//        }
//    }
//}

extension DWOrdersViewController: DWFilterOrdersViewControllerDelegate {
    func selectionChanged(vc: DWFilterOrdersViewController, filterBy: ProfileTradingHistoryType, ascending: Bool) {
        self.panel.dismiss(animated: true) {
            self.loadState(filterBy: filterBy, ascending: ascending)
        }
    }
}
