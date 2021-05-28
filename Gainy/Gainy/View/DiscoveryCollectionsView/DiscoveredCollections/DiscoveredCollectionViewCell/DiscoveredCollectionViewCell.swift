import UIKit

extension DiscoveredCollectionViewCell: UIGestureRecognizerDelegate {}

class DiscoveredCollectionViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        self.backgroundColor = UIColor.Gainy.white

        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(stocksLabel)
        self.addSubview(stocksAmountLabel)

        NSLayoutConstraint.activate([
            nameLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor, constant: 16),
            nameLabel
                .trailingAnchor
                .constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -96),
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
        ])

//        setupSwipeGesture()
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

    override func draw(_: CGRect) {
        let borderPath = UIBezierPath(roundedRect: self.bounds,
                                      cornerRadius: cornerRadius)
        UIColor.orange.set() // TODO: update with a picture
        borderPath.fill()
    }

//    func setupSwipeGesture() {
//        swipeGesture = UIPanGestureRecognizer(target: self,
//                                              action: #selector(swiped(_:)))
//        swipeGesture.delegate = self
//
//        self.addGestureRecognizer(swipeGesture)
//    }

//    @objc
//    func swiped(_ gestureRecognizer: UIPanGestureRecognizer) {
//        let xDistance: CGFloat = gestureRecognizer.translation(in: self).x
//
//        switch gestureRecognizer.state {
//        case UIGestureRecognizerState.began:
//            self.originalPoint = self.center
//        case UIGestureRecognizerState.changed:
//            let translation: CGPoint = gestureRecognizer.translation(in: self)
//            let displacement = CGPoint(x: translation.x, y: translation.y)
//
//            let hasMovedToFarLeft = self.frame.maxX < UIScreen.main.bounds.width * 0.8
//            if hasMovedToFarLeft {
//                return
//            } else {
//               resetViewPositionAndTransformations()
//            }
//
//            if displacement.x + self.originalPoint.x < self.originalPoint.x {
//                self.transform = CGAffineTransform(translationX: displacement.x, y: 0)
//                self.center = CGPoint(x: self.originalPoint.x + xDistance, y: self.originalPoint.y)
//            }
//        case UIGestureRecognizerState.ended:
//            let hasMovedToFarLeft = self.frame.maxX < UIScreen.main.bounds.width * 0.8
//            if hasMovedToFarLeft {
//                removeViewFromParentWithAnimation()
//            } else {
//                resetViewPositionAndTransformations()
//            }
//        default:
//            break
//        }
//    }

//    func resetViewPositionAndTransformations() {
//        UIView.animate(withDuration: 0.8,
//                       delay: 0.0,
//                       usingSpringWithDamping: 0.8,
//                       initialSpringVelocity: 0.0,
//                       options: UIView.AnimationOptions(),
//                       animations: {
//                           self.center = self.originalPoint
//                           self.transform = CGAffineTransform(rotationAngle: 0)
//                       },
//                       completion: { _ in })
//    }

//    func removeViewFromParentWithAnimation() {
//        var animations: (() -> Void)!
//        animations = { self.center.x = UIScreen.main.bounds.width / 2 - 50 }
//
//        UIView.animate(withDuration: 0.2,
//                       animations: animations) { _ in
//        }
//    }

    // TODO: review code above

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

//    private var swipeGesture: UIPanGestureRecognizer!
//    private var originalPoint: CGPoint!
}
