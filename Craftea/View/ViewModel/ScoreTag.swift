//
//  ScoreTag.swift
//  Craftea
//
//  Created by Andréa  on 03/11/2025.
//

import SwiftUI

struct ScoreTag: View {
    var score : Double
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", score))
            }
                .buttonLabel()
                .foregroundColor(.textPrimary)
                .font(.system(size: 16, weight: .semibold))
                .textCase(.uppercase)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.yellow.opacity(0.03))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.yellow, lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.gray.opacity(0.25), .gray.opacity(0.2)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                        )

                )

        }
    }
}

#Preview {
    ScoreTag(score: 5)
}
