import UIKit

final class HighlightHeaderView: UICollectionReusableView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.Gainy.white

        addSubview(titleLabel)

        let sectionHorizontalInset: CGFloat = 16

        // TODO: 1: replace with pure layout
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

        label.font = UIFont(name: "SFProDisplay-Regular", size: 20)
        label.textColor = UIColor.Gainy.textDark
        label.backgroundColor = UIColor.Gainy.white
        label.isOpaque = true

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    // MARK: Functions

    func configureWith(title: String) {
        titleLabel.text = title
    }

    // MARK: Private

    // MARK: Properties
}
