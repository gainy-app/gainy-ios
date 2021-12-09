//
//  FeatureDescriptionViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 10/22/21.
//

import Foundation
import UIKit

final class FeatureDescriptionViewController: BaseViewController {
    
    private let titleLabel: UILabel = UILabel.newAutoLayout()
    private let descriptionTextView: LinkTextView = LinkTextView.newAutoLayout()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.setUp()
    }
    
    private func setUp() {
        
        self.setUpTitle()
        self.setUpDescription()
    }
    
    
    public func configureWith(title: String) {
        
        self.titleLabel.text = title
        self.titleLabel.numberOfLines = 0
        self.titleLabel.sizeToFit()
    }
    
    public func configureWith(description: String, linkString: String? = nil, link: String? = nil) {
        
        self.descriptionTextView.text = description
        
        if let linkString = linkString, let link = link {
            self.descriptionTextView.addLinks([
                linkString: link
            ])
            self.descriptionTextView.onLinkTap = {[weak self] url in
                if let self = self {
                    WebPresenter.openLink(vc: self, url: url)
                }
                return true
            }
        }
    }
    
    private func setUpTitle() {
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 28.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 28.0)
        self.titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20.0)
        self.titleLabel.numberOfLines = 0
        
        self.titleLabel.font = UIFont.proDisplaySemibold(20.0)
        self.titleLabel.textColor = UIColor.init(hexString: "#1F2E35", alpha: 1.0)
        self.titleLabel.textAlignment = .left
        self.titleLabel.sizeToFit()
    }
    
    private func setUpDescription() {
        
        self.view.addSubview(self.descriptionTextView)
        self.descriptionTextView.isUserInteractionEnabled = true
        self.descriptionTextView.autoPinEdge(toSuperviewEdge: .leading, withInset: 24.0)
        self.descriptionTextView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24.0)
        self.descriptionTextView.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 16.0)
        
        self.descriptionTextView.font = UIFont.proDisplayRegular(14.0)
        self.descriptionTextView.contentInset = .zero
        self.descriptionTextView.textColor = UIColor(hexString: "#687379")
        self.descriptionTextView.textAlignment = .left
        self.descriptionTextView.sizeToFit()
    }
}
