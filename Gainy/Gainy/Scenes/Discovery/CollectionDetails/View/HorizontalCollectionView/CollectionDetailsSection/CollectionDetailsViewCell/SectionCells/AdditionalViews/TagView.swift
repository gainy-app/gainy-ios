//
//  TagView.swift
//  Gainy
//
//  Created by Евгений Таран on 14.11.22.
//

import UIKit

final class TagLabelView: UIView {
    
    @IBInspectable var tagText: String? {
        didSet {
            configure()
        }
    }
    @IBInspectable var textColor: UIColor? {
        didSet {
            configure()
        }
    }
    
    private lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.textColor = textColor
        tagLabel.font = .compactRoundedSemibold(12)
        tagLabel.textAlignment = .center
        return tagLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }
    
    func configure() {
        tagLabel.text = tagText
        tagLabel.textColor = textColor
        backgroundColor = textColor?.withAlphaComponent(0.15)
    }
}

private extension TagLabelView {
    func setupViews() {
        addSubview(tagLabel)
        tagLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 6)
        tagLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}
