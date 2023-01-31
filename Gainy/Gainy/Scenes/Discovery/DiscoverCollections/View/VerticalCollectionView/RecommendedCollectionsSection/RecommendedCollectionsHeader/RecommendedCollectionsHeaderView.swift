import UIKit
import GainyCommon

protocol RecommendedCollectionsHeaderViewDelegate: AnyObject {
    func sortByTapped()
    func didChangePerformancePeriod(period: RecommendedCollectionsSortingSettings.PerformancePeriodField)
}


final class RecommendedCollectionsHeaderView: UICollectionReusableView {
    // MARK: Lifecycle

    public weak var delegate: RecommendedCollectionsHeaderViewDelegate?
    private var sortLbl: UILabel?
    private var sortByButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var periodButtons: [GainyButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        fillRemoteBack()

        addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        titleLabel.autoPinEdge(toSuperviewEdge: .right)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 16.0)
        
        sortByButton.layer.cornerRadius = 8
        sortByButton.layer.cornerCurve = .continuous
        sortByButton.backgroundColor = .black
        sortByButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        self.addSubview(sortByButton)
        sortByButton.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        sortByButton.autoSetDimension(.height, toSize: 24.0)
        sortByButton.autoAlignAxis(.horizontal, toSameAxisOf: titleLabel)
        
        let reorderIconImageView = UIImageView.newAutoLayout()
        reorderIconImageView.image = UIImage(named: "reorder_white")
        sortByButton.addSubview(reorderIconImageView)
        reorderIconImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 16))
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)

        
        let sortByLabel = UILabel.newAutoLayout()
        sortByLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        sortByLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        sortByLabel.numberOfLines = 1
        sortByLabel.textAlignment = .center
        sortByLabel.text = "Sort by"
        sortByButton.addSubview(sortByLabel)
        sortByLabel.autoSetDimensions(to: CGSize.init(width: 36, height: 16))
        sortByLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 26.0)
        sortByLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)


        let textLabel = UILabel.newAutoLayout()
        textLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        textLabel.textColor = UIColor.white
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .center
        textLabel.text = "Most Popular"
        textLabel.minimumScaleFactor = 0.1
        sortLbl = textLabel
        sortByButton.addSubview(textLabel)
        
        textLabel.autoSetDimension(.height, toSize: 16)
        textLabel.autoPinEdge(.left, to: .right, of: sortByLabel, withOffset: 2.0)
        textLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        textLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        textLabel.sizeToFit()
        sortByButton.isHidden = true
        
        
        self.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.autoPinEdge(.top, to: .bottom, of: textLabel, withOffset: 24.0)
        self.stackView.autoSetDimension(.height, toSize: 24.0)
        self.stackView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.stackView.isHidden = true
        
        guard let profileID = UserProfileManager.shared.profileID else {
            return
        }
        
        for item in RecommendedCollectionsSortingSettings.PerformancePeriodField.allCases {
            let button = GainyButton()
            button.configureWithTitle(title: item.title, color: UIColor.init(hexString: "#09141F")!, state: .normal)
            button.configureWithTitle(title: item.title, color: UIColor.init(hexString: "#09141F")!, state: .disabled)
            button.configureWithTitle(title: item.title, color: UIColor.init(hexString: "#FFFFFF")!, state: .selected)
            button.configureWithBackgroundColor(color: .clear)
            button.configureWithDisabledBackgroundColor(color: .clear)
            button.configureWithHighligtedBackgroundColor(color: UIColor.init(hexString: "#09141F")!)
            button.configureWithSelectedBackgroundColor(color: UIColor.init(hexString: "#09141F")!)
            button.configureWithCornerRadius(radius: 8.0)
            button.configureWithFont(font: UIFont.compactRoundedMedium(12.0))
            button.tag = item.rawValue
            let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(profileID)
            if settings.performancePeriod == item {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            self.stackView.addArrangedSubview(button)
            button.autoSetDimension(.height, toSize: 24.0)
            button.autoSetDimension(.width, toSize: 48.0)
            button.buttonActionHandler = { sender in
                for button in self.periodButtons {
                    if sender == button {
                        if let value = RecommendedCollectionsSortingSettings.PerformancePeriodField.init(rawValue: button.tag) {
                            let settingsInternal = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(profileID)
                            RecommendedCollectionsSortingSettingsManager.shared.changeSortingForId(profileID, sorting: settingsInternal.sorting, performancePeriod: value)
                            self.delegate?.didChangePerformancePeriod(period: value)
                        }
                        button.isSelected = true
                    } else {
                        button.isSelected = false
                    }
                }
            }
            self.periodButtons.append(button)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    @objc
    private func sortTapped() {
        
        self.delegate?.sortByTapped()
    }
    
    // MARK: Properties

    public let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        return stackView
    }()
    
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

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.Gainy.darkGray
        label.backgroundColor = UIColor.Gainy.white
        label.isOpaque = true

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left

        return label
    }()

    // MARK: Functions

    func configureWith(title: String, description: String, sortLabelString: String? = nil, periodsHidden: Bool = true) {
        titleLabel.text = title
        descriptionLabel.text = description
        if let sortString = sortLabelString {
            self.sortByButton.isHidden = false
            self.stackView.isHidden = periodsHidden
            self.sortLbl?.text = sortString
        }
    }

    // MARK: Private

    // MARK: Properties
}
