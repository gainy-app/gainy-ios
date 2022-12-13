//
//  KYCEnterPasscodeViewController.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 13.12.22.
//

import UIKit
import GainyCommon

class KYCEnterPasscodeViewController: DWBaseViewController {
    
    public var state: KYCPasscodeViewControllerState = .enter
    private var codeString: String = ""
    public var passcode: String = "????"
    
    @IBOutlet private weak var padView: GainyPadView! {
        didSet {
            padView.delegate = self
        }
    }
    
    @IBOutlet var codeSymbols: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension KYCEnterPasscodeViewController: GainyPadViewDelegate {
    func deleteDigit(view: GainyPadView) {
        if codeString.count <= 4 {
            codeString = String(codeString.dropLast(1))
        }
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        if codeString.count < 4 {
            codeString.append(digit)
        }
        validateAmount()
    }
    
    func validateAmount() {
        
        let count = self.codeString.count
        var valid = count == 4
        if self.state == .enter {
            valid = (self.passcode == self.codeString)
        }
        
        var string = self.codeString
        for i in 0..<self.codeSymbols.count {
            let label = self.codeSymbols[i]
            let first = String(string.prefix(1))
            if first.isEmpty {
                label.text = "・"
                label.textColor = UIColor(hexString: "#B1BDC8")
            } else {
                label.text = "・"
                label.textColor = UIColor(hexString: "#0062FF")
            }
            string = String(string.dropFirst())
        }
    }
}
