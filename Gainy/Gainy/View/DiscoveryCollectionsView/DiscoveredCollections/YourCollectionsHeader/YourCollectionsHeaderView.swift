import UIKit

class YourCollectionsHeaderView: UICollectionReusableView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.Gainy.white

        addSubview(titleLabel)
        addSubview(descriptionLabel)

        let sectionHorizontalInset: CGFloat = 16

        NSLayoutConstraint.activate([
            titleLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 28 - sectionHorizontalInset),
            titleLabel
                .trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -28 + sectionHorizontalInset),
            titleLabel
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 24),
            titleLabel
                .bottomAnchor
                .constraint(equalTo: descriptionLabel.topAnchor, constant: -4),

            descriptionLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 28 - sectionHorizontalInset),
            descriptionLabel
                .trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -28 + sectionHorizontalInset),
            descriptionLabel
                .bottomAnchor
                .constraint(lessThanOrEqualTo: bottomAnchor, constant: 0),
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

        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
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
