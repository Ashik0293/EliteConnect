//
//  SplashGIF.swift
//  EliteConnectDemoUI
//
//  Created by Mohamed Ashik Buhari on 12/06/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradients(
                colors: [Color(#colorLiteral(red: 0.1447633207, green: 0.5685680509, blue: 0.5480690598, alpha: 0.7957302681)).opacity(0.8), .white],
                opacity: 0.8,
                edgesToIgnore: [.all]
            )
            VStack {
                Image("1024")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                Text("Elite Connect App")
                    .foregroundStyle(Color(#colorLiteral(red: 0.1447633207, green: 0.5685680509, blue: 0.5480690598, alpha: 0.7957302681)))
                    .frame(maxWidth: .infinity)
                    .font(.custom("AvenirNext-Regular",size: 25).weight(.bold))
            }
        }
    }
}
