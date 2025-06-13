//
//  LinearGradient.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//

import SwiftUI

struct LinearGradients: View {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    let opacity: Double
    let edgesToIgnore: Edge.Set

    init(colors: [Color] = [.purple, .blue],
         startPoint: UnitPoint = .topLeading,
         endPoint: UnitPoint = .bottomTrailing,
         opacity: Double = 0.6,
         edgesToIgnore: Edge.Set = .top) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.opacity = opacity
        self.edgesToIgnore = edgesToIgnore
    }

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: startPoint,
            endPoint: endPoint
        )
        .opacity(opacity)
        .edgesIgnoringSafeArea(edgesToIgnore)
    }
}
