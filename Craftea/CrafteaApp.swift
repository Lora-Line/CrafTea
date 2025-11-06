//
//  CrafteaApp.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//

import SwiftUI

@main
struct CrafteaApp: App {
    @State var session = Session(currentUser: users[0]) // je ne pense pas que ce soit correcte d'avoir directement un user ici
    @State var viewModel = HobbyViewModel()
    @State var conversations = ConversationStore()

    var body: some Scene {
        WindowGroup {
            ConnexionView().environment(session).environment(viewModel).environment(conversations)
                .tint(.primaryPurpule)
        }
    }
}
