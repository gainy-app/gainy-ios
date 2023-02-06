import UIKit
import GainyCommon
import CountryKit

public final class SingleRowCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var text: String? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        guard let text = text else {return}
        self.textLabel.text = text
        self.setNeedsLayout()
    }
    
    public override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            self.textLabel.textColor = newValue ? UIColor.white : UIColor.black
            self.bgView.backgroundColor = newValue ? (UIColor(hexString: "#0062FF") ?? UIColor.blue) : UIColor.white
        }
    }
}
