//
//  SearchStocksViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.11.2021.
//

import UIKit
import PureLayout

protocol SearchStocksViewControllerDelegate: AnyObject {
    func stockSelected(source: SearchStocksViewController, stock: RemoteTickerDetails)
}

final class SearchStocksViewController: BaseViewController {
    
    weak var delegate: SearchStocksViewControllerDelegate?
    
    //MARK: - Outlets
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
        }
    }
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loaderView: UIActivityIndicatorView!
    
    @IBOutlet private weak var searchFld: UITextField! {
        didSet {
            searchFld.font = UIFont(name: "SFProDisplay-Regular", size: 16)
            searchFld.textColor = UIColor(named: "mainText")
            searchFld.layer.cornerRadius = 16
            searchFld.isUserInteractionEnabled = true
            searchFld.placeholder = "Search stocks"
            let searchIconContainerView = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 14 + 24 + 6,
                    height: 24
                )
            )
            
            let searchIconImageView = UIImageView(
                frame: CGRect(
                    x: 14,
                    y: 0,
                    width: 24,
                    height: 24
                )
            )
            
            searchIconContainerView.addSubview(searchIconImageView)
            
            searchIconImageView.contentMode = .center
            searchIconImageView.backgroundColor = UIColor.Gainy.lightBack
            searchIconImageView.image = UIImage(named: "search")
            
            searchFld.leftView = searchIconContainerView
            searchFld.leftViewMode = .always
            searchFld.rightViewMode = .whileEditing
            searchFld.backgroundColor = UIColor.Gainy.lightBack
            searchFld.returnKeyType = .done
            
            let btnFrame = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 24 + 12, height: 24))
            let clearBtn = UIButton(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 24,
                    height: 24
                )
            )
            clearBtn.setImage(UIImage(named: "search_clear"), for: .normal)
            clearBtn.addTarget(self, action: #selector(textFieldClear), for: .touchUpInside)
            btnFrame.addSubview(clearBtn)
            searchFld.rightView = btnFrame
            
            searchFld.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
            searchFld.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
            searchFld.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            searchFld.delegate = self
        }
    }
    
    //MARK: - Inner
    
    private var viewModel: SearchStocksViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        
    }
    
    private func initViewModel() {
        viewModel = SearchStocksViewModel.init(tableView: tableView)
        viewModel.loading = {[weak self] loading in
            guard let self = self else {return}
            if loading {
                self.loaderView.startAnimating()
            } else {
                self.loaderView.stopAnimating()
            }
        }
        tableView.delegate = viewModel
        viewModel.delegate = self
    }
    
    //MARK: - Keyboard
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: self.keyboardSize?.height ?? 0.0, right: 0)
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        tableView.contentInset = .zero
    }
    
    //MARK: - Actions
    
    @objc func textFieldClear() {
        searchFld?.text = ""
        viewModel.searchText = searchFld?.text ?? ""
        viewModel.clearAll()
        
        searchFld?.resignFirstResponder()
    }
    
    
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        GainyAnalytics.logEvent("add_stock_search_started", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SearchStocksViewController"])
        viewModel.searchText =  ""
    }
    
    @objc func textFieldEditingDidEnd(_ textField: UITextField) {
        GainyAnalytics.logEvent("add_stock_search_ended", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SearchStocksViewController"])
    }
}

extension SearchStocksViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let text = textField.text ?? ""
        viewModel.searchText = text
        
        if text.count > 0 {
            searchFld?.clearButtonMode = .always
            searchFld?.clearButtonMode = .whileEditing
        } else {
            searchFld?.clearButtonMode = .never
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchStocksViewController: SearchStocksViewModelDelegate {
    func stockSelected(source: SearchStocksViewModel, stock: RemoteTickerDetails) {
        delegate?.stockSelected(source: self, stock: stock)
    }
}
