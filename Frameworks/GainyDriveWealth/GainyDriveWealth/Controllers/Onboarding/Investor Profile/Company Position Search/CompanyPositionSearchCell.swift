import UIKit
import GainyCommon
import CountryKit

public final class CompanyPositionSearchCell: UICollectionViewCell {
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var jobTitleText: String? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        guard let jobTitleText = self.jobTitleText else {return}
        self.jobTitleLabel.text = jobTitleText
        self.jobTitleLabel.numberOfLines = 0
        self.setNeedsLayout()
    }
}
