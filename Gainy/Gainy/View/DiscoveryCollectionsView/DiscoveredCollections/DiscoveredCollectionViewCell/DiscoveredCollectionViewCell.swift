import UIKit

class DiscoveredCollectionViewCell: UICollectionViewCell {
    // MARK: - Internal

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.layer.cornerRadius = 8
        self.backgroundColor = .orange
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

//        UIFont(name: "SFProDisplay-Bold", size: 20)
        label.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
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

//        UIFont(name: "SFProDisplay-Regular", size: 14)
        label.font = UIFont.systemFont(
            ofSize: 0,
            weight: .regular
        )
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )

        return label
    }()

    lazy var stocksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

//        UIFont(name: "SFCompactRounded-Medium", size: 9)
        label.font = UIFont.systemFont(
            ofSize: 9,
            weight: .medium
        )
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )

        return label
    }()

    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//       UIFont(name: "SFCompactRounded-Semibold", size: 28)
        label.font = UIFont.systemFont(
            ofSize: 28,
            weight: .semibold
        )
        label.textColor = UIColor(hexRgb: 0xFFF500)
        label.numberOfLines = 1
        label.textAlignment = .right
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

    func configureWith(name: String, description: String, stocksAmount: Int) {
        self.name = name
        self.desc = description
        self.stocksAmount = stocksAmount

        nameLabel.text = name
        descriptionLabel.text = description
        stocksLabel.text = "STOCKS"
        stocksAmountLabel.text = "\(stocksAmount)"

        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(stocksLabel)
        self.addSubview(stocksAmountLabel)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            ),

            nameLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: self.stocksAmountLabel.leadingAnchor,
                constant: -8
            ),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 24),
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            ),

            descriptionLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: self.trailingAnchor,
                constant: -72
            ),
            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: 19),
        ])

        NSLayoutConstraint.activate([
            stocksLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 16
            ),

            stocksLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            ),
            stocksLabel.widthAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            stocksAmountLabel.topAnchor.constraint(
                equalTo: self.stocksLabel.topAnchor,
                constant: 8
            ),

            stocksAmountLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            ),
        ])
    }

    // MARK: - Private

    // MARK: Properties

    private var name: String = ""
    private var desc: String = ""
    private var stocksAmount: Int = 10
}
