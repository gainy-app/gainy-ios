import UIKit

struct PieChartSegment {
    var color: UIColor
    var value: CGFloat
}

class PieChartView: UIView {

    var segments = [PieChartSegment]() {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        let radius = min(frame.size.width, frame.size.height) * 0.5
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        let valueCount = segments.reduce(0, {$0 + $1.value})
        var startAngle = -CGFloat.pi * 0.5

        for segment in segments {
            context?.setFillColor(segment.color.cgColor)
            let endAngle = startAngle + 2 * .pi * (segment.value / valueCount)
            context?.move(to: viewCenter)
            context?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context?.fillPath()
            startAngle = endAngle
        }
    }
}
