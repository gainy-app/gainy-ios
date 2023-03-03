//
//  GainyPageControl.swift
//  Gainy
//
//  Created by Anton Gubarenko on 02.03.2023.
//

import UIKit
import ScrollingPageControl

final class GainyPageControl: ScrollingPageControl {
    init(frame: CGRect, numberOfPages: Int, dotsAdjust: Bool = false) {
        super.init(frame: frame)
        
        setupView(numberOfPages: numberOfPages, dotsAdjust: dotsAdjust)
    }
    
    private func setupView(numberOfPages: Int, dotsAdjust: Bool = false) {
        dotColor = #colorLiteral(red: 0.6936001778, green: 0.7420094609, blue: 0.7848462462, alpha: 1)
        selectedColor = #colorLiteral(red: 0.008154243231, green: 0.3820301294, blue: 1, alpha: 1)
        
        if dotsAdjust {
            if numberOfPages <= 5 {
                self.maxDots = 5
                self.centerDots = 5
            } else {
                self.maxDots = 7
                self.centerDots = 3
            }
        } else {
            self.maxDots = 5
            self.centerDots = 5
        }
        self.pages = numberOfPages
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView(numberOfPages: numberOfPages, dotsAdjust: false)
    }
    
    var currentPage: Int {
        get {
            selectedPage
        }
        set {
            selectedPage = newValue
        }
    }
    
    var hideForSinglePage: Bool = false {
        didSet {
            if hideForSinglePage && pages == 1 {
                isHidden = true
            }
        }
    }
    
    var numberOfPages: Int {
        set {
            isHidden = hideForSinglePage && pages <= 1
            pages = newValue
        }
        get {
            pages
        }
    }
}
