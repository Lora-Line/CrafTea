//
//  ContentView.swift
//  Craftea
//
//  Created by Lora-Line on 27/10/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(HobbyViewModel.self) var viewModel
    @Environment(Session.self) var sessions
    @Environment(ConversationStore.self) var conversationStore
    @SceneStorage("selectedTab") private var selectedTab = 0
    var body: some View {
        
        TabView(selection: $selectedTab) {
            Tab("Découvrir", systemImage: "sparkles", value: 0) {
                DecouvrirView()
            }
            Tab("Materiel", systemImage: "pencil.and.ruler.fill", value: 1) {
                MaterielView()
            }
            Tab("Discutions", systemImage: "bubble.left.and.text.bubble.right.fill", value: 2) {
                MessageView()
            }
            Tab("Profil", systemImage: "person", value: 3) {
                ProfilView()
            }
            if selectedTab == 0 || selectedTab == 4
                {
                Tab("Recherche", systemImage: "magnifyingglass", value: 4, role: .search){DecouvrirView()}
            }


        }.tint(Color.primaryPurpule)
            .tabBarMinimizeBehavior(.onScrollDown)
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

struct IsSearchable: ViewModifier {
    let selectedTab: Int
    @Binding var searchText: String
    func body(content: Content) -> some View {
        if selectedTab == 4 {
            content
                .searchable(text: $searchText)
        }        else {
            content


        }
    }
}

extension View{
    func isSearchable(selectedTab: Int, searchText: Binding<String>) -> some View {
        modifier(IsSearchable(selectedTab: selectedTab, searchText: searchText))
    }
}
