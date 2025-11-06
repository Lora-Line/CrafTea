//
//  ConnexionView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//

import SwiftUI

struct ConnexionView: View {
    // Environment & State
    @Environment(Session.self) private var session
    @State private var mail: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isConnected: Bool = false
    @State private var showAlert: Bool = false
    @State private var connectedUser: User? = nil
    
    // View Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Background couleur
                Color("Background")
                    .ignoresSafeArea()

                VStack(spacing: 30) {
               // Logo + Texte d'accueil
                    VStack {
                        Image("CrafteaLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())

                        Text("C'est cool de te revoir !")
                            .font(.custom("Manrope-ExtraBold", size: 36))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                    }
                    // Champs de connexion
                    VStack(alignment: .leading) {

                        Text("Adresse email")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        TextField("exemple@mail. com",text: $mail)

                            .keyboardType(.emailAddress)
                            .padding(12)
                            .background(Color.almostWhite)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)

                                    .stroke(Color.gray.opacity(0.3))

                            ).padding(.bottom)


                        Text("Mot de passe")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        ZStack(alignment: .trailing){

                            if isPasswordVisible {
                                TextField("Mot de passe",text: $password)
                                    .keyboardType(.emailAddress)
                                    .padding(12)
                                    .background(Color.almostWhite)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.3))

                                    )
                            } else {
                                SecureField("Mot de passe",text: $password)
                                    .keyboardType(.emailAddress)
                                    .padding(12)
                                    .background(Color.almostWhite)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.3))

                                    )

                            }
                            Button(action: {
                                withAnimation { isPasswordVisible.toggle() }
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }.padding(.trailing, 12)

                        }
                        // Mot de passe oublié
                        HStack {
                            Spacer()
                            Button("Mot de passe oublié ?") { }
                                .secondaryText()
                                .foregroundStyle(Color.gray)
                                .underline()
                        }
                    }


                    // Bouton de connexion

                    NavigationLink(
                        destination: ContentView(), isActive: $isConnected) {
                            Button(action: login) {
                                HStack {
                                    Text("Me connecter")
                                        .font(.custom("Manrope-Bold", size: 20))
                                        .foregroundColor(.almostWhite)
                                    Image(systemName: "arrow.up.right")
                                        .foregroundColor(.white).bold()
                                }
                                .padding()
                                .frame(width: 220, height: 50)
                                .background(Color("primaryPurpule"))
                                .cornerRadius(10)
                            }
                            .alert("Identifiants incorrects", isPresented: $showAlert) {
                                Button("OK", role: .cancel) {}
                            }


                        }

                    Spacer()
                  // Lien vers inscription
                    HStack {
                        Text("Tu n'as pas de compte ?")
                            .secondaryText()
                        NavigationLink(destination: InscriptionView()) {
                            Text("S'inscrire")
                                .secondaryText()
                                .underline()
                        }
                    }
                }
                .padding(.horizontal, 24)
            }.navigationBarBackButtonHidden(true)
        }
    }
    
    // Fonction de login

    func login() {

        if let userFound = users.first(where: {
            $0.mail.lowercased() == mail.lowercased() &&
            $0.password == password
        }) {
            session.currentUser = userFound
            session.welcome = session.homePhrases.randomElement() ?? ":)"
            isConnected = true
        } else {
            showAlert = true
        }
    }
}

#Preview {
    ConnexionView().environment(Session(currentUser: users[0]))
        .environment(HobbyViewModel())
        .environment(ConversationStore())
}
