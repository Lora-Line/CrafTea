//
//  ProfilView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//
import SwiftUI
import UIKit

struct ProfilView: View {

    @Environment(Session.self) private var session
    @State private var image: UIImage? = nil
    @State private var showingImagePicker = false
    @State private var showSettings = false
    let viewModel = HobbyViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                // background
                Color.background.ignoresSafeArea()
                LinearGradient(gradient: Gradient(colors: [.clear, .primaryPurpule.opacity(0.1)]),
                               startPoint: .topLeading, endPoint: .bottom)
                .ignoresSafeArea()
                // Contenue Principal
                ScrollView(showsIndicators: false) {
                    VStack (spacing: 24) {
                        //Profil Image
                        VStack (spacing: 24) {
                            // Allow tapping the profile to pick a new image
                            ProfileProgressView(
                                progress: session.currentUser.niveau,
                                imageName: session.currentUser.imageProfil,
                                uiImage: session.currentUser.imageData.flatMap { UIImage(data: $0) }
                            )
                            
                            HStack(spacing: 16) {
                                Text("\(session.currentUser.name)").mainTitle().foregroundStyle(Color(.primaryPurpule))
                                ScoreTag(score: session.currentUser.score)                          }

                        }.padding(.top, 50)
                        // Section Loisirs
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Mes Loisirs").mainTitle()
                                .padding(.horizontal, 24)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack (spacing: 16) {
                                    ForEach(session.currentUser.favoritesHobby) { hobby in
                                        VerticalHobbyView(hobby: hobby)
                                    }
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 10)
                            }
                        }
                        // Section Favoris
                        if
                            !session.currentUser.favoriteEquipment.isEmpty || !session.currentUser.favoriteEquipmentPro.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Mes Favoris").mainTitle()
                                    .padding(.horizontal, 24)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack (spacing: 16) {
                                        ForEach(session.currentUser.favoriteEquipment) { materiel in
                                            MaterielCard(materiel: materiel)
                                        }
                                        ForEach(session.currentUser.favoriteEquipmentPro) { materiel in
                                            MaterielCardPro(materiel: materiel)
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 10)
                                }
                            }
                        }

                    }

                    // Section Articles de troc
                    VStack(alignment: .leading) {
                        Text("Mes Articles").mainTitle()
                            .padding(.horizontal, 24)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(materielsOccasion) { materiel in
                                    materiel.vendeur.id == session.currentUser.id ? MaterielCard(materiel: materiel) : nil
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                }
                Button(action: { showSettings = true }) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(Color("primaryPurpule"))
                }
                .accessibilityLabel("Paramètres")
                .font(.system(size: 22))
                .padding(10)
                .glassEffect()
                .padding(.trailing, 20).padding(.top, 60)
                .ignoresSafeArea(edges: .top)
            } //final ZStack

            .fullScreenCover(isPresented: $showSettings) {
                SettingsFullScreen(user: session.currentUser)
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image, sourceType: .photoLibrary)
            }
            .onChange(of: image) { new in
                if let newImage = new {
                    // save image data on the current user
                    session.currentUser.imageData = newImage.jpegData(compressionQuality: 0.8)
                }
            }
        }.onAppear {
            Task {
                await viewModel.loadDetailImages()
            }
        }
    }
}

#Preview {
    ProfilView()
        .environment(Session(currentUser: users[0]))
        .environment(HobbyViewModel())
        .environment(ConversationStore())
}
