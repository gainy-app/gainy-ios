import UIKit

final class HightlightViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        // TODO: 1: make order in the init consistent
        contentView.addSubview(emojiLabel)
        contentView.addSubview(highlightTextLabel)

        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        layer.masksToBounds = true

        layer.isOpaque = true
        backgroundColor = UIColor.Gainy.grayNotDark
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    lazy var emojiLabel: UILabel = {
        let label = UILabel()

        // TODO: use extensions for custom fonts to avoid typos (around the app)
        // smth like: UIFont.Gainy.SFProDisplay
        label.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        label.textColor = UIColor.Gainy.textDark

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var highlightTextLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor.Gainy.white

        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        let hMargin: CGFloat = 24
        let topMargin: CGFloat = 16

        emojiLabel.frame = CGRect(
            x: hMargin,
            y: topMargin,
            width: 20,
            height: 16
        )

        highlightTextLabel.frame = CGRect(
            x: hMargin,
            y: topMargin + 16 + 8,
            width: 192,
            height: 80
        )
    }

    // MARK: Functions

    func configureWith(
        titleEmoji: String,
        highlightText: String
    ) {
        emojiLabel.text = titleEmoji
        emojiLabel.sizeToFit()

        highlightTextLabel.text = highlightText
        highlightTextLabel.sizeToFit()

        layoutIfNeeded()
    }
}
