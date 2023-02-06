import UIKit
import SwiftUI
import SwiftHEXColors

extension UIColor {
    public enum Gainy {
        public static let white = UIColor.white

        public static let red = UIColor(red: 252.0 / 255.0,
                                 green: 80.0 / 255.0,
                                 blue: 88.0 / 255.0,
                                 alpha: 1)

        public static let yellow = UIColor(red: 255.0 / 255.0,
                                    green: 245.0 / 255.0,
                                    blue: 0.0 / 255.0,
                                    alpha: 1)

        public static let green = UIColor(red: 37.0 / 255.0,
                                   green: 198.0 / 255.0,
                                   blue: 133.0 / 255.0,
                                   alpha: 1)

//        static let lightBlue

        public static let blue = UIColor(red: 0.0 / 255.0,
                                  green: 98.0 / 255.0,
                                  blue: 255.0 / 255.0,
                                  alpha: 1)

//        static let white

        public static let lightBack = UIColor(red: 247.0 / 255.0,
                                       green: 248.0 / 255.0,
                                       blue: 249.0 / 255.0,
                                       alpha: 1)

        public static let back = UIColor(red: 238.0 / 255.0,
                                  green: 243.0 / 255.0,
                                  blue: 245.0 / 255.0,
                                  alpha: 1)

        public static let lightGray = UIColor(red: 224.0 / 255.0,
                                       green: 230.0 / 255.0,
                                       blue: 234.0 / 255.0,
                                       alpha: 1)

        public static let gray = UIColor(red: 135.0 / 255.0,
                                  green: 144.0 / 255.0,
                                  blue: 149.0 / 255.0,
                                  alpha: 1)

        public static let darkGray = UIColor(red: 104.0 / 255.0,
                                      green: 115.0 / 255.0,
                                      blue: 121.0 / 255.0,
                                      alpha: 1)

        public static let grayNotDark = UIColor(red: 58 / 255.0,
                                         green: 68 / 255.0,
                                         blue: 72 / 255.0,
                                         alpha: 1)

        public static let textDark = UIColor(red: 31.0 / 255.0,
                                      green: 46.0 / 255.0,
                                      blue: 53.0 / 255.0,
                                      alpha: 1)

//        static let black
//        static let purple
        
        public static let secondaryGreen = UIColor(named: "secondaryGreen")
        public static let mainGreen = UIColor(named: "mainGreen")
        public static let mainYellow = UIColor(named: "mainYellow")
        public static let mainRed = UIColor(named: "mainRed")
        public static let mainText = UIColor(named: "mainText")
        public static let secondaryLightGray = UIColor(named: "secondaryLightGray")
        public static let secondaryYellow = UIColor(named: "secondaryYellow")
        public static let thirdGreen = UIColor(named: "thirdGreen")
        public static let tickerSymbol = UIColor(hexString: "6C5DD3", alpha: 1.0)!
        public static let grayLight = UIColor(hexString: "B1BDC8")
        
        public static let pieChartColors = [
            UIColor.init(hexString: "#2D54FF"),
            UIColor.init(hexString: "#7869E7"),
            UIColor.init(hexString: "#25C685"),
            UIColor.init(hexString: "#FF6970"),
            UIColor.init(hexString: "#FFB423"),
            UIColor.init(hexString: "#FF8BA0"),
            UIColor.init(hexString: "#5EABFF"),
            UIColor.init(hexString: "#A79BFD"),
            UIColor.init(hexString: "#6BE8B6"),
            UIColor.init(hexString: "#C6D2DD")
        ]
    }
}

extension UIColor {
    public var uiColor: Color {
        return Color.init(self)
    }
}
