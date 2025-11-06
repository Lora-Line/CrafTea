//
//  ProfilProgressView.swift
//  Craftea
//
//  Created by Andréa  on 03/11/2025.
//

import SwiftUI

struct ProfileProgressView: View {
    var progress: Double // entre 0.0 et 1.0
    var image: Image
    
    var body: some View {
        ZStack {
            // Cercle de fond
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.2)
                .foregroundColor(Color.gray)
            
            // Cercle de progression
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color("primaryPurpule"), Color.blue.opacity(0.8)]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 1.0), value: progress)
            
            // Image de profil
            image
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
        }
        .frame(width: 150, height: 150)
    }
}

#Preview (traits: .sizeThatFitsLayout){
    ProfileProgressView(
        progress: 0.75, // 75% rempli
        image: Image("user1")
    )
        .padding()
}
