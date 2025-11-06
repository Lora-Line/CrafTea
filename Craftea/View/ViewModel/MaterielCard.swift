//
//  MaterielCard.swift
//  Craftea
//
//  Created by Andréa  on 03/11/2025.
//

import SwiftUI
import Kingfisher

struct MaterielCard: View {
    var materiel : Materiel
    
    var body: some View {
        NavigationStack {
                NavigationLink(destination: MaterielOccasionView(materiel: materiel)) {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topTrailing) {
                            KFImage(URL(string: materiel.image))
                                                        .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 148.5, height: 139)
                                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text(materiel.typeMateriel.rawValue)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 119/255, green: 87/255, blue: 208/255))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .glassEffect(.regular.tint(.primaryPurpule.opacity(0.3)),
                                             in: RoundedRectangle(cornerRadius: 8))
                                .offset(x: -4, y: 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(materiel.nom)
                                .tertiaryTitle()
                                .foregroundColor(.textPrimary)
                                .lineLimit(1)
                                .padding(.horizontal, 8)
                            
                            Text(materiel.description)
                                .secondaryText()
                                .foregroundColor(.textSecondary)
                                .lineLimit(1)
                                .padding(.horizontal, 8)
                                .padding(.bottom, 8)
                        }
                    }
                    .padding(8)
                    .frame(width: 164.5, height: 216)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.almostWhite)
                            .shadow(color:.gray.opacity(0.2), radius:4, x:0, y:2)
                    )
                }
        }
    }
}

#Preview {
    MaterielCard(materiel:materielsOccasion[0])
}
