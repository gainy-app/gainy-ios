import UIKit
import GainyCommon
import CountryKit
import GainyAPI

public final class OrderCell: UICollectionViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel! {
        didSet {
            dateLabel.font = .compactRoundedSemibold(12)
        }
    }
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private weak var tagsStack: UIStackView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var tradingHistory: TradingHistoryFrag? {
        didSet {
            self.updateUI()
        }
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private var tags: [DWHistoryTag] = []
    
    private func updateUI() {
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.masksToBounds = true
        
        guard let priceLabel = self.priceLabel else {return}
        guard let nameLabel = self.nameLabel else {return}
        guard let dateLabel = self.dateLabel else {return}
        
        guard let tradingHistory = self.tradingHistory else {return}
        guard let priceFloat = tradingHistory.amount else {return}
        guard let dateString = tradingHistory.datetime else {return}
        guard let date = AppDateFormatter.shared.date(from: dateString, dateFormat: .yyyyMMddHHmmssSSSSSSZ) else {return}
        guard let modelTags = tradingHistory.tags else {return}
        
        let typeKeys = TradeTags.TypeKey.allCases.compactMap({$0.rawValue})
        let stateKeys = TradeTags.StateKey.allCases.compactMap({$0.rawValue})

        tagsStack.arrangedSubviews.forEach({
            tagsStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
        tags.removeAll()
        
        for key in typeKeys {
            if let tag = modelTags[key] as? Bool, tag == true {
                tags.append(DWHistoryTag.init(name: key.uppercased()))
            }
        }
        let typeTags: Set<String> =  Set<String>.init(tags.compactMap({$0.name.lowercased()}))
        
        for key in stateKeys {
            if let tag = modelTags[key] as? Bool, tag == true {
                tags.append(DWHistoryTag.init(name: key.uppercased()))
            }
        }
        
        for tag in tags {
            let tagView = TagLabelView()
            tagView.tagText = tag.name
            tagView.textColor = UIColor(hexString: tag.colorForTag() ?? "")
            tagsStack.addArrangedSubview(tagView)
        }
        
        let dateShortString = AppDateFormatter.shared.string(from: date, dateFormat: .MMMMddyyyy)   
        dateLabel.text = dateShortString
        priceLabel.text = abs(priceFloat).price
        nameLabel.text = tradingHistory.name
    
        self.setNeedsLayout()
    }
}
