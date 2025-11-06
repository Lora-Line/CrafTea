//
//  MaterielNeufView.swift
//  Craftea
//
//  Created by apprenant75 on 30/10/2025.
//

import SwiftUI

struct MaterielNeufView: View {
    let materiel: MaterielPro
    @Environment(\.dismiss) private var dismiss
    @Environment(Session.self) private var session

    var isLiked: Bool {
            session.currentUser.favoriteEquipment.contains(where: { $0.id == materiel.id })
        }

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            LinearGradient(
                gradient: Gradient(colors: [.clear, .primaryPurpule.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottom
            ).ignoresSafeArea()

            VStack {
                ScrollView {
                    VStack(spacing: 24) {
                        AsyncImage(url: URL(string: materiel.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 345, height: 345)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 4)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 300, height: 300)
                        }

                        HStack {
                            Text(materiel.nom)
                                .secondaryTitle()
                                .multilineTextAlignment(.leading)

                            Spacer()

                            Text(materiel.prix)
                                .categoryText()
                                .foregroundColor(.primaryPurpule)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.9))
                                        .stroke(Color.white.opacity(0.25), lineWidth: 0.5)
                                )
                                .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
                        }

                        HStack {
                            Text("Vendeur :").mainText(bold: true)
                            Text(materiel.vendeur).mainText(bold: true)
                            Spacer()
                        }

                        HStack {
                            Text(materiel.description)
                                .mainText()
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(4)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 24)
                }

                Button(action: {
                }) {
                    HStack {
                        Text("Aller sur le site de \(materiel.vendeur)")
                            .buttonLabel()
                            .foregroundColor(.white)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.primaryPurpule.opacity(0.8))
                            .stroke(Color.white.opacity(0.25), lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    .padding(.bottom, 8)
                }
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
                        if session.currentUser.self.favoriteEquipmentPro.contains(where: { $0.id == materiel.id }) {
                            session.currentUser.favoriteEquipmentPro.removeAll(where: { $0.id == materiel.id })
                        } else {
                            session.currentUser.favoriteEquipmentPro.append(materiel)
                            session.currentUser.niveau += 5
                        }
                    }) {
                        Label("Favorite", systemImage: session.currentUser.favoriteEquipmentPro.contains(where: { $0.id == materiel.id }) ? "heart.fill" : "heart")
                            .foregroundStyle(Color.primaryPurpule)
                    }
                }
            }
        }
    }
}

#Preview {
    MaterielNeufView(materiel: materielsNeuf[0])
        .environment(Session(currentUser: users[0]))
}

