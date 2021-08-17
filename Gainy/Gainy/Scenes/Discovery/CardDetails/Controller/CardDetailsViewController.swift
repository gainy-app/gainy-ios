import UIKit

// TODO: move into a separate file
protocol CardDetailsViewModelProtocol {
//    var initialCollectionIndex: Int { get set }
//    var collectionDetails: [CollectionDetailViewCellModel] { get set }
}

final class CardDetailsViewModel: NSObject, CardDetailsViewModelProtocol {
//    var initialCollectionIndex = 0
//    var collectionDetails = [CollectionDetailViewCellModel]()
}


final class CardDetailsViewController: UIViewController, CardDetailsViewControllerProtocol {
    // MARK: Internal

    // MARK: Properties

    var viewModel: CardDetailsViewModel?

    var onDismiss: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Gainy.white
    }

}
