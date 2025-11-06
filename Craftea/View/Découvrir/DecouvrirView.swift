//
//  Untitled.swift
//  Craftea
//
//  Created by Lora-Line on 27/10/2025.
//

import SwiftUI

struct DecouvrirView: View {
    @Environment(Session.self) private var session
    @Environment(HobbyViewModel.self) var viewModel

    @State var searchText: String = ""
    @State private var hasScrolled: Bool = false
    @State private var isExpanded: Bool = true
    @State var selectedFilters: [Level] = []
    
    
    var filteredData: [Hobby] {
        viewModel.hobbies.filter { hobby in
            // Text filtering: if search is empty, accept all; otherwise check hobbby name
            let matchesSearch: Bool = searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            ? true
            : hobby.name.rawValue.localizedCaseInsensitiveContains(searchText)
            
            // difficulty filtering
            let matchesFilters: Bool = selectedFilters.isEmpty || selectedFilters.contains(hobby.level)
            
            return matchesSearch && matchesFilters
        }
    }
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                LinearGradient(gradient:Gradient(colors: [.clear, .primaryPurpule.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottom).ignoresSafeArea()
                // tout le contenu
                VStack{
                    //Le message en haut
                    //disparait quand on scroll
                    if !hasScrolled {
                        
                        HStack(){
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Bonjour \(session.currentUser.name) !")
                                    .mainTitle()
                                    .foregroundStyle(Color.primaryPurpule)
                                Text(session.welcome)
                                    .tertiaryTitle()
                                    .foregroundStyle(Color.textSecondary)
                            }
                            Spacer()
                        }.padding(.horizontal, 24)
                    }
                    
                    
                    // Barre de recherche, .searchable fonctionne pas avec le texte et la barre de filtres
                    GlassEffectContainer() {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(Color.textSecondary)
                            TextField("Rechercher un loisir", text: $searchText)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .foregroundStyle(Color.textPrimary)
                            Button(action: {
                                }) {
                                    Image(systemName: "mic.fill")
                                        .foregroundColor(.gray)
                                        .padding(6)
                                        .background(Color.white.opacity(0.8))
                                        .clipShape(Circle())
                                }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 12)
                    }.glassEffect()
                        .padding(.top, hasScrolled ? 20 : 0)
                        .padding(.horizontal)
                    
                    //Barre de filtre
                    GlassEffectContainer(spacing: 12.0) {
                        HStack() {
                            //Toggle button
                            Button(action: {
                                withAnimation {
                                    isExpanded.toggle()
                                    
                                }
                            }) {
                                Image(systemName: "slider.vertical.3")
                                //.frame(width: 32, height: 44)
                                    .font(.system(size: 20, weight:  .semibold))
                                    .foregroundStyle(Color.primaryPurpule)
                            }
                            .buttonStyle(.glass)
                            .zIndex(10)
                            .padding(.leading, 24)
                            
                            if isExpanded {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        
                                        ForEach(Level.allCases, id: \.self) { level in
                                            Button {
                                                withAnimation {
                                                    if selectedFilters.contains(level) {
                                                        selectedFilters.removeAll { $0 == level }
                                                    } else {
                                                        selectedFilters.append(level)
                                                    }
                                                }
                                            } label: {
                                                Text(level.rawValue).buttonLabel()
                                                    .padding(.vertical, 8)
                                                    .padding(.horizontal, 12)
                                                    .glassEffect(selectedFilters.contains(level) ? .regular.tint(.primaryPurpule.opacity(0.6)).interactive() :
                                                            .regular.interactive())
                                                    .foregroundStyle(selectedFilters.contains(level) ? .white : .textPrimary)
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.top, 8)
                    
                    
                    
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .leading, spacing: 16){
                            
                            
                            // Loisir Recommandées
                            Text("Loisirs recommandés")
                                .mainTitle()
                                .foregroundStyle(Color.textPrimary)
                                .padding(.horizontal, 24)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    let recommendedFiltered = filteredData.filter { hobby in session.currentUser.recommandations.contains(where: { $0.name == hobby.name }) }
                                    ForEach(recommendedFiltered) { hobby in
                                        VerticalHobbyView(hobby: hobby)
                                    }
                                }.padding(.horizontal, 24)
                            }
                            // Loisirs Populaires
                            Text("Loisirs populaires")
                                .mainTitle()
                                .foregroundStyle(Color.textPrimary)
                                .padding(.horizontal, 24)
                            
                            VStack(spacing: 16) {
                                ForEach(filteredData) { hobby in
                                    if hobby.popular {
                                        HorizontalHobbyView(hobby: hobby)
                                            .padding(.horizontal, 24)
                                    }
                                }
                                
                            }
                            // tout les loisirs
                            Text("Tous les loisirs")
                                .mainTitle()
                                .foregroundStyle(Color.textPrimary)
                                .padding(.horizontal, 24)
                            VStack(spacing: 12) {
                                ForEach(filteredData) { hobby in
                                    HorizontalHobbyView(hobby: hobby)
                                        .padding(.horizontal, 24)
                                }
                            }
                        }
                    }.onScrollGeometryChange(for: CGFloat.self) { proxy in
                        proxy.contentOffset.y
                    } action: { y, _  in
                        withAnimation(.easeInOut) {
                            hasScrolled = y > 5
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .tint(Color.primaryPurpule)
        }
    }
}

#Preview {
    DecouvrirView()
        .environment(Session(currentUser: users[0]))
        .environment(HobbyViewModel())
        //.environment(welcomeSentence())
}

