//
//  InscriptionView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//

import SwiftUI


struct InscriptionView: View {
    // Environment & State
    @Environment(Session.self) private var session
    @State private var nom: String = ""
    @State private var name: String = ""
    @State private var pseudo: String = ""
    @State private var mail: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isPassword2Visible: Bool = false
    @State private var createAccount: Bool = false
    @State private var acceptedTerms = false

    
    // Password Validation
    func isPasswordValid() -> Bool {
            return password.count >= 6 && password.count <= 15
        }
    
    func isPassword2Valid() -> Bool {
            return password2.count >= 6 && password2.count <= 15
        }
    // Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Couleur d’arrière-plan
                Color("Background")
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    VStack(spacing: 0) {

                        Image("CrafteaLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                        Text("Bienvenue !")
                            .font(.custom("Manrope-Bold", size: 36))
                            .fontWeight(.bold)
                    }
                    

                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            // Nom
                            Text("Nom")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("Nom", text: $name)
                                .padding(12)
                                .background(Color.almostWhite)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            // Prénom
                            Text("Prénom")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("Prénom", text: $nom)
                                .padding(12)
                                .background(Color.almostWhite)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            // Pseudo
                            Text("Pseudo")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("Pseudo", text: $pseudo)
                                .padding(12)
                                .background(Color.almostWhite)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            // Adresse email
                            Text("Adresse email")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("exemple@mail. com", text: $mail)
                                .keyboardType(.emailAddress)
                                .padding(12)
                                .background(Color.almostWhite)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            // Mot de passe
                            Text("Mot de passe")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            ZStack(alignment: .trailing) {
                                if isPasswordVisible {
                                    TextField("Mot de passe", text: $password)
                                        .padding(12)
                                        .background(Color.almostWhite)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.3))
                                        )
                                } else {
                                    SecureField("Mot de passe", text: $password)
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
                                }
                                .padding(.trailing, 12)

                            }
                        }

                        if !isPasswordValid() && !password.isEmpty {
                            Text("⚠️ Le mot de passe doit contenir entre 6 et 15 caractères.")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.red)
                                .padding(.horizontal, 4)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            // Confirmation du mot de passe
                            Text("Confirmez le mot de passe")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            ZStack(alignment: .trailing) {
                                if isPassword2Visible {
                                    TextField("Confirmez le mot de passe", text: $password2)
                                        .padding(12)
                                        .background(Color.almostWhite)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.3))
                                        )
                                } else {
                                    SecureField("Confirmez le mot de passe", text: $password2)
                                        .padding(12)
                                        .background(Color.almostWhite)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.3))
                                        )
                                }
                                Button(action: {
                                    withAnimation { isPassword2Visible.toggle() }
                                }) {
                                    Image(systemName: isPassword2Visible ? "eye" : "eye.slash")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 12)

                            }
                        }

                        if !isPassword2Valid() && !password2.isEmpty {
                            Text("⚠️ Le mot de passe doit contenir entre 6 et 15 caractères.")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.red)
                                .padding(.horizontal, 4)
                        }

                        //Accepte
                        
                        HStack(spacing: 8) {
                            Button(action: { acceptedTerms.toggle() }) {
                                Image(systemName: acceptedTerms ? "checkmark.square" : "square")
                                    .foregroundColor(.primaryPurpule)
                                    .font(.system(size: 24))
                            }
                            HStack(spacing:0){
                                Text("J'ai lu et j'accepte les")
                                    .secondaryText()
                                    .foregroundStyle(Color(.textPrimary))

                                Text(" conditions d'utilisation")
                                    .secondaryText()
                                    .foregroundStyle(Color(.textPrimary))
                                    .underline()
                            }
                        }.padding(.vertical, 16)
                    }

                    Button(action: {
                        // Crée le nouvel utilisateur
                        let newUser = User(name: nom, surname: name, mail: mail, pseudo: pseudo, password: password)
                        users.append(newUser)

                        session.currentUser = newUser

                        session.welcome = session.homePhrases.randomElement() ?? ":)"

                        print("Nouvel utilisateur : \(session.currentUser.name)")

                        // Active la navigation
                        createAccount = true
                    }) {

                        HStack {

                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 20))
                                .bold()
                            Text("Valider l'inscription")
                                .secondaryTitle()
                        }
                        .foregroundColor(.almostWhite)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color("primaryPurpule"))
                        .cornerRadius(10)
                    }

                    // Navigation automatique après clic
                    .navigationDestination(isPresented: $createAccount) {
                        QuestionsView()
                    }

                    HStack(spacing: 5) {
                        Text("Tu as déjà un compte?")
                            .secondaryText()

                        NavigationLink(destination: ConnexionView()) {
                            Text("Se connecter")
                                .secondaryText().underline()

                        }
                    }

                }.padding(.horizontal, 24)
            }.navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    InscriptionView().environment(Session(currentUser: users[0]))
        .environment(HobbyViewModel())
        .environment(ConversationStore())
}

