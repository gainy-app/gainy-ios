import UIKit
import GainyCommon
import CountryKit

public final class StateCell: UICollectionViewCell {
    
    @IBOutlet weak var stateNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var state: String? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        guard let stateName = state else {return}
        self.stateNameLabel.text = stateName
        self.setNeedsLayout()
    }
}
