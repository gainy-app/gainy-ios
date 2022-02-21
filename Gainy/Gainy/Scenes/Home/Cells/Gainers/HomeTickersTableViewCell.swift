//
//  HomeTickersTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit

protocol HomeTickersTableViewCellDelegate: AnyObject {
    func altStockPressed(stock: AltStockTicker)
    func comparePressed(stock: AltStockTicker)
    func isStockCompared(stock: AltStockTicker) -> Bool
}

final class HomeTickersTableViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 144.0
    
    private let cellWidth: CGFloat = 144.0
    
    weak var delegate: HomeTickersTableViewCellDelegate?
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
        }
    }
    
    var gainers: [RemoteTicker] = [] {
        didSet {
            innerCollectionView.reloadData()
        }
    }
}

extension HomeTickersTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gainers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeTickerInnerTableViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.stock = gainers[indexPath.row]
        return cell
    }
}

extension HomeTickersTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension HomeTickersTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         //let stock = gainers[indexPath.row]
    }
}

//Will be used further
final class HomeTickerInnerTableViewCell: UICollectionViewCell {
    
    
    weak var delegate: TickerDetailsAlternativeStocksViewCellDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wlBtn: UIButton! {
        didSet {
            wlBtn.setImage(UIImage(named: "add_to_wl"), for: .selected)
            wlBtn.setTitle("", for: .selected)
            
            wlBtn.setImage(UIImage(named: "remove_from_wl"), for: .normal)
            wlBtn.setTitle("", for: .normal)
            
            wlBtn.addTarget(self, action: #selector(compareAction), for: .touchUpInside)
        }
    }
    @IBOutlet private weak var matchCircle: UIImageView! {
        didSet {
            matchCircle.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
            matchCircle.tintColor = .white
        }
    }
    @IBOutlet private weak var matchLabel: UILabel! {
        didSet {
            matchLabel.layer.cornerRadius = 12.0
            matchLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var growLbl: UILabel!
    
    //MARK: - Properties
    var isInWL: Bool = false {
        didSet {
            if isInWL {
                wlBtn.isSelected = true
            } else {
                wlBtn.isSelected = false
            }
        }
    }
    
    var stock: AltStockTicker? {
        didSet {
            guard let stock = stock else {return}
            nameLbl.text = stock.name
            symbolLbl.text = stock.symbol
            
            let storedData = TickerLiveStorage.shared.getSymbolData(stock.symbol ?? "")
            let priceChange = storedData?.priceChangeToday ?? 0.0
            priceLbl.text = storedData?.currentPrice.price ?? ""
            priceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
                  
            growLbl.text = storedData?.priceChangeToday.percent ?? ""
            growLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
            arrowImgView.image = UIImage(named: priceChange >= 0.0 ? "small_up" : "small_down")
            
            if let matchScore = TickerLiveStorage.shared.getMatchData(stock.symbol ?? "")?.matchScore {
                matchLabel.text = "\(matchScore)"
                switch matchScore {
                case 0..<35:
                    matchLabel.backgroundColor = UIColor.Gainy.mainRed
                    break
                case 35..<65:
                    matchLabel.backgroundColor = UIColor.Gainy.mainYellow
                    break
                case 65...:
                    matchLabel.backgroundColor = UIColor.Gainy.mainGreen
                    break
                default:
                    break
                }
                
            } else {
                matchLabel.text = "-"
            }
        }
    }
    
    //MARK: - Actions
    
    @objc func compareAction() {
       
    }
}

//extension TickerDetailsAlternativeStocksViewCell: TickerDetailsAlternativeStocksViewCellDelegate {
//    func isStockCompared(stock: AltStockTicker) -> Bool {
//        delegate?.isStockCompared(stock: stock) ?? false
//    }
//
//    func altStockPressed(stock: AltStockTicker) {
//        delegate?.altStockPressed(stock: stock)
//    }
//
//    func comparePressed(stock: AltStockTicker) {
//        delegate?.comparePressed(stock: stock)
//    }
//}
