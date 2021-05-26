import UIKit

class ViewControllerFactory {
    func instantiateLogin() -> LoginViewController {
//        let loginVC = UIStoryboard.auth.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        loginVC.viewModel = LoginViewModel()
//        return loginVC

        LoginViewController()
    }

    func instantiateDiscoverCollections() -> DiscoverCollectionsViewController {
        let vc = DiscoverCollectionsViewController()
        vc.viewModel = DiscoverCollectionsViewModel()
        return vc
    }

    func instantiateProfile() -> ProfileViewController {
//        let profileVC = UIStoryboard.profile.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//        profileVC.viewModel = ProfileViewModel()
//        return profileVC
        ProfileViewController()
    }

//    func instantiateBViewController(delegate: BViewControllerDelegate) -> BViewController {
//        let bVC = UIStoryboard.first.instantiateViewController(withIdentifier: "BViewController") as! BViewController
//        bVC.viewModel = BViewModel()
//        bVC.delegate = delegate
//        return bVC
//    }
}
