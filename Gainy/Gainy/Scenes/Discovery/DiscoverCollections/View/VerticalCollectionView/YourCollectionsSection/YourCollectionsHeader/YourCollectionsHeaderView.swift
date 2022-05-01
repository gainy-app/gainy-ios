import UIKit

final class YourCollectionsHeaderView: UICollectionReusableView {
    // MARK: Lifecycle

    private var topConstraint: NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.Gainy.white

        addSubview(titleLabel)
        //addSubview(descriptionLabel)

        let sectionHorizontalInset: CGFloat = 16

        // TODO: 1: replace with pure layout
        
        topConstraint = titleLabel
            .topAnchor
            .constraint(equalTo: topAnchor, constant: 40)
        
        NSLayoutConstraint.activate([
            titleLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 28 - sectionHorizontalInset),
            titleLabel
                .trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -28 + sectionHorizontalInset),
            topConstraint!
            ,
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
        if title == Constants.CollectionDetails.yourCollections {
            topConstraint?.constant = 4
        } else {
            topConstraint?.constant = 24
        }
    }

    // MARK: Private

    // MARK: Properties
}
