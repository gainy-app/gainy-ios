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
            tableView.delegate = viewModel?.dataSource
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTicketInfo()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTicketInfo()
    }
    
    func loadTicketInfo() {
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        showNetworkLoader()
        print("SHOWING LOADIER")
        viewModel?.dataSource.ticker.loadDetails {[weak self] in
            print("DISMISS LOADIER")
            self?.hideLoader()
            self?.tableView.reloadData()
        }
        
    }

}
