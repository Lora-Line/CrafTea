//
//  MessageMockData.swift
//  Craftea
//
//  Created by Hava Bakrieva on 28/10/2025.
//


import Foundation

let ethan = users[0]
let pauline = users[2]
let nathan = users[1]

let ethanPaulineMessages = [
    Message(sender: ethan, receiver: pauline, content: "Bonjour Pauline ! Est-ce que la peinture est toujours dispo ?"),
    Message(sender: pauline, receiver: ethan, content: "Bonjour Ethan ! Oui, elle est toujours disponible 🙂"),
    Message(sender: ethan, receiver: pauline, content: "Super ! Où est-ce que je peux la récupérer ?"),
    Message(sender: pauline, receiver: ethan, content: "Tu peux venir au Jardin Japonais, c’est juste à côté de chez moi 🙂")
]


let ethanNathanMessages = [
    Message(sender: ethan, receiver: nathan, content: "Salut Nathan ! J’ai vu que tu prêtes tes pinceaux ronds. Est-ce que ce serait possible ce samedi ?"),
    Message(sender: nathan, receiver: ethan, content: "Oui bien sûr 🙂 Tu peux le récupérer à cette adresse : rue de Rivoli, 75008 Paris."),
    Message(sender: ethan, receiver: nathan, content: "Parfait, merci beaucoup !")
]


let mockConversations: [Conversation] = [
    Conversation(
        participants: [ethan, pauline],
        messages: ethanPaulineMessages,
        theme: "Don de peinture",
        materiel: materielsOccasion.first(where: { $0.nom.contains("Peinture") })
    ),
    Conversation(
        participants: [ethan, nathan],
        messages: ethanNathanMessages,
        theme: "Prêt pinceaux ronds",
        materiel: materielsOccasion.first(where: { $0.nom.contains("Pinceaux ronds") })
    )
]

