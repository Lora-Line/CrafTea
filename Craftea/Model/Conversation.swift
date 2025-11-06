//
//  Conversation.swift
//  Craftea
//
//  Created by Hava Bakrieva on 03/11/2025.
//
import Foundation
import Observation

@Observable
class Conversation: Identifiable {
    let id = UUID()
    let participants: [User]
    var messages: [Message]
    var theme: String
    var materiel: Materiel?

    init(participants: [User], messages: [Message] = [], theme: String, materiel: Materiel? = nil) {
        self.participants = participants
        self.messages = messages
        self.theme = theme
        self.materiel = materiel
    }

    func addMessage(_ message: Message) {
        messages.append(message)
    }
}
