//
//  GainyTextFieldControl.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/21/21.
//

import UIKit
import PureLayout
    
public protocol GainyTextFieldControlDelegate: AnyObject {
    
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl)
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl)
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String)
}

public class GainyTextFieldControl: UIControl {
    
    open weak var delegate: GainyTextFieldControlDelegate?
    
    open var text: String {
        get {
            return self.textField.text ?? ""
        }
    }
    
    open var keyboardType: UIKeyboardType {
        get {
            return self.textField.keyboardType
        }
        set {
            self.textField.keyboardType = newValue
        }
    }
    
    open var isEditing: Bool {
        get {
            return self.textField.isFirstResponder
        }
        set {
            if newValue {
                self.isActive = true
                self.textField.becomeFirstResponder()
            } else {
                self.isActive = false
                self.textField.resignFirstResponder()
            }
        }
    }
    
    open var isActive: Bool {
        get {
            return active
        }
        set {
            self.updateActive(newValue: newValue)
            active = newValue
        }
    }

    open var overrideHitTest: Bool {
        get {
            return self.textField.overrideHitTest
        }
        set {
            self.textField.overrideHitTest = newValue
        }
    }
    
    open var textFieldEnabled: Bool {
        get {
            return self.textField.isUserInteractionEnabled
        }
        set {
            self.textField.isUserInteractionEnabled = newValue
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        GainyTextFieldControlManager.shared.addTextField(textField: self)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupUI()
        GainyTextFieldControlManager.shared.addTextField(textField: self)
    }
    
    public func configureWithText(text: String) {
        self.textField.text = text
        self.updatePlaceholderState(text)
    }
    
    deinit {
        GainyTextFieldControlManager.shared.reap()
    }
    
    public func configureWithText(text: String, placeholder: String, smallPlaceholder: String) {
        
        self.textField.text = text
        self.textField.placeholder = placeholder
        self.smallPlaceholder.text = smallPlaceholder.uppercased()
        self.updatePlaceholderState(text)
    }
    
    private var textField: GainyTextField = GainyTextField.newAutoLayout()
    private var smallPlaceholder: UILabel = UILabel.newAutoLayout()
    private var active: Bool = false
    
    private func updateActive(newValue: Bool) {
        
        self.layer.borderColor = (newValue ? (UIColor(hexString: "#0062FF") ?? UIColor.blue) : UIColor.clear).cgColor
        self.layer.borderWidth = 2.0
    }
    
    private func setupUI() {
        
        self.addSubview(self.smallPlaceholder)
        self.smallPlaceholder.autoPinEdge(toSuperviewEdge: .leading, withInset: 16.0)
        self.smallPlaceholder.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16.0)
        self.smallPlaceholder.autoPinEdge(toSuperviewEdge: .top, withInset: 14.0)
        self.smallPlaceholder.autoSetDimension(.height, toSize: 12.0)
        self.smallPlaceholder.font = .compactRoundedSemibold(10.0)
        self.smallPlaceholder.textColor = UIColor(hexString: "#B1BDC8") ?? UIColor.lightGray
        self.smallPlaceholder.text = "Your text".uppercased()
        self.smallPlaceholder.alpha = 0.0
        
        self.addSubview(self.textField)
        self.textField.autoPinEdgesToSuperviewEdges()
        self.textField.insets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.textField.font = .proDisplayMedium(16.0)
        self.textField.placeholder = "Type your text"
        self.textField.tintColor = UIColor(hexString: "#0062FF") ?? UIColor.blue
        self.textField.textColor = UIColor.black
        self.textField.delegate = self
        self.textField.overrideHitTest = true
        self.textField.keyboardType
        
        self.layer.cornerRadius = 16.0
        self.layer.masksToBounds = true
        self.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    }
    
    @objc private func didTouchUpInside() {
        
        guard self.isActive == false else {
            return
        }
        
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }) { finished in
        }
        self.isActive = true
        if self.textFieldEnabled {
            self.textField.becomeFirstResponder()
        }
        self.delegate?.gainyTextFieldDidStartEditing(sender: self)
        GainyTextFieldControlManager.shared.resignFirstResponders(textField: self)
   }
}

extension GainyTextFieldControl: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
       
        self.updatePlaceholderState(updatedText)
        self.delegate?.gainyTextFieldDidUpdateText(sender: self, text: updatedText)
        
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        self.updatePlaceholderState("")
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.isActive = false
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.isActive = true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.delegate?.gainyTextFieldDidEndEditing(sender: self)
        textField.resignFirstResponder()
        return true
    }

    private func updatePlaceholderState(_ text: String) {
        
        UIView.animate(withDuration: 0.25) {
            let topInset: CGFloat = ((text.count > 0) ? 8.0 : 0.0)
            self.textField.insets = UIEdgeInsets(top: topInset, left: 16.0, bottom: 0.0, right: 16.0)
            self.textField.setNeedsDisplay()
            self.textField.setNeedsLayout()
            self.smallPlaceholder.alpha = ((text.count > 0) ? 1.0 : 0.0)
        }
    }
}


class Weak<T: GainyTextFieldControl> {
  weak var value : T?
  init (value: T) {
    self.value = value
  }
}

extension Array where Element:Weak<GainyTextFieldControl> {
  mutating func reap () {
    self = self.filter { nil != $0.value }
  }
}

private final class GainyTextFieldControlManager {
    
    static let shared = GainyTextFieldControlManager()
    private var weaklyTextFields : [Weak<GainyTextFieldControl>] = []
    
    public func reap () {
        self.weaklyTextFields.reap()
    }
    
    public func addTextField(textField: GainyTextFieldControl) {
        let weakTextField: Weak<GainyTextFieldControl> = Weak.init(value: textField)
        self.weaklyTextFields.insert(weakTextField, at: 0)
    }
    
    public func resignFirstResponders(textField: GainyTextFieldControl) {
     
        let fields = self.weaklyTextFields.compactMap({ item in
            return item.value
        })
        
        for item: GainyTextFieldControl in fields {
            if item != textField {
                item.isEditing = false
            }
        }
    }
}
