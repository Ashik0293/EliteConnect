//
//  extension.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//


import SwiftUI

extension View {
    func scaleEffectOnTap() -> some View {
        self.modifier(ScaleEffectOnTapModifier())
    }
}

struct ScaleEffectOnTapModifier: ViewModifier {
    @State private var isPressed = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.5), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
            )
    }
}
