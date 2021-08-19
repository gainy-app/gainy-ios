import UIKit

// TODO: move into a separate file
protocol CardDetailsViewModelProtocol {
//    var initialCollectionIndex: Int { get set }
//    var collectionDetails: [CollectionDetailViewCellModel] { get set }
}


final class TickerViewController: BaseViewController {
    
    //MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: TickerDetailsViewModel?
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel?.dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
