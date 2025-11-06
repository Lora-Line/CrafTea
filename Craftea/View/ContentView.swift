//
//  ContentView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(HobbyViewModel.self) var viewModel
    @Environment(Session.self) var sessions
    @Environment(ConversationStore.self) var conversationStore
    var body: some View {
        TabView {
            Tab("Découvrir", systemImage: "sparkles") {
                DecouvrirView()
            }
            Tab("Materiel", systemImage: "pencil.and.ruler.fill") {
                MaterielView()
            }
            Tab("Discutions", systemImage: "bubble.left.and.text.bubble.right.fill") {
                MessageView()
            }
            Tab("Profil", systemImage: "person") {
                ProfilView()
            }
        }.tint(Color.primaryPurpule)
            .navigationBarBackButtonHidden(true)
            
            .onAppear {
                Task {
                    await viewModel.loadDetailImages()
                }
            }
    }
}

#Preview {
    ContentView()
        .environment(Session(currentUser: users[0]))
        .environment(HobbyViewModel())
        .environment(ConversationStore())
}
