//
//  Session.swift
//  Craftea
//
//  Created by apprenant75 on 03/11/2025.
//

import Foundation
import Observation

@Observable
final class Session {
    var currentUser: User
    var welcome: String
    // Stocke temporairement les réponses du questionnaire d'onboarding
    // clé = Question.key, valeur = index de l'option sélectionnée
    var onboardingAnswers: [String: Int] = [:]

    let homePhrases: [String] = [
        "Débloque ta créativité sans limites !",
        "Crée, partage, inspire.",
        "Laisse parler tes mains.",
        "Transforme une envie en projet.",
        "Trouve ton prochain coup de cœur créatif.",
        "Partage ton matos, multiplie les idées.",
        "Ose expérimenter, ose t'amuser.",
        "Chaque création commence par un essai.",
        "Fais de ta curiosité une création."
    ]
    init(currentUser: User, welcome: String = "") {
        self.currentUser = currentUser
        self.welcome = welcome
    }

    func clearOnboardingAnswers() {
        onboardingAnswers.removeAll()
    }
}
