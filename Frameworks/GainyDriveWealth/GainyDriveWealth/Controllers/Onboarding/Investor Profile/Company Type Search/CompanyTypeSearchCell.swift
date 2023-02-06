import UIKit
import GainyCommon
import CountryKit

public final class CompanyTypeSearchCell: UICollectionViewCell {
    
    @IBOutlet weak var companyTypeLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var companyTypeText: String? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        guard let companyTypeText = self.companyTypeText else {return}
        self.companyTypeLabel.text = companyTypeText
        self.companyTypeLabel.numberOfLines = 0

        self.setNeedsLayout()
    }
}
