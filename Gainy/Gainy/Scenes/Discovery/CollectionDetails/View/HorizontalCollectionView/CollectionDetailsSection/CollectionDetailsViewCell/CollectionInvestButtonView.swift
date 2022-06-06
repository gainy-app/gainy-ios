import UIKit
import Kingfisher

final class CollectionInvestButtonView: UIView {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        addSubview(investButton)
        investButton.autoPinEdge(toSuperviewEdge: .left, withInset: 28.0)
        investButton.autoPinEdge(toSuperviewEdge: .right, withInset: 28.0)
        investButton.autoSetDimension(.height, toSize: 64.0)
        investButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        self.alphaOverlay = UIView.newAutoLayout()
        self.alphaOverlay?.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.56)
        self.alphaOverlay?.isUserInteractionEnabled = false
        self.alphaOverlay?.alpha = 0.0
       
        self.backgroundImageView = UIImageView.newAutoLayout()
        self.backgroundImageView?.isUserInteractionEnabled = false
        self.backgroundImageView?.backgroundColor = UIColor.blue
        investButton.titleLabel?.superview?.addSubview(self.backgroundImageView!)
        self.backgroundImageView?.autoPinEdgesToSuperviewEdges()
        
        investButton.titleLabel?.superview?.addSubview(self.alphaOverlay!)
        investButton.titleLabel?.superview?.bringSubviewToFront(investButton.titleLabel!)
        self.alphaOverlay?.autoPinEdgesToSuperviewEdges()
        
        layer.cornerRadius = 0.0
        layer.cornerCurve = .continuous
        layer.masksToBounds = true

        layer.isOpaque = true
        backgroundColor = UIColor.clear
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    var investButtonPressed: (() -> Void)?


    private var imageUrl: String = ""
    private var imageName: String = ""
    private var imageLoaded: Bool = false
    private var imageIsLoading: Bool = false
    
    private var collectionId: Int = 0

    private var alphaOverlay: UIView? = nil
    private var backgroundImageView: UIImageView? = nil
    
    lazy var investButton: ResponsiveButton = {
        let button = ResponsiveButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.cornerCurve = .continuous
        button.contentMode = .scaleAspectFill
        button.isOpaque = true
        button.backgroundColor = UIColor.Gainy.gray
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.isHidden = true
        button.addTarget(self,
                         action: #selector(investButtonTapped(_:)),
                         for: .touchUpInside)
        
        button.setTitle("Invest in TTF", for: .normal)
        button.titleLabel?.font = UIFont.proDisplaySemibold(16.0)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    private func loadImage() {

        guard self.imageLoaded == false else {
            return
        }

        guard self.imageIsLoading == false else {
            return
        }
        
        guard !imageUrl.isEmpty else {
            return
        }
        
        var image = UIImage(named: imageName)
        if image == nil {
            image = UIImage(named: imageUrl)
        }
        backgroundImageView?.image = image
        self.imageLoaded = (image != nil)
        if imageLoaded {
            return
        }
        
        self.imageIsLoading = true
        let width = UIScreen.main.bounds.width - (28 * 2)
        let processor = DownsamplingImageProcessor(size: CGSize.init(width: width, height: 64))
        backgroundImageView?.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]) { receivedSize, totalSize in
//            print("-----\(receivedSize), \(totalSize)")
            self.imageIsLoading = false
        } completionHandler: { result in
//            print("-----\(result)")
            self.imageIsLoading = false
            self.alphaOverlay?.alpha = 1.0
        }
        self.imageLoaded = true
    }

    override func didMoveToWindow() {

        super.didMoveToWindow()

        if window != nil {
            self.imageIsLoading = false
            self.imageLoaded = false
            loadImage()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        loadImage()
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        super.hitTest(point, with: event)
    }

    func configureWith(
        name: String,
        imageName: String,
        imageUrl: String,
        collectionId: Int
    ) {

        guard !name.contains("Loader 1") else {
            return
        }
        
        self.investButton.isHidden = false
        self.imageName = imageName
        self.imageUrl = imageUrl
        self.imageLoaded = false
        self.imageIsLoading = false
        self.collectionId = collectionId
        
        investButton.setTitle("Invest in \(name)", for: .normal)
        loadImage()
        layoutIfNeeded()
    }

    // MARK: Private

    // MARK: Functions

    @objc
    private func investButtonTapped(_: UIButton) {
        investButtonPressed?()
    }
}
