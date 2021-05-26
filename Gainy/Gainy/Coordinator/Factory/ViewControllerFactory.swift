import UIKit

class ViewControllerFactory {
    func instantiateLoginViewController() -> LoginViewController {
//        let loginVC = UIStoryboard.auth.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        loginVC.viewModel = LoginViewModel()
//        return loginVC

        LoginViewController()
    }

    func instantiateAViewController() -> AViewController {
//        let aVC = UIStoryboard.first.instantiateViewController(withIdentifier: "AViewController") as! AViewController
//        aVC.viewModel = AViewModel()
//        return aVC

        AViewController()
    }

    func instantiateProfileViewController() -> ProfileViewController {
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
