import UIKit

extension UILabel {
    public func setLineHeight(lineHeight: CGFloat, textAlignment: NSTextAlignment ) {
        guard let text = self.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let styleLineHeight = lineHeight
        let style = NSMutableParagraphStyle()
            style.alignment = textAlignment
            style.maximumLineHeight = styleLineHeight
        style.minimumLineHeight = styleLineHeight
        let range = NSMakeRange(0, text.count)
        attributeString.addAttribute(.kern, value: NSNumber(-1), range: range)
        attributeString.addAttribute(.paragraphStyle, value: style, range: range)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        attributeString.addAttribute(.font, value: self.font, range: range)
        
        self.attributedText = attributeString
    }
}
