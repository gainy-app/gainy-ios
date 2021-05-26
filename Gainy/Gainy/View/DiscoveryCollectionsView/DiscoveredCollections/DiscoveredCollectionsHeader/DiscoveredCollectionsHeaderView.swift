import UIKit

class DiscoveredCollectionsHeaderView: UICollectionReusableView {
    // MARK: - Internal

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor(hexRgb: 0xE5E5E5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // label.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        label.font = UIFont.systemFont(
            ofSize: 20,
            weight: .semibold
        )
        label.textColor = UIColor(hexRgb: 0x1F2E35)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.font = UIFont.systemFont(
            ofSize: 14,
            weight: .regular
        )
        label.textColor = UIColor(hexRgb: 0x687379)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )

        return label
    }()

    static var reuseIdentifier: String {
        String(describing: self)
    }

    // MARK: Functions

    func configureWith(title: String, description: String) {
        self.title = title
        titleLabel.text = title
        descriptionLabel.text = description
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 28
            ),

            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: self.trailingAnchor,
                constant: -28
            ),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 28
            ),

            descriptionLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: self.trailingAnchor,
                constant: -28
            ),

            descriptionLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: self.bottomAnchor,
                constant: 28
            ),
        ])
    }

    // MARK: - Private

    // MARK: Properties

    private var title: String = ""
}
