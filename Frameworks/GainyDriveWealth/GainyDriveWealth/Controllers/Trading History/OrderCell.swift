import UIKit
import GainyCommon
import CountryKit
import GainyAPI

public final class OrderCell: UICollectionViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel! {
        didSet {
            dateLabel.font = .compactRoundedSemibold(12)
        }
    }
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var ttfTagView: UIView!
    @IBOutlet var typeTagView: UIView!
    @IBOutlet var stateTagView: UIView!
    
    @IBOutlet var typeLabel: UILabel!{
        didSet {
            dateLabel.font = .compactRoundedSemibold(12)
        }
    }
    @IBOutlet var stateLabel: UILabel!{
        didSet {
            dateLabel.font = .compactRoundedSemibold(12)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var tradingHistory: GetProfileTradingHistoryQuery.Data.TradingHistory? {
        didSet {
            self.updateUI()
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.updateUI()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.updateUI()
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return dt
    }()
    
    lazy var dateFormatterShort: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "MM dd, yyyy"
        return dt
    }()
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private func updateUI() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.masksToBounds = true
        
        guard let ttfTagView = self.ttfTagView else {return}
        guard let typeTagView = self.typeTagView else {return}
        guard let stateTagView = self.stateTagView else {return}
        guard let priceLabel = self.priceLabel else {return}
        guard let nameLabel = self.nameLabel else {return}
        guard let dateLabel = self.dateLabel else {return}
        
        guard let typeLabel = self.typeLabel else {return}
        guard let stateLabel = self.stateLabel else {return}
        
        guard let tradingHistory = self.tradingHistory else {return}
        guard let type = ProfileTradingHistoryType.init(rawValue: tradingHistory.type ?? "") else {return}
        guard let priceFloat = tradingHistory.amount else {return}
        guard let dateString = tradingHistory.datetime else {return}
        guard let date = dateFormatter.date(from: dateString) else {return}
        guard let tags = tradingHistory.tags else {return}
        
        let typeKeys = [
        "deposit",
        "withdraw",
        "fee",
        "buy",
        "sell"
        ]
        let stateKeys = [
        "pending",
        "error",
        "cancelled"
        ]
        let ttfKey = "ttf"
        ttfTagView.isHidden = true
        typeTagView.isHidden = true
        stateTagView.isHidden = true
        
        for key in typeKeys {
            if let tag = tags[key] as? Bool, tag == true {
                typeTagView.isHidden = false
                typeLabel.text = key.uppercased()
                break
            }
        }
        
        for key in stateKeys {
            if let tag = tags[key] as? Bool, tag == true {
                stateTagView.isHidden = false
                stateLabel.text = key.uppercased()
                break
            }
        }
        
        if let tag = tags[ttfKey] as? Bool, tag == true {
            ttfTagView.isHidden = false
        }
        
        let dateShortString = dateFormatterShort.string(from: date)
        dateLabel.text = dateShortString
        
        priceLabel.text = priceFloat.price

        nameLabel.text = tradingHistory.name
    
        self.setNeedsLayout()
    }
}
