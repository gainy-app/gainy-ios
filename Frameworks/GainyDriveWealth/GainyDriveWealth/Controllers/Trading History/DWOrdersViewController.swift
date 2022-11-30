//
//  DWOrdersViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 05.10.2022.
//

import UIKit
import GainyCommon
import GainyAPI

/// Profile History Types
public enum ProfileTradingHistoryType: String, CaseIterable {
    case deposit = "deposit"
    case withdraw = "withdraw"
    case tradingFee = "trading_fee"
    case ttfTransactions = "ttf_transaction"
}

extension GetProfileTradingHistoryQuery.Data.TradingHistory: TradingHistoryData {

}

public final class DWOrdersViewController: DWBaseViewController {

    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
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

    private var tradingHistory: [GetProfileTradingHistoryQuery.Data.TradingHistory] = []
    private var tradingHistorybyDate: [[Date : [GetProfileTradingHistoryQuery.Data.TradingHistory]]] = []

    //MARK: - Life Cycle
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gainyNavigationBar.configureWithItems(items: [.close])
        gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        
        loadState()
    }

    lazy var dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return dt
    }()
    
    lazy var dateFormatterShort: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "MMMM dd, yyyy"
        return dt
    }()

    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    private func loadState() {

        
        showNetworkLoader()
        Task {
            guard (await userProfile.getProfileStatus()) != nil else {
                await MainActor.run {
                    hideLoader()
                }
                return
            }


            let types = GainyDriveWealth.ProfileTradingHistoryType.allCases.compactMap { item in
                item.rawValue
            }
            let tradingHistory = await userProfile.getProfileTradingHistory(types: types) as! [GetProfileTradingHistoryQuery.Data.TradingHistory]

            await MainActor.run {
                tradingHistorybyDate = []
                hideLoader()

                 let sorted = tradingHistory.sorted { item1, item2 in
                     if let date1 = dateFormatter.date(from: item1.datetime ?? ""),
                        let date2 = dateFormatter.date(from: item1.datetime ?? "") {
                         return date1 > date2
                     }
                     return false
                 }

                 var currentDateHistory: [GetProfileTradingHistoryQuery.Data.TradingHistory] = []
                 var previousDate: Date? = nil
                 for item in sorted {
                     if let date = dateFormatter.date(from: item.datetime ?? "") {

                         if let datePrev = previousDate {
                             if datePrev.fullDistance(from: date, resultIn: .day) == 0 {
                                 currentDateHistory.append(item)
                             } else {
                                 tradingHistorybyDate.append([date : currentDateHistory])
                                 currentDateHistory = []
                                 currentDateHistory.append(item)
                             }
                         } else {
                             currentDateHistory.append(item)
                         }
                         previousDate = date
                     }
                 }
                 if let date = dateFormatter.date(from: currentDateHistory.first?.datetime ?? "") {
                     tradingHistorybyDate.append([date : currentDateHistory])
                 }


                self.collectionView.reloadData()
            }
        }
    }

    //MARK: - Actions

    @IBAction func safeAsPDFAction(_ sender: Any) {
        coordinator?.navController.dismiss(animated: true)
    }
}

extension DWOrdersViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 88.0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 48)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

//        let country = self.countries[indexPath.row]
//        self.delegate?.countrySearchViewController(sender: self, didPickCountry: country)
        return false
    }
}

extension DWOrdersViewController: UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = tradingHistorybyDate.count
        return count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = tradingHistorybyDate[section].first?.value.count ?? 0
        return count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: OrderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! OrderCell
        guard let value = tradingHistorybyDate[indexPath.section].first?.value else {
            return cell
        }
        let history = value[indexPath.row]
        cell.tradingHistory = history

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "OrderHeaderView", for: indexPath) as! OrderHeaderView
            
            guard let value = tradingHistorybyDate[indexPath.section].first?.value else {
                return headerView
            }
            if let date = dateFormatter.date(from: value[indexPath.row].datetime ?? "") {
                if #available(iOS 15, *) {
                    if Date.now.fullDistance(from: date, resultIn: .day) == 0 {
                        headerView.titleLabel.text = "Today"
                    } else {
                        headerView.titleLabel.text = dateFormatterShort.string(from: date)
                    }
                } else {
                    headerView.titleLabel.text = dateFormatterShort.string(from: date)
                }
            }
            result = headerView
        default: fatalError("Unhandlad behaviour")
        }
        return result
    }
}

extension Date {

    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }

    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
}
