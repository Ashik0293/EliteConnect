//
//  EliteConnectDemoUIApp.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//

import SwiftUI

@main
struct EliteConnectDemoUIApp: App {
    @State private var showSplash = true
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                MainView()
            }
        }
    }
}
