//
//  ContentView.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//

import SwiftUI


// MARK: - CardPageView
struct ProfilePageView: View {
    let profile: Profile
    @State private var collectProspectsInfo: Bool = true
    
    init(profile: Profile) {
        self.profile = profile
        _collectProspectsInfo = State(initialValue: true)
    }
    
    var body: some View {
            VStack {
                Image("eliteLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 80)
                
                VStack(spacing: 0) {
                    ProfileHeaderView()
                    ProfileDetailsView(profile: profile)
                    ActionButtonsView()
                }
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.vertical,6)
                .padding(.horizontal)
                CollectProspectsToggleView(collectProspectsInfo: $collectProspectsInfo)
                FeatureButtonsSection()
            }
            .padding()
            //.background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 1)
            //  .padding(.horizontal)
            .padding(.vertical, 10)
            
    }
}


struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    private let cardVisibleFraction: CGFloat = 0.85
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack{
            LinearGradients(
                colors: [.accentColor, .yellow],
                opacity: 0.3,
                edgesToIgnore: [.top, .leading, .trailing]
            )
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Profiles...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.profiles.isEmpty {
                    Text("No profiles available.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    let cardWidth = screenWidth * cardVisibleFraction
                    let sidePadding = (screenWidth - cardWidth) / 2
                    
                    TabView {
                        ForEach(viewModel.profiles) { profile in
                            
                            ProfilePageView(profile: profile)
                                .frame(width: cardWidth)
                                .padding(.horizontal, sidePadding)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .edgesIgnoringSafeArea(.top)
                    
                    
                }
            }
            .onAppear {
                viewModel.loadProfiles()
            }
            if viewModel.showToast {
                VStack {
                    Spacer()
                    ToastView(message: viewModel.toastMessage ?? "No Value")
                        .padding(.bottom)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.3), value: viewModel.showToast)
            }
        }
    }
}



// MARK: - Sub-Views
struct ProfileHeaderView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("image")
                .resizable()
                .scaledToFill()
                .frame(height: 100)
            //.clipped()
            
            Button(action: {
                
            }) {
                Image(systemName: "pencil")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.ultraThinMaterial)
                            .shadow(radius: 5)
                    )
            }
           // .buttonStyle(PlainButtonStyle())
            .scaleEffectOnTap()
            .padding(.top, 10)
            .padding(.trailing, 10)
            
            
        }
    }
}

struct ProfileDetailsView: View {
    let profile: Profile
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(Color(.systemGray4))
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .offset(y: -50)
                .padding(.bottom, -50)
            
            Text("\(profile.profileFirstName) \(profile.profileLastName)")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Text("\(profile.profileJobTitle) at \(profile.profileCompanyName)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

struct ActionButtonsView: View {
    var body: some View {
        HStack(spacing: 15) {
            Button(action: {}) {
                Text("Write to NFC Card")
                    .font(.custom("AvenirNext-Regular",size: 13).weight(.semibold))
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(Capsule().fill(Color(.systemGray6)))
            }
            
            Button(action: {}) {
                Text("Preview")
                    .font(.custom("AvenirNext-Regular",size: 13).weight(.semibold))
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(Capsule().fill(Color(.systemGray6)))
            }
        }
        .padding(.bottom, 20)
        .padding(.horizontal,12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

struct CollectProspectsToggleView: View {
    @Binding var collectProspectsInfo: Bool
    
    var body: some View {
        Toggle(isOn: $collectProspectsInfo) {
            Text("Collect Prospects Info")
                .font(.headline)
                .foregroundColor(.black)
        }
        .tint(.blue)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct FeatureButtonsSection: View {
    var body: some View {
        VStack(spacing: 20) {
            FeatureButtonsRow(
                leftImageName: "qrcode.viewfinder",
                leftText: "Scan Business Card",
                rightImageName: "person.3.fill",
                rightText: "My Prospects"
            )
            
            FeatureButtonsRow(
                leftImageName: "square.and.pencil",
                leftText: "Write to NFC Card",
                rightImageName: "gear",
                rightText: "Settings"
            )
        }
        .padding(.vertical,6)
        .padding(.horizontal)
    }
}

struct FeatureButtonsRow: View {
    let leftImageName: String
    let leftText: String
    let rightImageName: String
    let rightText: String
    
    var body: some View {
        HStack(spacing: 15) {
            FeatureButton(imageName: leftImageName, text: leftText)
            FeatureButton(imageName: rightImageName, text: rightText)
        }
    }
}

struct FeatureButton: View {
    let imageName: String
    let text: String
    
    var body: some View {
        Button(action: {
            
        }) {
            VStack(spacing: 8) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                
                Text(text)
                    .font(.caption)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .padding(.vertical,6)
            .padding(.horizontal,6)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}


#Preview {
    ProfileView()
}
