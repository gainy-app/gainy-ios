import UIKit
import GainyCommon
import CountryKit

public final class KeyValueCell: UICollectionViewCell {

    @IBOutlet weak var valueLabel: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    var value: String? {
        didSet {
            self.updateUI()
        }
    }

    private func updateUI() {

        guard let valueText = value else {return}
        self.valueLabel.text = valueText
        self.valueLabel.numberOfLines = 0
        self.setNeedsLayout()
    }
}
