//
//  LoadingHobbiesView.swift
//  Craftea
//
//  Created by Apprenant 83 on 29/10/2025.
//

import SwiftUI

struct LoadingHobbiesView: View {

    @Environment(Session.self) private var session
    @Environment(HobbyViewModel.self) private var viewModel

    @State private var isLoading = false
    @State private var navigate = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Fond en dégradé violet
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 224 / 255, green: 182 / 255, blue: 252 / 255),
                        Color(red: 156 / 255, green: 123 / 255, blue: 245 / 255)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 40) {
                    // Message d’attente
                    Text("Merci pour tes réponses ! Nous te préparons des loisirs adaptés !")
                        .font(.custom("Manrope-Bold", size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    
                    // Navigation automatique vers la suite
                    NavigationLink(destination: ContentView(), isActive: $navigate) {
                        EmptyView()
                    } .toolbar(.hidden, for: .tabBar)

                    // Loader animé
                    Circle()
                        .trim(from: 0, to: 0.2)
                        .stroke(Color(Color(red: 119/255, green: 87/255, blue: 208/255)), lineWidth: 7)
                        .frame(width: 100, height: 100)
                        .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                        .animation(
                            Animation.linear(duration: 1)
                                .repeatForever(autoreverses: false),
                            value: isLoading
                        )
                }
                .onAppear {
                    isLoading = true

                    // Generate recommendations from onboarding answers
                    viewModel.generateRecommendations(session: session)

                    // Automatically navigate after a short delay (e.g., 2.5 seconds)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        navigate = true
                    }
                }
            }.navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LoadingHobbiesView()
        .environment(Session(currentUser: users[0]))
        .environment(HobbyViewModel())
        .environment(ConversationStore())
}
