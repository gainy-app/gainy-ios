import UIKit

class YourCollectionsHeaderView: UICollectionReusableView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.Gainy.white

        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            titleLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 28),
            titleLabel
                .trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: -28),
            titleLabel
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 12),
            titleLabel
                .bottomAnchor
                .constraint(equalTo: descriptionLabel.topAnchor, constant: -4),

            descriptionLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 28),
            descriptionLabel
                .trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: -28),
            descriptionLabel
                .bottomAnchor
                .constraint(lessThanOrEqualTo: self.bottomAnchor, constant: 28),
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

        // TODO: UIFont(name: "SFProDisplay-Semibold", size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.Gainy.textDark
        label.backgroundColor = UIColor.Gainy.white

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // TODO: UIFont(name: "SFProDisplay-Regular", size: 14)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.Gainy.darkGray
        label.backgroundColor = UIColor.Gainy.white

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
