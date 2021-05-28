import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        self.backgroundColor = UIColor.Gainy.white

        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(stocksLabel)
        self.addSubview(stocksAmountLabel)
        self.addSubview(plusButton)

        NSLayoutConstraint.activate([
            nameLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 8),
            nameLabel
                .trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: -8),
            nameLabel
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 12),
            nameLabel
                .bottomAnchor
                .constraint(equalTo: descriptionLabel.topAnchor, constant: -4),

            descriptionLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 8),
            descriptionLabel
                .trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: -8),
            descriptionLabel
                .heightAnchor
                .constraint(lessThanOrEqualToConstant: 40),
            descriptionLabel
                .bottomAnchor
                .constraint(greaterThanOrEqualTo: stocksLabel.topAnchor, constant: -7),

            stocksLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 8),
            stocksLabel
                .heightAnchor
                .constraint(equalToConstant: 10),
            stocksLabel
                .widthAnchor
                .constraint(equalToConstant: 50),
            stocksLabel
                .bottomAnchor
                .constraint(equalTo: stocksAmountLabel.topAnchor, constant: 0),

            stocksAmountLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 8),
            stocksAmountLabel
                .bottomAnchor
                .constraint(equalTo: self.bottomAnchor, constant: -12),
            stocksAmountLabel
                .heightAnchor
                .constraint(equalToConstant: 24),
            stocksAmountLabel
                .widthAnchor
                .constraint(equalToConstant: 50),

            plusButton
                .trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: -8),
            plusButton
                .bottomAnchor
                .constraint(equalTo: self.bottomAnchor, constant: -8),
            plusButton
                .widthAnchor
                .constraint(equalToConstant: 28),
            plusButton
                .heightAnchor
                .constraint(equalToConstant: 28),
        ])
    }

    override func draw(_ rect: CGRect) {
        let borderPath = UIBezierPath(roundedRect: self.bounds,
                                      cornerRadius: cornerRadius)
        UIColor.orange.set() // TODO: update with a picture
        borderPath.fill()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    static var reuseIdentifier: String {
        String(describing: self)
    }

    var plusButtonPressed: (() -> Void) = {}

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // TODO: UIFont(name: "SFProDisplay-Bold", size: 16)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.Gainy.white

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // TODO: UIFont(name: "SFProDisplay-Regular", size: 12)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.Gainy.white

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    lazy var stocksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // TODO: UIFont(name: "SFCompactRounded-Medium", size: 9)
        label.font = UIFont.systemFont(ofSize: 9, weight: .medium)
        label.textColor = UIColor.Gainy.white

        label.numberOfLines = 1
        label.textAlignment = .left

        return label
    }()

    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // TODO: UIFont(name: "SFCompactRounded-Semibold", size: 28)
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = UIColor.Gainy.yellow

        label.numberOfLines = 1
        label.textAlignment = .left

        return label
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(self.plusButtonTapped(_:)),
                         for: .touchUpInside)

        var shadows = UIView()
        shadows.frame = button.frame
        shadows.clipsToBounds = false
        button.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 6
        layer0.shadowOffset = CGSize(width: 0, height: 2)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        return button
    }()

    // MARK: Functions

    func configureWith(name: String, description: String, stocksAmount: Int, imageName: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "\(imageName)-recommended")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        self.backgroundView = imageView

        nameLabel.text = name
        descriptionLabel.text = description
        stocksLabel.text = "STOCKS"
        stocksAmountLabel.text = "\(stocksAmount)"
    }

    func setButtonUnchecked() {
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
    }

    func setButtonChecked() {
        plusButton.setImage(UIImage(named: "check"), for: .normal)
    }

    // MARK: Private

    // MARK: Properties

    private let cornerRadius: CGFloat = 8

    // MARK: Functions

    @objc
    private func plusButtonTapped(_: UIButton) {
        plusButtonPressed()
    }
}
