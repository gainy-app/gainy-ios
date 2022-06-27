//
//  GainersHeaderView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 02.05.2022.
//

import UIKit

final class GainersHeaderView: UICollectionReusableView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        fillRemoteBack()

        addSubview(titleLabel)

        // TODO: extract layout constants to avoid magic numbers across the app
        let sectionHorizontalInset: CGFloat = 16

        // TODO: 1: replace with pure layout
        NSLayoutConstraint.activate([
            titleLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel
                .trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -24),
            titleLabel
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 40),
            titleLabel
                .bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        label.textColor = UIColor.Gainy.textDark
        label.backgroundColor = .clear
        label.isOpaque = true

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()


    // MARK: Functions

    func configureWith(title: String) {
        titleLabel.text = title
    }

    // MARK: Private

    // MARK: Properties
}

