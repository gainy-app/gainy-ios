import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
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

    static var reuseIdentifier: String {
        String(describing: self)
    }

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

//        UIFont(name: "SFProDisplay-Bold", size: 16)
        label.font = UIFont.systemFont(
            ofSize: 16,
            weight: .bold
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

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

//        UIFont(name: "SFProDisplay-Regular", size: 12)
        label.font = UIFont.systemFont(
            ofSize: 12,
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
        label.textAlignment = .left
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
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )

        return label
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

////        UIFont(name: "SFProDisplay-Bold", size: 16)
//        label.font = UIFont.systemFont(
//            ofSize: 16,
//            weight: .bold
//        )
//        label.textColor = .white
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.textAlignment = .left
//        label.setContentCompressionResistancePriority(
//            .defaultHigh,
//            for: .horizontal
//        )
//
        return button
    }()

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
//        self.addSubview(plusButton)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 8
            ),

            nameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -8
            ),

            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 8),
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 8
            ),

            descriptionLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -8
            ),

            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: stocksLabel.topAnchor, constant: 7),
        ])

        NSLayoutConstraint.activate([
            stocksLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 8
            ),

            stocksLabel.widthAnchor.constraint(equalToConstant: 50),

            stocksLabel.bottomAnchor.constraint(equalTo: stocksAmountLabel.topAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            stocksAmountLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 8
            ),

            stocksAmountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ])
    }

    // MARK: - Private

    // MARK: Properties

    private var name: String = ""
    private var desc: String = ""
    private var stocksAmount: Int = 0
}
