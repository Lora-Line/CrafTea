//
//  ProfilProgressView.swift
//  Craftea
//
//  Created by Andréa  on 03/11/2025.
//

import SwiftUI

struct ProfileProgressView: View {
    var progress: Double // entre 0.0 et 1.0
    // allow either a SwiftUI Image fallback or a UIImage (from Data) for local profile pictures
    var imageName: String? = nil
    var image: Image? = nil
    var uiImage: UIImage? = nil

    var body: some View {
        ZStack {
            // Cercle de fond
            Circle()
                .stroke(lineWidth: 16)
                .opacity(0.2)
                .foregroundColor(Color.almostWhite)

            // Cercle de progression
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.primaryPurpule, Color.blue.opacity(0.8)]),
                        center: .center

                    ),
                    style: StrokeStyle(lineWidth: 16, lineCap: .round)
                )
                .rotationEffect(Angle(degrees:-90))
                .scaleEffect(x: -1, y: 1, anchor: .center)
                .animation(.easeOut(duration: 1.0), value: progress)

            // Image de profil: prefer uiImage if present, otherwise imageName -> Image, otherwise the Image fallback
            Group {
                if let uiImage = uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                } else if let name = imageName {
                    Image(name)
                        .resizable()
                } else if let image = image {
                    image
                        .resizable()
                } else {
                    Image("placeholder")
                        .resizable()
                }
            }
            .scaledToFill()
            .frame(width: 144, height: 144)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 3))
        }
        .frame(width: 160, height: 160)
    }
}

#Preview (traits: .sizeThatFitsLayout){
    ProfileProgressView(
        progress: 0.55,
        imageName: "user1"
    )
        .padding()
}
