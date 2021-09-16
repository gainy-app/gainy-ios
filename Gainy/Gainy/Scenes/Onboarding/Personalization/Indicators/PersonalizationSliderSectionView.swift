//
//  PersonalizationSliderSectionView.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/6/21.
//

import UIKit
import PureLayout

protocol PersonalizationSliderSectionViewDelegate: AnyObject {
    
    func sliderSectionViewFormattedValueString(sender: PersonalizationSliderSectionView, currentValue: Float) -> String
    func sliderSectionViewDidPickValue(sender: PersonalizationSliderSectionView, currentValue: Float)
}

final class PersonalizationSliderSectionView: UIView {

    public weak var delegate: PersonalizationSliderSectionViewDelegate?
    
    private let titleLabel: UILabel = UILabel.newAutoLayout()
    private let descriptionLabel: UILabel = UILabel.newAutoLayout()
    private let gainySliderView: GainySliderView = GainySliderView.newAutoLayout()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        self.setUp()
    }
    
    public func configureWith(currentValue: Float) {
        
        self.gainySliderView.configureWith(currentValue: currentValue)
    }
    
    public func configureWith(minLabelText: String, maxLabelText: String) {
        
        self.gainySliderView.configureWith(minLabelText: minLabelText, maxLabelText: maxLabelText)
    }
    
    public func configureWith(title: String) {
        
        self.titleLabel.text = title
    }
    
    public func configureWith(description: String) {
        
        self.descriptionLabel.text = description
        self.descriptionLabel.sizeToFit()
    }
    
    private func setUp() {
        
        self.setUpTitleLabel()
        self.setUpDescriptionLabel()
        self.setUpSliderView()
    }
    
    private func setUpTitleLabel() {
        
        self.addSubview(self.titleLabel)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 28.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 28.0)
        self.titleLabel.autoPinEdge(toSuperviewEdge: .top)
        self.titleLabel.autoSetDimension(.height, toSize: 24.0)
        
        self.titleLabel.font = UIFont.proDisplayBold(20.0)
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.textAlignment = .left
        self.titleLabel.text = "Title"
    }
    
    private func setUpDescriptionLabel() {
        
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 28.0)
        self.descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 28.0)
        self.descriptionLabel.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 16.0)
        self.descriptionLabel.autoSetDimension(.height, toSize: 24.0, relation: .greaterThanOrEqual)
        self.descriptionLabel.numberOfLines = 0
        
        self.descriptionLabel.font = UIFont.proDisplayRegular(16.0)
        self.descriptionLabel.textColor = UIColor(hexString: "#09141F")
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.text = "Description Description Description Description Description Description Description Description"
        self.descriptionLabel.sizeToFit()
    }
    
    private func setUpSliderView() {
        
        self.addSubview(self.gainySliderView)
        
        self.gainySliderView.autoPinEdge(toSuperviewEdge: .leading, withInset: 28.0)
        self.gainySliderView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 28.0)
        self.gainySliderView.autoPinEdge(toSuperviewEdge: .bottom)
        self.gainySliderView.autoSetDimension(.height, toSize: 80.0)
        self.gainySliderView.autoPinEdge(.top, to: .bottom, of: self.descriptionLabel, withOffset: 38.0)
        self.gainySliderView.configureWith(minLabelText: "MIN", maxLabelText: "MAX")
        self.gainySliderView.delegate = self
    }
}

extension PersonalizationSliderSectionView: GainySliderViewDelegate {
    
    func gainySliderFormattedValueString(sender: GainySliderView, currentValue: Float) -> String {
        return self.delegate?.sliderSectionViewFormattedValueString(sender: self, currentValue: currentValue) ?? "\(currentValue)"
    }
    
    func gainySliderDidPickValue(sender: GainySliderView, currentValue: Float) {
        self.delegate?.sliderSectionViewDidPickValue(sender: self, currentValue: currentValue)
    }
}
