import UIKit
import SwiftUI

extension UIColor {
    enum Gainy {
        static let white = UIColor.white

        static let red = UIColor(red: 252.0 / 255.0,
                                 green: 80.0 / 255.0,
                                 blue: 88.0 / 255.0,
                                 alpha: 1)

        static let yellow = UIColor(red: 255.0 / 255.0,
                                    green: 245.0 / 255.0,
                                    blue: 0.0 / 255.0,
                                    alpha: 1)

        static let green = UIColor(red: 37.0 / 255.0,
                                   green: 198.0 / 255.0,
                                   blue: 133.0 / 255.0,
                                   alpha: 1)

//        static let lightBlue

        static let blue = UIColor(red: 0.0 / 255.0,
                                  green: 98.0 / 255.0,
                                  blue: 255.0 / 255.0,
                                  alpha: 1)

//        static let white

        static let lightBack = UIColor(red: 247.0 / 255.0,
                                       green: 248.0 / 255.0,
                                       blue: 249.0 / 255.0,
                                       alpha: 1)

        static let back = UIColor(red: 238.0 / 255.0,
                                  green: 243.0 / 255.0,
                                  blue: 245.0 / 255.0,
                                  alpha: 1)

        static let lightGray = UIColor(red: 224.0 / 255.0,
                                       green: 230.0 / 255.0,
                                       blue: 234.0 / 255.0,
                                       alpha: 1)

        static let gray = UIColor(red: 135.0 / 255.0,
                                  green: 144.0 / 255.0,
                                  blue: 149.0 / 255.0,
                                  alpha: 1)

        static let darkGray = UIColor(red: 104.0 / 255.0,
                                      green: 115.0 / 255.0,
                                      blue: 121.0 / 255.0,
                                      alpha: 1)

        static let grayNotDark = UIColor(red: 58 / 255.0,
                                         green: 68 / 255.0,
                                         blue: 72 / 255.0,
                                         alpha: 1)

        static let textDark = UIColor(red: 31.0 / 255.0,
                                      green: 46.0 / 255.0,
                                      blue: 53.0 / 255.0,
                                      alpha: 1)

//        static let black
//        static let purple
        
        static let secondaryGreen = UIColor(named: "secondaryGreen")
        static let mainGreen = UIColor(named: "mainGreen")
        static let mainYellow = UIColor(named: "mainYellow")
        static let mainRed = UIColor(named: "mainRed")
        static let mainText = UIColor(named: "mainText")
        static let secondaryLightGray = UIColor(named: "secondaryLightGray")
        static let secondaryYellow = UIColor(named: "secondaryYellow")
        static let thirdGreen = UIColor(named: "thirdGreen")
        static let tickerSymbol = UIColor(hexString: "6C5DD3", alpha: 1.0)!
        
        static let pieChartColors = [
            UIColor.init(hexString: "#1B45FB"),
            UIColor.init(hexString: "#0062FF"),
            UIColor.init(hexString: "#6C5DD3"),
            UIColor.init(hexString: "#38CF92"),
        
            UIColor.init(hexString: "#3BF06E"),
            UIColor.init(hexString: "#F9557B"),
            UIColor.init(hexString: "#F95664"),
            
            UIColor.init(hexString: "#B1BDC8")
        ]
    }
}

extension UIColor {
    var uiColor: Color {
        return Color.init(self)
    }
}
