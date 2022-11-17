//
//  TagLabelView.swift
//  GainyCommon
//
//  Created by Евгений Таран on 16.11.22.
//

import UIKit

public final class TagLabelView: UIView {
    
    @IBInspectable public var tagText: String? {
        didSet {
            configure()
        }
    }
    @IBInspectable public var textColor: UIColor? {
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
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }
}

private extension TagLabelView {
    func setupViews() {
        addSubview(tagLabel)
        tagLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 6)
        tagLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    func configure() {
        tagLabel.text = tagText
        tagLabel.textColor = textColor
        backgroundColor = textColor?.withAlphaComponent(0.15)
    }
}

