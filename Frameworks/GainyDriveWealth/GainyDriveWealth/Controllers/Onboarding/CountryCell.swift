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
        
        guard let countryFlagEmojy = countryFlagEmojy else {return}
        guard let countryName = countryName else {return}
        guard let countryPhoneCode = countryPhoneCode else {return}
        guard let country = self.country else {return}
        
        countryFlagEmojy.text = country.emoji
        countryName.text = country.localizedName
        countryPhoneCode.text = (country.phoneCode != nil) ? "+\(country.phoneCode!)" : ""
        
        self.setNeedsLayout()
    }
}
