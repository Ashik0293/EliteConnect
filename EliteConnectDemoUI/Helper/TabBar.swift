//
//  TabBar.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//


import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profiles", systemImage: "person")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradients(
                    colors: [.purple, .blue],
                    opacity: 0.6,
                    edgesToIgnore: [.top]
                )
                Text("Home Screen")
                    .foregroundColor(.white)
            }
            .navigationTitle("Home Page")
        }
    }
}
struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradients(
                    colors: [.purple, .orange],
                    opacity: 0.6,
                    edgesToIgnore: [.top]
                )
                Text("Settings Page")
                    .foregroundColor(.white)
            }
            .navigationTitle("Settings")
        }
    }
}
