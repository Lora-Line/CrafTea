//
//  LoisirDetailView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//

import SwiftUI
import Kingfisher

struct LoisirDetailView: View {
    @Environment(Session.self) private var session
    var hobby: Hobby
    @Environment(HobbyViewModel.self) var viewModel
    @State private var revealDetails = true
    @State private var hasScrolled: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.background.ignoresSafeArea()
            VStack{
                VStack{
                    
                    Image(hobby.image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: hasScrolled ? 120 : 250)
                        .overlay(LinearGradient(colors: [.black.opacity(0.1), .clear], startPoint: .bottom, endPoint: .center))
                        .clipShape(UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 32,
                            bottomTrailingRadius: 32,
                            topTrailingRadius: 0
                        ))
                        
                        .ignoresSafeArea()
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text(hobby.name.rawValue)
                                .mainTitle()
                                .foregroundColor(.textPrimary)
                            Text(hobby.description)
                                .secondaryText()
                                .foregroundColor(.textSecondary)
                        }
                        Spacer()
                        HStack{
                            switch hobby.level{
                            case .easy : Circle().fill(Color.green).frame(width: 8)
                            case .medium:
                                Circle().fill(Color.orange).frame(width: 8)
                            case .hard:
                                Circle().fill(Color.red).frame(width: 8)
                            }
                            Text(hobby.level.rawValue).tertiaryTitle().foregroundColor(.textPrimary)
                        }.padding(.leading, 8).padding(.vertical, 4).padding(.trailing, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.03))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 4)
                                            .blur(radius: 4)
                                            .offset(x: 2, y: 2)
                                            .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.25), .gray.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.secondaryOrange.opacity(0.03), lineWidth: 8)
                                            .blur(radius: 4)
                                            .offset(x: -2, y: -2)
                                            .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    ))
                    }.padding(.horizontal, 24)
                        .padding(.bottom)
                }.ignoresSafeArea(edges: .top)
                    .padding(.bottom, -120)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 16) {
                        
                        //Materiel
                        DisclosureGroup(
                            isExpanded: $revealDetails,
                            content: {
                                ForEach(hobby.equipementNeeded, id: \.id) { item in
                                    NavigationLink(destination: MaterielView(searchTextfromDetailView: item.name)){
                                        HStack(alignment: .top) {
//                                            KFImage(URL(string: item.image))
//                                                //.placeholder: { ProgressView() }
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: 60, height: 60)
//                                                .clipShape(RoundedRectangle(cornerRadius: 8))


                                            AsyncImage(url: URL(string: item.image)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 60, height: 60)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))


                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 60, height: 60)
                                            }
                                            VStack(alignment: .leading){
                                                Text(item.name)
                                                    .mainText(bold: true).foregroundColor(.textPrimary)
                                                
                                                
                                                Text(item.description)
                                                    .secondaryText().foregroundColor(.textSecondary)
                                                
                                            }
                                            Spacer()
                                        }
                                        .padding(8)
                                        .background(Color.almostWhite)
                                        .cornerRadius(16)
                                        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
                                        
                                    }
                                }
                            },
                            label: {
                                Text("Materiel de base")
                                    .secondaryTitle()
                                    .foregroundColor(.textPrimary)
                            }
                        )
                        .padding(.horizontal, 24)
                        
                        //Techniques
                        Text("Techniques de base")
                            .secondaryTitle()
                            .foregroundColor(.textPrimary)
                            .padding(.horizontal, 24)
                        ForEach(hobby.technicalBasis){ item in
                            DisclosureGroup{
                                VStack{
                                    //Image(item.image ?? "")
                                    if item.image != nil {
                                        AsyncImage(url: URL(string: item.image!)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: 182)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .padding(.top, 8)
                                                .allowsHitTesting(false)
                                        } placeholder: {
                                            ProgressView()
                                                .frame(height: 182)
                                                .allowsHitTesting(false)
                                        }
                                    }
                                    VStack(alignment: .leading){
                                        Text("But :").mainText(bold: true).padding(.bottom, 2)
                                        Text(item.but)
                                            .mainText()
                                            .multilineTextAlignment(.leading)
                                            .padding(.bottom, 8)
                                        Text("Technique :").mainText(bold: true).padding(.bottom, 2)
                                        Text(item.description)
                                            .mainText()
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }label: {
                                Text(item.name)
                                    .mainText(bold: true)
                                    .foregroundStyle(Color(.textPrimary))
                                    .contentShape(Rectangle())

                                
                            }.padding(16)
                                .background(Color.almostWhite)
                                .cornerRadius(16)
                                .padding(.horizontal, 24)
                        }.shadow(color:.gray.opacity(0.1), radius:4, x:0, y:2)
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                if session.currentUser.favoritesHobby.contains(where: { $0.id == hobby.id }) {
                                    session.currentUser.favoritesHobby.removeAll(where: { $0.id == hobby.id })
                                } else {
                                    session.currentUser.favoritesHobby.append(hobby)
                                    session.currentUser.niveau += 0.05
                                }
                            }) {
                                Label("Favorite", systemImage: session.currentUser.favoritesHobby.contains(where: { $0.id == hobby.id }) ? "heart.fill" : "heart")
                            }
                            .toolbarBackground(.visible, for: .navigationBar)
                                   .navigationBarTitleDisplayMode(.inline)
                             .tint(Color.primaryPurpule)
                             //.toolbarForegroundStyle(Color.primaryPurpule, for: .navigationBar)
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
}

#Preview {
    let viewModel = HobbyViewModel()
    LoisirDetailView(hobby: viewModel.hobbies[5])
        .environment(Session(currentUser: users[0]))
        .environment(HobbyViewModel())
}

