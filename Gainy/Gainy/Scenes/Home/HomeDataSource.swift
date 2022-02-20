//
//  HomeDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import SkeletonView
import Apollo
import SwiftDate

protocol HomeDataSourceDelegate: AnyObject {
    
}

final class HomeDataSource: NSObject {
    
    override init() {
        cellHeights[.index] = HomeIndexesTableViewCell.cellHeight
    }
    
    //MARK: - Delegate
    weak var delegate: HomeDataSourceDelegate?
    
    //MARK: - Sections
    private let sectionsCount = 1
    
    enum Section: Int {
        case index = 0, gainers, losers, collections, articles
        
        var name: String {
            switch self {
            case .index:
                return ""
            case .collections:
                return "Updates in your collections"
            case .gainers:
                return "Top gainers in your collections"
            case .losers:
                return "Top loser in your collections"
            case .articles:
                return "Articles for you you"
                
            }
        }
    }
    
    private var articles: [String] = []
    
    //MARK: - Heights
    private var cellHeights: [Section: CGFloat] = [:]
    private var expandedCells: Set<String> = Set<String>()
    private weak var tableView: UITableView?
    private let refreshControl = LottieRefreshControl()

    //
}

extension HomeDataSource: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return HoldingsSkeletonTableViewCell.cellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = skeletonView.dequeueReusableCell(withIdentifier: HoldingsSkeletonTableViewCell.cellIdentifier, for: indexPath) as? HoldingsSkeletonTableViewCell
        cell?.isSkeletonable = true
        cell?.contentView.subviews[0].subviews.forEach({
            $0.isSkeletonable = true
            $0.skeletonCornerRadius = 6
            if let lbl =  $0 as? UILabel {
                lbl.linesCornerRadius = 6
            }
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section.articles.rawValue {
            return articles.count
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView = tableView
        
        switch Section(rawValue: indexPath.section)! {
        case .index:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeIndexesTableViewCell.cellIdentifier, for: indexPath) as! HomeIndexesTableViewCell
            cell.updateIndexes()
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
}

extension HomeDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[Section(rawValue: indexPath.section)!] ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    //MARK: - Headers
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor(named: "mainText")!
        headerLabel.font = .proDisplaySemibold(20)        
        headerLabel.text = Section(rawValue: section)!.name
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == Section.index.rawValue {
            return 0.0
        } else {
            return 62.0
        }
    }
}

