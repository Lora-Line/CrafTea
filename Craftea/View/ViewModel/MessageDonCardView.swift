//
//  MessageDonCard.swift
//  Craftea
//
//  Created by Hava Bakrieva on 30/10/2025.
//

import SwiftUI

struct MessageDonCardView: View {
    @Binding var isReserved: Bool
    var materiel: Materiel?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.almostWhite)
                .shadow(color:.gray.opacity(0.2), radius:4, x:0, y:2)
                .frame(width: 370, height: 100)
            HStack {
                AsyncImage(url: URL(string: materiel?.image ?? "placeholder")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 70, height: 70)
                            .padding(.leading)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            //.shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                            .padding(.leading)
                    case .failure(_):
                        Image("placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                            .padding(.leading)
                    @unknown default:
                        EmptyView()
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text(materiel?.nom ?? "Article" )
                            .mainText(bold: true).foregroundStyle(Color.textPrimary).multilineTextAlignment(.leading)
                            .lineLimit(1)
                        
                      
                        Spacer()
                        
                    }
                    
                    ZStack {
                        
                        Text(materiel?.typeMateriel.rawValue ?? "Tag")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 119/255, green: 87/255, blue: 208/255))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .glassEffect(.regular.tint(.primaryPurpule.opacity(0.3)),
                                         in: RoundedRectangle(cornerRadius: 8))
                        
                    }
                }.padding(8)
                ButtonComponent(
                            text: isReserved ? "Réservé" : "Réserver",
                            style: isReserved ? .filled : .outlined,
                            size: .small,
                        ) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isReserved.toggle()
                            }
                        }
                        .padding()
            }.padding(7)
                .frame(width: 380)
            
            
        }
    }
}

#Preview {
        MessageDonCardView(isReserved: .constant(false))
}
