//
//  QuestionsData.swift
//  Craftea
//
//  Created by Apprenant 83 on 29/10/2025.
//

import SwiftData
import Foundation

@Model
final class Question {
    @Attribute(.unique) var id: UUID
    var text: String
    var options: [String]
    var key: String

    init(id: UUID = UUID(), text: String, options: [String], key: String) {
        self.id = id
        self.text = text
        self.options = options
        self.key = key
    }
}


func populateQuestions(context: ModelContext) {
    let questions: [Question] = [
        Question(
            text: "Quand tu penses loisir créatif, tu penses plutôt à...",
            options: [
                "Peinture, dessin, tout ce qui tache un peu les doigts",
                "Couture, tricot, crochet, le royaume du fil et des aiguilles",
                "Bricolage, DIY déco, objets récup",
                "Écriture, scrapbooking, journaling, les loisirs poétiques",
                "Musique, photo, vidéo, les loisirs créatifs version numérique"
            ],
            key: "category"
        ),
        Question(
            text: "À quelle fréquence pratiques-tu des loisirs créatifs ?",
            options: [
                "Tous les jours (impossible de m’arrêter)",
                "Plusieurs fois par semaine",
                "De temps en temps, quand j’ai l’inspiration",
                "Rarement, mais j’aimerais m’y remettre",
                "Jamais… mais j’aimerais bien commencer !"
            ],
            key: "intensity"
        ),
        Question(
            text: "Comment tu choisis un nouveau loisir à tester ?",
            options: [
                "Au feeling, selon mes envies du moment",
                "En voyant des idées sur TikTok / Insta / Pinterest",
                "Parce qu’un(e) ami(e) m’en parle",
                "En fonction du matériel que j’ai déjà",
                "Selon le temps et le budget que j’ai"
            ],
            key: "motivation"
        ),
        
        Question(
            text: "Quand il s’agit de matériel, tu es plutôt…",
            options: [
                "Team récup’ et système D",
                "Je prends le strict nécessaire",
                "J’investis dans du bon matos",
                "J’adore collectionner les fournitures, même si je ne les utilise pas toujours"
            ],
            key: "budget"
        ),
        
        Question(
            text: "Dans quelle(s) grande(s) catégorie(s) de loisirs tu te reconnais le plus ?",
            options: [
                "Arts visuels (peinture, dessin, photo…)",
                "Arts textiles (couture, tricot, crochet…)",
                "DIY & bricolage (déco, bois, récup’…)",
                "Écriture & narration (journaling, scrapbooking, histoires…)",
                "Autre (je sors des cases)"
            ],
            key: "category2"
           
        ),
        
        Question(
            text: "Quand tu pratiques un loisir créatif, c’est surtout pour…",
            options: [
                "Me détendre et vider ma tête",
                "Exprimer ma créativité",
                "Apprendre de nouvelles techniques",
                "Créer des choses utiles ou à offrir",
                "Passer un bon moment avec d’autres"
            ],
            key: "motivation2"
        ),
        
        
        Question(
            text: "Si ton loisir créatif était une humeur, ce serait…",
            options: [
                "Zen et apaisé",
                "Inspiré et rêveur",
                "Curieux et joueur",
                "Passionné et concentré",
                "Détendu mais chaotique (et fier de l’être)"
            ],
            key: "mood"
        )
    ]

    for question in questions {
        context.insert(question)
    }

    try? context.save()
}
