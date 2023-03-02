// https://github.com/Interactive-Studio/ISPageControl
import UIKit

public class GainyPageControlOld: UIControl {
    fileprivate let defaultOffset: CGFloat = 24
    fileprivate var extraOffset: CGFloat = 0
    fileprivate let limit = 5
    fileprivate var fullScaleIndex = [0, 1, 2]
    fileprivate var dotLayers: [CALayer] = []
    fileprivate var diameter: CGFloat { return radius * 2 }
    fileprivate var centerIndex: Int { return fullScaleIndex[1] }
    
    open var currentPage = 0 {
        didSet {
            guard numberOfPages > currentPage else {
                return
            }
            update()
        }
    }
    
    @IBInspectable open var inactiveTintColor: UIColor =  #colorLiteral(red: 0.6936001778, green: 0.7420094609, blue: 0.7848462462, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var currentPageTintColor: UIColor = #colorLiteral(red: 0.008154243231, green: 0.3820301294, blue: 1, alpha: 1) {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var radius: CGFloat = 3 {
        didSet {
            updateDotLayersLayout()
        }
    }
    
    @IBInspectable open var padding: CGFloat = 8 {
        didSet {
            updateDotLayersLayout()
        }
    }
    
    @IBInspectable open var minScaleValue: CGFloat = 0.4 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var middleScaleValue: CGFloat = 0.7 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var numberOfPages: Int = 0 {
        didSet {
            setupDotLayers()
            isHidden = hideForSinglePage && numberOfPages <= 1
        }
    }
    
    @IBInspectable open var hideForSinglePage: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var inactiveTransparency: CGFloat = 0.4 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            setNeedsLayout()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public init(frame: CGRect, numberOfPages: Int) {
        super.init(frame: frame)
        self.numberOfPages = numberOfPages
        setupDotLayers()
    }
    
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize.zero)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let minValue = min(7, numberOfPages)
        return CGSize(width: CGFloat(minValue) * diameter + CGFloat(minValue - 1) * padding, height: diameter)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        dotLayers.forEach {
            if borderWidth > 0 {
                $0.borderWidth = borderWidth
                $0.borderColor = borderColor.cgColor
            }
        }
        
        update()
    }
}

private extension GainyPageControlOld {
    
    func setupDotLayers() {
        dotLayers.forEach{ $0.removeFromSuperlayer() }
        dotLayers.removeAll()

        (0..<numberOfPages).forEach { _ in
            let dotLayer = CALayer()
            layer.addSublayer(dotLayer)
            dotLayers.append(dotLayer)
        }
        
        updateDotLayersLayout()
        setNeedsLayout()
        invalidateIntrinsicContentSize()
    }
    
    func updateDotLayersLayout() {
        
        var x = self.defaultOffset
        if numberOfPages > limit {
            x += self.extraOffset
        }
        let y = (bounds.size.height - diameter) * 0.5
        var frame = CGRect(x: x, y: y, width: diameter, height: diameter)
        
        dotLayers.forEach {
            $0.cornerRadius = radius
            $0.frame = frame
            frame.origin.x += diameter + padding
        }
    }
    
    func setupDotLayersPosition() {
        let centerLayer = dotLayers[centerIndex]
        
        var centerX = frame.width / 2.0
        if numberOfPages > limit {
            centerX += self.extraOffset
        }
        
        centerLayer.position = CGPoint(x: centerX, y: frame.height / 2)
        
        dotLayers.enumerated().filter{ $0.offset != centerIndex }.forEach {
            let index = abs($0.offset - centerIndex)
            let interval = $0.offset > centerIndex ? diameter + padding : -(diameter + padding)
            $0.element.position = CGPoint(x: centerLayer.position.x + interval * CGFloat(index), y: $0.element.position.y)
        }
    }
    
    func setupDotLayersScale() {
        var didSetupOffset = false
        self.extraOffset = 0.0
        dotLayers.enumerated().forEach {
            guard let first = fullScaleIndex.first, let last = fullScaleIndex.last else {
                return
            }
            
            var transform = CGAffineTransform.identity
            if !fullScaleIndex.contains($0.offset) {
                var scaleValue: CGFloat = 0
                if abs($0.offset - first) == 1 || abs($0.offset - last) == 1 {
                    scaleValue = min(middleScaleValue, 1)
                } else if abs($0.offset - first) == 2 || abs($0.offset - last) == 2 {
                    scaleValue = min(minScaleValue, 1)
                } else {
                    scaleValue = 0
                }
                transform = transform.scaledBy(x: scaleValue, y: scaleValue)
                
                if !didSetupOffset {
                    if abs($0.offset - first) == 2 {
                        self.extraOffset = (diameter + padding) * 2
                        didSetupOffset = true
                    } else if abs($0.offset - first) == 1 {
                        self.extraOffset = (diameter + padding)
                        didSetupOffset = true
                    }
                }
            }
            
            $0.element.setAffineTransform(transform)
        }
    }
    
    func update() {
        dotLayers.enumerated().forEach() {
            $0.element.backgroundColor = $0.offset == currentPage ? currentPageTintColor.cgColor : inactiveTintColor.withAlphaComponent(inactiveTransparency).cgColor
        }
        
        guard numberOfPages > limit else {
            return
        }
        
        changeFullScaleIndexsIfNeeded()
        setupDotLayersScale()
        setupDotLayersPosition()
    }
    
    func changeFullScaleIndexsIfNeeded() {
        guard !fullScaleIndex.contains(currentPage) else {
            return
        }
        
        let moreThanBefore = (fullScaleIndex.last ?? 0) < currentPage
        if moreThanBefore {
            fullScaleIndex[0] = currentPage - 2
            fullScaleIndex[1] = currentPage - 1
            fullScaleIndex[2] = currentPage
        } else {
            fullScaleIndex[0] = currentPage
            fullScaleIndex[1] = currentPage + 1
            fullScaleIndex[2] = currentPage + 2
        }
    }
}
