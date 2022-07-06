import UIKit

final class NoCollectionsHeaderView: UICollectionReusableView {
    // MARK: Lifecycle

    private var topConstraint: NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)

        fillRemoteBack()

        addSubview(titleLabel)
        addSubview(descriptionOutline)
        descriptionOutline.addSubview(descriptionLabel)
        descriptionOutline.addSubview(descriptionImageView)
        
        let sectionHorizontalInset: CGFloat = 16
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 24 - sectionHorizontalInset)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 24 - sectionHorizontalInset)
        titleLabel.autoSetDimension(.height, toSize: 24.0)
        topConstraint = titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 24.0)
        
        descriptionOutline.autoSetDimension(.height, toSize: 88.0)
        descriptionOutline.autoPinEdge(toSuperviewEdge: .leading, withInset: 16 - sectionHorizontalInset)
        descriptionOutline.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16 - sectionHorizontalInset)
        descriptionOutline.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 16)
        
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 32)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 67)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 28)
        descriptionLabel.autoSetDimension(.height, toSize: 32.0)
        
        descriptionImageView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 28.5)
        descriptionImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
        descriptionImageView.autoSetDimensions(to: CGSize.init(width: 24, height: 24))
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
        label.backgroundColor = .clear
        label.isOpaque = true

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var descriptionOutline: UIView = {
        let view = RectangularDashedView.newAutoLayout()
        view.backgroundColor = UIColor.clear
        view.cornerRadius = 16.0
        view.dashColor = UIColor(hexString: "#B1BDC8") ?? UIColor.gray
        
        return view
    }()
    
    lazy var descriptionImageView: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.image = UIImage.init(named: "bottom_arrow")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.compactRoundedSemibold(12)
        label.textColor = UIColor(hexString: "#B1BDC8")
        label.backgroundColor = .clear
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
        descriptionLabel.setLineHeight(lineHeight: 16.0, textAlignment: .left, color: UIColor(hexString: "#B1BDC8") ?? UIColor.gray)
        if title == Constants.CollectionDetails.yourCollections {
            topConstraint?.constant = 4
        } else {
            topConstraint?.constant = 24
        }
    }

    // MARK: Private

    // MARK: Properties
}
