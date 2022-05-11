import UIKit

final class RecommendedCollectionsHeaderView: UICollectionReusableView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.Gainy.white

        addSubview(titleLabel)

        // TODO: extract layout constants to avoid magic numbers across the app
        let sectionHorizontalInset: CGFloat = 16

        // TODO: 1: replace with pure layout
        NSLayoutConstraint.activate([
            titleLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 24 - sectionHorizontalInset),
            titleLabel
                .trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -24 + sectionHorizontalInset),
            titleLabel
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 40),
            titleLabel
                .bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: -16),

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
        label.backgroundColor = UIColor.Gainy.white
        label.isOpaque = true

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.Gainy.darkGray
        label.backgroundColor = UIColor.Gainy.white
        label.isOpaque = true

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    // MARK: Functions

    func configureWith(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }

    // MARK: Private

    // MARK: Properties
}
