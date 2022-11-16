import UIKit

public final class StatementsCell: UICollectionViewCell {
    
    @IBOutlet weak var statementsGroupLabel: UILabel!
    @IBOutlet weak var actionIcon: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var statementsGroupName: String? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        
        guard let statementsName = self.statementsGroupName else {return}
        
        self.statementsGroupLabel.text = statementsName
        self.setNeedsLayout()
    }
}
