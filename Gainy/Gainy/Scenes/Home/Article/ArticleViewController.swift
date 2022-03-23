//
//  ArticleViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 02.03.2022.
//

import UIKit
import WebKit

final class ArticleViewController: BaseViewController {
    
    var articleUrl: String = ""
    
    //MARK: - Outlets
    @IBOutlet private var webView: WKWebView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadArticle()
    }
    
    private func loadArticle() {
        guard !articleUrl.isEmpty else {
            return
        }
        
        webView.load(URLRequest.init(url: URL(string: articleUrl)!))
    }
    
    //MARK: - Actions    
    @IBAction func closeAction() {
        dismiss(animated: true, completion: nil)
    }
}
