import UIKit

// A models

enum A {}

// A view model

protocol AViewModelProtocol {}

class AViewModel: NSObject, AViewModelProtocol {
    // MARK: - Init

    override init() {
        super.init()
    }
}

// Impl

protocol AViewControllerProtocol: BaseViewControllerProtocol {
    var onGoToB: (() -> Void)? { get set }
    var onGoToProfile: (() -> Void)? { get set }
}

class AViewController: UIViewController, AViewControllerProtocol {
    // MARK: - AViewControllerProtocol

    var onGoToB: (() -> Void)?
    var onGoToProfile: (() -> Void)?

    // MARK: - Vars & Lets

    var viewModel: AViewModelProtocol?

    // MARK: - Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions

    @IBAction func goToB() {
        self.onGoToB?()
    }

    @IBAction func profile() {
        self.onGoToProfile?()
    }
}
