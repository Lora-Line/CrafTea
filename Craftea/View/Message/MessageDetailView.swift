//
//  MessageDetailView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//
import SwiftUI

public struct MessageDetailView: View {
    @State private var newMessage: String = ""
    @Bindable var conversation: Conversation
    @Environment(Session.self) private var session
    @State private var showSecurityMessage = true
    @State private var isReserved = false
    @State private var showMessage = true
    @State private var hasConfirmed = false
    var materiel: Materiel? {
            conversation.materiel
        }



    public var body: some View {
        let otherUser = conversation.participants.first { $0.id != session.currentUser.id } ?? conversation.participants.first!
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

                LinearGradient(
                    gradient: Gradient(colors: [.clear, .primaryPurpule.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    MessageDonCardView(isReserved: $isReserved, materiel: materiel)


                    ScrollView {
                        VStack {
                            ForEach(conversation.messages) { message in
                                HStack {
                                    if message.sender.name == conversation.participants.first?.name {
                                        Spacer()
                                        Text(message.content)
                                            .padding(10)
                                            .background(Color.primaryPurpule.opacity(0.2))
                                            .cornerRadius(10)
                                    } else {
                                        Text(message.content)
                                            .padding(10)
                                            .background(Color.secondaryOrange.opacity(0.1))
                                            .cornerRadius(10)
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                            }
                        }
                    }

                    VStack {
                        if isReserved && !hasConfirmed {
                               ButtonComponent(
                                   text: "Confirmer la réception",
                                   style: .outlined,
                                   size: .large
                               ) {
                                   withAnimation {
                                       hasConfirmed = true
                                   }
                               }

                           } else if isReserved && hasConfirmed {
                               VStack(spacing: 16) {
                                   Text("Parfait ! Vous avez bien confirmé la réception.")
                                       .font(.subheadline)
                                       .foregroundColor(.primaryPurpule)
                                       .multilineTextAlignment(.center)
                                       .padding(.bottom, 8)

                                   HStack(spacing: 16) {
                                       NavigationLink(destination: NoteView(userNote:otherUser, materiel: materiel)) {
                                           ButtonComponent(
                                               text: "Évaluer",
                                               style: .filled,
                                               size: .small,
                                               useButton: false
                                           )
                                       }

                                       NavigationLink(destination: AjoutMaterielView()) {
                                           ButtonComponent(
                                               text: "Publier un nouvel article",
                                               style: .outlined,
                                               size: .small,
                                               useButton: false
                                           )
                                       }
                                   }
                               }
                               .padding(.top)
                               .transition(.opacity)
                           }
                        if showSecurityMessage {
                            HStack(alignment: .top) {
                                Text("⚠️️ Pour votre sécurité, ne partagez pas d’adresse exacte ni d’informations personnelles. Privilégiez les lieux publics pour vos échanges.")
                                    .font(.footnote)
                                    .padding(7)
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        showSecurityMessage = false
                                    }
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.gray)
                                        .padding(.vertical, 8)
                                }
                                .padding(.trailing, 4)
                            }
                        }
                        TextField("Écrire un message...", text: $newMessage, axis: .vertical)
                            .lineLimit(...3)
                            .padding()
                            .background(Color.almostWhite)

                        HStack {
                            Button(action: {
                                //TODO: addMedia button + check
                            }) {
                                Image(systemName: "photo.badge.plus")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            Spacer()
                            Button(action: {
                                sendMessage()
                                withAnimation {
                                    showSecurityMessage = false
                                }
                            }){
                                Text("Envoyer")
                                    .foregroundColor(newMessage.isEmpty ? .gray : .primaryPurpule)
                                    .padding(.horizontal, 8)
                            }
                        }

                    }
                    .padding(.horizontal)
                }
                .navigationTitle(otherUser.name)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button (action: {}) {
                            Image(systemName: "flag.fill")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("primaryPurpule"))
                        }

                    }
                }//.padding()
            }.toolbar(.hidden, for: .tabBar)
        }
        }



    private func sendMessage() {
        guard !newMessage.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        guard let sender = conversation.participants.first,
              let receiver = conversation.participants.last else { return }

        let newMsg = Message(
            sender: sender,
            receiver: receiver,
            content: newMessage,
        )

        conversation.messages.append(newMsg)
        newMessage = ""
    }
}


#Preview {
    MessageDetailView(conversation: mockConversations[0])
        .environment(Session(currentUser: users[0]))
}


