import UIKit

extension YourCollectionViewCell: UIGestureRecognizerDelegate {}

class YourCollectionViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if deleteButton.frame.contains(point) {
            return deleteButton
        }

        return super.hitTest(point, with: event)
    }

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        self.backgroundColor = UIColor.Gainy.white

        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(stocksLabel)
        self.addSubview(stocksAmountLabel)
        self.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            nameLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 16),
            nameLabel
                .trailingAnchor
                .constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -128), //96?
            nameLabel
                .heightAnchor
                .constraint(equalToConstant: 20),
            nameLabel
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 16),
            nameLabel
                .bottomAnchor
                .constraint(equalTo: descriptionLabel.topAnchor, constant: -4),

            descriptionLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel
                .trailingAnchor
                .constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -128),
            descriptionLabel
                .heightAnchor
                .constraint(lessThanOrEqualToConstant: 29),
            descriptionLabel
                .bottomAnchor
                .constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -19),

            stocksLabel
                .topAnchor
                .constraint(equalTo: self.topAnchor, constant: 16),
            stocksLabel
                .trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: -16),
            stocksLabel
                .widthAnchor
                .constraint(equalToConstant: 50),
            stocksLabel
                .bottomAnchor
                .constraint(equalTo: self.stocksAmountLabel.topAnchor, constant: 0),

            stocksAmountLabel
                .trailingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: -16),
            stocksAmountLabel
                .widthAnchor
                .constraint(equalToConstant: 50),

            deleteButton
                .heightAnchor
                .constraint(equalToConstant: 48),
            deleteButton
                .widthAnchor
                .constraint(equalToConstant: 48),
            deleteButton
                .leadingAnchor
                .constraint(equalTo: self.trailingAnchor, constant: 16),
            deleteButton
                .centerYAnchor
                .constraint(equalTo: self.centerYAnchor, constant: 0),
        ])

        setupSwipeGesture()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    static var reuseIdentifier: String {
        String(describing: self)
    }

    // MARK: Properties

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // TODO: UIFont(name: "SFProDisplay-Bold", size: 20)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.Gainy.white

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // TODO: UIFont(name: "SFProDisplay-Regular", size: 14)
        label.font = UIFont.systemFont(ofSize: 0, weight: .regular)
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
        label.textAlignment = .right

        return label
    }()

    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        // TODO: UIFont(name: "SFCompactRounded-Semibold", size: 28)
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = UIColor.Gainy.yellow

        label.numberOfLines = 1
        label.textAlignment = .right

        return label
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.Gainy.back

        button.setImage(UIImage(named: "trash"), for: .normal)

        button.addTarget(self,
                         action: #selector(self.deleteButtonTapped(_:)),
                         for: .touchUpInside)

        return button
    }()

    var onDeleteButtonPressed: (() -> Void) = {}

    @objc
    private func deleteButtonTapped(_: UIButton) {
        onDeleteButtonPressed()
    }

    override func draw(_: CGRect) {
        let borderPath = UIBezierPath(roundedRect: self.bounds,
                                      cornerRadius: cornerRadius)
        UIColor.orange.set() // TODO: update with a picture
        borderPath.fill()
    }

    func setupSwipeGesture() {
        leftSwipeGesture = UISwipeGestureRecognizer(target: self,
                                                    action: #selector(swipedLeft(_:)))
        leftSwipeGesture.delegate = self
        leftSwipeGesture.direction = .left
        leftSwipeGesture.numberOfTouchesRequired = 1

        rightSwipeGesture = UISwipeGestureRecognizer(target: self,
                                                     action: #selector(swipedRight(_:)))
        rightSwipeGesture.delegate = self
        rightSwipeGesture.direction = .right
        rightSwipeGesture.numberOfTouchesRequired = 1

        self.addGestureRecognizer(leftSwipeGesture)
        self.addGestureRecognizer(rightSwipeGesture)
    }

    @objc
    func swipedLeft(_ gestureRecognizer: UISwipeGestureRecognizer) {
        self.originalPoint = CGPoint(x: (self.superview?.center.x)!, y: self.center.y)

        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(translationX: -40, y: 0)
            self.center = CGPoint(x: self.originalPoint.x + -40, y: self.originalPoint.y)
        }
    }

    @objc
    func swipedRight(_ gestureRecognizer: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            self.center = self.originalPoint
            self.transform = CGAffineTransform(rotationAngle: 0)
        }
    }

    // MARK: Functions

    func configureWith(name: String, description: String, stocksAmount: Int, imageName: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "\(imageName)-discovered")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        self.backgroundView = imageView

        nameLabel.text = name
        descriptionLabel.text = description
        stocksLabel.text = "STOCKS"
        stocksAmountLabel.text = "\(stocksAmount)"
    }

    // MARK: Private

    // MARK: Properties

    private let cornerRadius: CGFloat = 8

    private var leftSwipeGesture: UISwipeGestureRecognizer!
    private var rightSwipeGesture: UISwipeGestureRecognizer!
    private var originalPoint: CGPoint!
}
