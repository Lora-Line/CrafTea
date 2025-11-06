//
//  MaterielOccasionView.swift
//  Craftea
//
//  Created by apprenant75 on 30/10/2025.
//

import SwiftUI

struct MaterielOccasionView: View {
    let materiel: Materiel
    @Environment(\.dismiss) private var dismiss
    @State private var isLiked = false
    @Environment(Session.self) private var session
    @Environment(ConversationStore.self) private var conversationStore

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            LinearGradient(
                gradient: Gradient(colors: [.clear, .primaryPurpule.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 24) {
                        AsyncImage(url: URL(string: materiel.image)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 345,height: 345)
                                    .frame(maxWidth: .infinity)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 345,height: 345)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .shadow(radius: 4)
                            case .failure(_):
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.almostWhite)
                                    .frame(height: 300)
                                    .frame(maxWidth: .infinity)
                                    .shadow(radius: 2)
                            @unknown default:
                                EmptyView()
                            }
                        }

                        HStack(alignment: .center, spacing: 8) {
                            Text(materiel.nom)
                                .secondaryTitle()
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 7)

                            Spacer()

                            Text(materiel.typeMateriel.rawValue)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 119/255, green: 87/255, blue: 208/255))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .glassEffect(.clear.tint(.primaryPurpule.opacity(0.3)),
                                             in: RoundedRectangle(cornerRadius: 8))
                        }
                        .padding(.horizontal, 7)

                            HStack(alignment: .center, spacing: 12) {
                                NavigationLink(destination: UserProfilView(otherUser: materiel.vendeur)){
                                    Image(materiel.vendeur.imageProfil ?? "placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.primaryPurpule.opacity(0.5), lineWidth: 2)
                                        )

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(materiel.vendeur.pseudo)
                                            .mainText(bold: true)
                                            .foregroundColor(Color.textPrimary)

                                        ScoreTag(score: materiel.vendeur.score)
                                    }

                                    Spacer()
                                }
                                NavigationLink(
                                    destination: MessageDetailView(
                                        conversation: conversationStore.getOrCreateConversation(
                                            currentUser: session.currentUser,
                                            otherUser: materiel.vendeur,
                                            theme: materiel.nom,
                                            materiel: materiel
                                        ),

                                    )
                                ){
                                    Text("Contacter")
                                        .buttonLabel()
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 10)
                                        .background(
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(.ultraThinMaterial)
                                                    .fill(Color.primaryPurpule.opacity(0.6))
                                                    .stroke(Color.white.opacity(0.25), lineWidth: 0.5)
                                            }
                                        )
                                        
                                }

                        }
                        .padding(.horizontal, 7)
                        .padding(.top, -8)

                        HStack(spacing: 6) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.primaryPurpule)
                            Text(materiel.vendeur.location ?? "inconnu")
                                .secondaryText()
                                .foregroundColor(.textSecondary)
                            Spacer()
                        }
                        .padding(.horizontal, 7)

                        HStack {
                            Text(materiel.description)
                                .mainText()
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(4)
                                .padding(.horizontal, 7)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primaryPurpule)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if session.currentUser.self.favoriteEquipment.contains(where: { $0.id == materiel.id }) {
                            session.currentUser.favoriteEquipment.removeAll(where: { $0.id == materiel.id })
                        } else {
                            session.currentUser.favoriteEquipment.append(materiel)
                            session.currentUser.niveau += 0.05
                        }
                    }) {
                        Label("Favorite", systemImage: session.currentUser.favoriteEquipment.contains(where: { $0.id == materiel.id }) ? "heart.fill" : "heart")
                            .foregroundStyle(Color.primaryPurpule)
                    }
                }
            }
        }
    }

}


#Preview {
    MaterielOccasionView(materiel: materielsOccasion[0])
        .environment(Session(currentUser: users[0]))
        .environment(ConversationStore())
}

