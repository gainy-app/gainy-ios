import UIKit
import GainyCommon

protocol RecommendedCollectionsHeaderViewDelegate: AnyObject {
    func sortByTapped()
    func didChangePerformancePeriod(period: RecommendedCollectionsSortingSettings.PerformancePeriodField)
}

final class RecommendedCollectionsHeaderView: UIView {
    // MARK: Lifecycle

    public weak var delegate: RecommendedCollectionsHeaderViewDelegate?
    private var sortLbl: UILabel?
    private var sortByButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var periodButtons: [GainyButton] = []
    
    var settingsManager: SortingSettingsManagable = RecommendedCollectionsSortingSettingsManager.shared {
        didSet {
            populatePeriods()
        }
    }
    
    var viewMode: DiscoveryViewController.ViewMode = .grid {
        didSet {
            UIView.animate(withDuration: 0.3, animations: {
                self.rangeLabel.alpha = self.viewMode == .grid ? 0.0 : 1.0
                self.titleLabel.alpha = self.viewMode == .grid ? 1.0 : 0.0
                self.sortByButton.alpha = self.viewMode == .grid ? 1.0 : 0.0
                self.stackTop?.constant = self.viewMode == .grid ? 24.0 : 0.0
                self.layoutIfNeeded()
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private var stackTop: NSLayoutConstraint?
    private func setupView() {
        fillRemoteBack()

        addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        titleLabel.autoPinEdge(toSuperviewEdge: .right)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 16.0)
        
        addSubview(rangeLabel)
        rangeLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        rangeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 14.0)
        
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
        stackTop = self.stackView.autoPinEdge(.top, to: .bottom, of: textLabel, withOffset: 24.0)
        self.stackView.autoSetDimension(.height, toSize: 24.0)
        self.stackView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.stackView.isHidden = true
        populatePeriods()
    }
    
    private func populatePeriods() {
        if !stackView.arrangedSubviews.isEmpty {
            for view in stackView.arrangedSubviews {
                stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
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
            let settings = settingsManager.getSettingByID(profileID)
            if settings.performancePeriod == item {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            self.stackView.addArrangedSubview(button)
            button.autoSetDimension(.height, toSize: 24.0)
            button.autoSetDimension(.width, toSize: 58.0)
            button.buttonActionHandler = { sender in
                for button in self.periodButtons {
                    if sender == button {
                        if let value = RecommendedCollectionsSortingSettings.PerformancePeriodField.init(rawValue: button.tag) {
                            let settingsInternal = self.settingsManager.getSettingByID(profileID)
                            self.settingsManager.changeSortingForId(profileID, sorting: settingsInternal.sorting, performancePeriod: value)
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
    

    @objc
    private func sortTapped() {
        
        self.delegate?.sortByTapped()
    }
    
    // MARK: Properties

    public let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 7.0
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
    
    lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = .compactRoundedSemibold(12.0)
        label.textColor = UIColor.Gainy.textDark
        label.backgroundColor = .clear
        label.isOpaque = true
        label.text = "RETURNS PERIOD"
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.alpha = 0.0
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

    func configureWith(title: String, description: String, sortLabelString: String? = nil, periodsHidden: Bool = false) {
        titleLabel.text = title
        descriptionLabel.text = description
        if let sortString = sortLabelString {
            self.sortByButton.isHidden = false
            self.stackView.isHidden = periodsHidden
            self.sortLbl?.text = sortString
        }
    }
    
    func configureCategoryWith(title: String, description: String, sortLabelString: String? = nil, periodsHidden: Bool = false) {
        titleLabel.text = title
        descriptionLabel.text = description
        self.stackView.isHidden = periodsHidden
        if let sortString = sortLabelString {
            self.sortByButton.isHidden = false
            self.sortLbl?.text = sortString
        }
    }

}
