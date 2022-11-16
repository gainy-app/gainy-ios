import UIKit

public final class StatementCell: UICollectionViewCell {
    
    @IBOutlet weak var statementLabel: UILabel!
    @IBOutlet weak var actionIcon: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var statementName: String? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        guard let statementName = self.statementName else {return}
        
        self.statementLabel.text = statementName
        self.setNeedsLayout()
    }
}
