//
//  UserProfilView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//
import SwiftUI
struct UserProfilView: View {
    @Environment(Session.self) private var session
    var otherUser: User
    @State private var showingAlert = false
    var body: some View {

        NavigationStack {
            ZStack {
                // background
                Color.background.ignoresSafeArea()
                LinearGradient(gradient: Gradient(colors: [.clear, .primaryPurpule.opacity(0.1)]),
                               startPoint: .topLeading, endPoint: .bottom)
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack (spacing: 24) {
                        //Profil Image
                        VStack {
                            ProfileProgressView(
                                progress: otherUser.niveau
                                ,imageName: otherUser.imageProfil,

                                uiImage: otherUser.imageData.flatMap { UIImage(data: $0) }
                            )
                            HStack{
                                Text(otherUser.pseudo).mainTitle().foregroundStyle(Color(.primaryPurpule))
                                ScoreTag(score: otherUser.score)
                            }.padding(16)

                        }
                        //Section Ses Loisirs
                        if !otherUser.favoritesHobby.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Ses Loisirs").mainTitle().padding(.horizontal, 24)
                                ScrollView (.horizontal, showsIndicators: false) {
                                    HStack (spacing: 16) {
                                        ForEach(otherUser.favoritesHobby ) { hobby in VerticalHobbyView(hobby: hobby)}
                                    }.padding(.horizontal, 24)
                                }
                            }

                        }
                        //Section Article de Troc
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ses Articles").mainTitle().padding(.horizontal, 24)
                            //.padding(15)
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack (spacing: 16) {
                                    ForEach(materielsOccasion) { materiel in
                                        materiel.vendeur.id == otherUser.id ? MaterielCard(materiel: materiel) : nil
                                    }
                                }.padding(.horizontal, 24)
                            }
                            Spacer(minLength: 30)
                        }
                        
                    }
                }

                //Button Signalement !
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        ProfilSignalButton()
                    }
                }
            }
        }
    }
}
#Preview {
    UserProfilView(otherUser: users[2]).environment(HobbyViewModel())
        .environment(Session(currentUser: users[0])).environment(ConversationStore())
}
