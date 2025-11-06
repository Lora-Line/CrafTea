//
//  ConversationStore.swift
//  Craftea
//
//  Created by Hava Bakrieva on 03/11/2025.
//

import Foundation
import Observation

@Observable
class ConversationStore {
    var conversations: [Conversation] = []

    func getOrCreateConversation(currentUser: User, otherUser: User, theme: String, materiel: Materiel? = nil) -> Conversation {
        if let existing = conversations.first(where: {
            Set($0.participants.map(\.id)) == Set([currentUser.id, otherUser.id]) &&
            $0.theme == theme
        }) {
            return existing
        }

        let newConversation = Conversation(participants: [currentUser, otherUser], theme: theme, materiel: materiel)
        conversations.append(newConversation)
        return newConversation
    }
    
    func addMessage(to conversation: Conversation, message: Message) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index].addMessage(message)
        }
    }
}
