import UIKit
import GainyCommon
import CountryKit

public final class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var countryFlagEmojy: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryPhoneCode: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var country: Country? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        guard let countryName = countryName else {return}
        guard let country = self.country else {return}
        countryName.text = country.name        
        self.setNeedsLayout()
    }
}
