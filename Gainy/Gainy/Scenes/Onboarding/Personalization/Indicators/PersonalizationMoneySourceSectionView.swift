//
//  PersonalizationTitlePickerSectionView.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/6/21.
//

import UIKit
import PureLayout

protocol PersonalizationTitlePickerSectionViewDelegate: AnyObject {
    
    func personalizationTitlePickerDidPickSources(sender: PersonalizationTitlePickerSectionView, sources: [String]?)
}

final class PersonalizationTitlePickerSectionView: UIView {
    
    public weak var delegate: PersonalizationTitlePickerSectionViewDelegate?
    
    private let titleLabel: UILabel = UILabel.newAutoLayout()
    private let descriptionLabel: UILabel = UILabel.newAutoLayout()
    private var collectionView: UICollectionView?
    
    private var sources: [String]?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        self.setUp()
    }
    
    public func configureWith(sources: [String]?) {
        
        self.sources = sources
        self.collectionView?.reloadData()
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
        self.setUpCollectionView()
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
        self.descriptionLabel.numberOfLines = 0
        
        self.descriptionLabel.font = UIFont.proDisplayRegular(16.0)
        self.descriptionLabel.textColor = UIColor(hexString: "#09141F")
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.text = "Description Description Description Description Description Description Description Description"
        self.descriptionLabel.sizeToFit()
    }
    
    private func setUpCollectionView() {
        
        let layout = UICollectionViewLeftAlignedLayout()
        layout.sectionFootersPinToVisibleBounds = true
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        guard let collectionView = self.collectionView else {
            return
        }
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView?.autoPinEdge(toSuperviewEdge: .leading, withInset: 19.0)
        self.collectionView?.autoPinEdge(toSuperviewEdge: .trailing, withInset: 19.0)
        self.collectionView?.autoPinEdge(toSuperviewEdge: .bottom)
        self.collectionView?.autoPinEdge(.top, to: .bottom, of: self.descriptionLabel, withOffset: 32.0)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(UINib.init(nibName: "RoundedTextCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: RoundedTextCollectionViewCell.reuseIdentifier)
        self.collectionView?.allowsSelection = true
        self.collectionView?.allowsMultipleSelection = false
    }
}

extension PersonalizationTitlePickerSectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        let cell: RoundedTextCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundedTextCollectionViewCell.reuseIdentifier, for: indexPath) as! RoundedTextCollectionViewCell
        let title: String? = self.sources?[indexPath.row]
        cell.title = title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.sources?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let title: String = self.sources?[indexPath.row] else {
            return CGSize.zero
        }
        
        let width = title.sizeOfString(usingFont: UIFont.proDisplaySemibold(CGFloat(16.0))).width
        var size = CGSize.init(width: (ceil(width) + CGFloat(24.0)), height: CGFloat(40))
        let maxWidth = UIScreen.main.bounds.size.width - 26.0
        if size.width > maxWidth {
            size.width = maxWidth
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(13.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(13.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let sources = sources else {return}
        guard let indexPaths = self.collectionView?.indexPathsForSelectedItems else {return}
        let selected = indexPaths.map { indexPath in
            sources[indexPath.row]
        }
        self.delegate?.personalizationTitlePickerDidPickSources(sender: self, sources: selected)
    }
}
