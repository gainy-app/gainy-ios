//
//  KYCNotifyViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 09.09.2022.
//

import Foundation
import UIKit
import AVFoundation
import GainyCommon

protocol KYCNotifyViewControllerDelegate: AnyObject {
    func notifyViewControllerWillClosePopup()
}

final class KYCNotifyViewController: GainyBaseViewController {
    
    @IBOutlet private weak var emailTextField: GainyTextField!
    @IBOutlet private weak var emailSmallPlaceholder: UILabel!
    @IBOutlet private weak var notifyMeButton: UIButton!
    @IBOutlet private weak var bottomMarigin: NSLayoutConstraint!
    @IBOutlet private weak var cosmoImageView: UIImageView!
    
    weak var delegate: KYCNotifyViewControllerDelegate? = nil
    private var avPlayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var paused: Bool = false
    
    //DI
    var isFromTTF: Bool = false
    var sourceId: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUp()
        self.setupPlayer()
        avPlayer.play()
        paused = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if paused {
            avPlayer.play()
            paused = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        avPlayer.pause()
        paused = true
        self.delegate?.notifyViewControllerWillClosePopup()
    }
    
    //MARK: - Keyboard
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        
        self.bottomMarigin.constant = 16.0 + (keyboardSize?.height ?? 0.0)
        UIView.animate(withDuration: 0.3) {
            self.cosmoImageView.alpha = 0.0
            self.cosmoImageView.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        
        self.bottomMarigin.constant = 32.0
        UIView.animate(withDuration: 0.3) {
            self.cosmoImageView.alpha = 1.0
            self.cosmoImageView.transform = CGAffineTransform.identity
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: .zero, completionHandler: nil)
    }
    
    func setupPlayer() {
        let theURL = Bundle.main.url(forResource:"Gradient_Stars", withExtension: "mp4")

        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = .resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        view.layer.insertSublayer(avPlayerLayer, at: 0)

        NotificationCenter.default.addObserver(self,
                                           selector: #selector(playerItemDidReachEnd(notification:)),
                                           name: .AVPlayerItemDidPlayToEndTime,
                                           object: avPlayer.currentItem)
    }
    
    private func setUp() {
        
        self.setUpNavigationBar()
        self.view.backgroundColor = UIColor.black
        self.emailTextField.insets = UIEdgeInsets(top: 20.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.emailTextField.delegate = self
        self.emailSmallPlaceholder.alpha = 1.0
        self.emailTextField.layer.cornerRadius = 20.0
        let email = ""
        self.emailTextField.text = ""
        self.updatePlaceholderState(email)
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
//        self.navigationController?.navigationBar.titleTextAttributes = [
//                NSAttributedString.Key.foregroundColor: UIColor.white,
//            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14),
//                NSAttributedString.Key.kern: 1.25]
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
        if isFromTTF {
            //GainyAnalytics.logEvent("notify_me_ttf_pressed", params: ["collection_id": sourceId, "email" : self.emailTextField.text ?? "", "ec" : "NotifyViewController"])
        } else {
            //GainyAnalytics.logEvent("notify_me_stock_pressed", params: ["ticker_symbol": sourceId, "email" : self.emailTextField.text ?? "", "ec" : "NotifyViewController"])
        }
        self.dismiss(animated: true)
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        //GainyAnalytics.logEvent("notify_me_tap_close", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "NotifyViewController"])
        self.dismiss(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension KYCNotifyViewController: UITextFieldDelegate {
    
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
        
        guard let notifyButton = self.notifyMeButton else {
            textField.resignFirstResponder()
            return true
        }
        
        textField.resignFirstResponder()
        let notifyButtonEnabled = self.hasValidChanges(textField.text ?? "")
        if notifyButtonEnabled {
            self.notifyButtonTap(notifyButton)
        }
        
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
