//
//  VHLines.swift
//  Gainy
//
//  Created by Anton Gubarenko on 24.08.2021.
//

import SwiftUI

struct HLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct VLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                return path
    }
}
