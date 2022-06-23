import Foundation
import UIKit

final class NotifyViewController: BaseViewController {
    
    @IBOutlet private weak var emailTextField: GainyTextField!
    @IBOutlet private weak var emailSmallPlaceholder: UILabel!
    @IBOutlet private weak var notifyMeButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUp()
    }
    
    private func setUp() {
        
        self.setUpNavigationBar()
        self.view.backgroundColor = UIColor.black
        self.emailTextField.insets = UIEdgeInsets(top: 20.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.emailTextField.delegate = self
        self.emailSmallPlaceholder.alpha = 1.0
        self.emailTextField.layer.cornerRadius = 20.0
        self.updatePlaceholderState("")
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14),
                NSAttributedString.Key.kern: 1.25]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = NSLocalizedString("Notify me", comment: "Notify me").uppercased()

        let closeImage = UIImage(named: "iconClose")?.withRenderingMode(.alwaysTemplate)
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [closeItem]
    }
    
    @IBAction func notifyButtonTap(_ sender: Any) {
        if !self.hasValidChanges(self.emailTextField.text ?? "") {
            self.emailTextField.becomeFirstResponder()
            return
        }
        GainyAnalytics.logEvent("notify_me_tap_notify", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "eamil" : self.emailTextField.text ?? "", "ec" : "NotifyViewController"])
        self.dismiss(animated: true)
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("notify_me_tap_close", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "NotifyViewController"])
        self.dismiss(animated: true)
    }
}

extension NotifyViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        self.updatePlaceholderState(updatedText)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        self.updatePlaceholderState(textField.text ?? "")
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.emailTextField.becomeFirstResponder()
        return true
    }
    
    private func updatePlaceholderState(_ text: String) {
        
        let gainyTextField: GainyTextField? = self.emailTextField
        let placeholderLabel: UILabel? = self.emailSmallPlaceholder
        let notifyButtonEnabled = self.hasValidChanges(text)
        let notifyButton = self.notifyMeButton
        
        UIView.animate(withDuration: 0.25) {
            let topInset: CGFloat = ((text.count > 0) ? 20.0 : 0.0)
            gainyTextField?.insets = UIEdgeInsets(top: topInset, left: 16.0, bottom: 0.0, right: 16.0)
            gainyTextField?.setNeedsDisplay()
            gainyTextField?.setNeedsLayout()
            placeholderLabel?.alpha = ((text.count > 0) ? 1.0 : 0.0)
//            notifyButton?.isUserInteractionEnabled = notifyButtonEnabled
            notifyButton?.alpha = notifyButtonEnabled ? 1.0 : 0.65
        }
    }
    
    private func hasValidChanges(_ text: String) -> Bool {
        
        let hasValidChanges = self.isValidEmailString(emailString: text)
        return hasValidChanges
    }
    
    private func isValidEmailString(emailString: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let validEmail = emailPredicate.evaluate(with: emailString)
        
        return validEmail
    }
}
