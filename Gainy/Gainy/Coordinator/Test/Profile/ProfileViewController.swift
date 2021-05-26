import UIKit

// M

enum Profile {
}

// VC

protocol ProfileViewModelProtocol {
}

class ProfileViewModel: NSObject, ProfileViewModelProtocol {
    // MARK: - Init

    override init() {
        super.init()
    }
}

// I

protocol ProfileViewControllerProtocol: AnyObject {
    var onBack: (() -> Void)? { get set }
    var onChangePassword: (() -> Void)? { get set }
}

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    // MARK: - ProfileViewControllerProtocol

    var onBack: (() -> Void)?
    var onChangePassword: (() -> Void)?

    // MARK: - Vars & Lets

    var viewModel: ProfileViewModelProtocol?

    // MARK: - Controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions

    @IBAction func back() {
        self.onBack?()
    }

    @IBAction func changePassword() {
        self.onChangePassword?()
    }
}
