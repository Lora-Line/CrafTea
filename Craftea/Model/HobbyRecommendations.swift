
// Extension pour HobbyViewModel: génération des recommandations à partir des réponses d'onboarding

import Foundation

extension HobbyViewModel {
    /// Génère entre 3 et 6 hobbies recommandés pour l'utilisateur courant en se basant
    /// sur les réponses stockées dans `session.onboardingAnswers`.
    func generateRecommendations(session: Session) {
        let answers = session.onboardingAnswers

        // Extraire indices
        let categoryIndex = answers["category"]
        let category2Index = answers["category2"]
        let intensityIndex = answers["intensity"]
        let motivationIndex = answers["motivation"]
        let budgetIndex = answers["budget"]
        let motivation2Index = answers["motivation2"]
        let moodIndex = answers["mood"]

        // Construire préférences de catégories
        var preferredCategories: [Category] = []
        func addCategories(_ cats: [Category]) { for c in cats { if !preferredCategories.contains(c) { preferredCategories.append(c) } } }

        switch categoryIndex {
        case 0:
            addCategories([.peinture, .dessin])
        case 1:
            addCategories([.textile])
        case 2:
            addCategories([.diy, .modelage, .accessoires])
        case 3:
            addCategories([.ecriture, .papeterie])
        case 4:
            addCategories([.numerique])
        default:
            break
        }

        switch category2Index {
        case 0:
            addCategories([.peinture, .dessin])
        case 1:
            addCategories([.textile])
        case 2:
            addCategories([.diy, .modelage, .accessoires])
        case 3:
            addCategories([.ecriture, .papeterie])
        default:
            break
        }

        // Niveau préféré heuristique basé sur fréquence
        enum PreferredLevel { case easy, medium, hard }
        var preferredLevel: PreferredLevel = .medium
        if let i = intensityIndex {
            if i >= 3 { preferredLevel = .easy }
            else if i <= 1 { preferredLevel = .hard }
            else { preferredLevel = .medium }
        }

        // Calculer un score pour chaque hobby
        var scored: [(Hobby, Int)] = []
        for hobby in hobbies {
            var score = 0

            // Catégorie
            if preferredCategories.contains(hobby.category) { score += 4 }

            // Popularité et motivations
            if let m = motivationIndex, m == 1 && hobby.popular { score += 1 }
            if let m2 = motivation2Index, (m2 == 4 || m2 == 1) && hobby.popular { score += 1 }

            // Niveau
            switch preferredLevel {
            case .easy:
                if hobby.level == .easy { score += 3 }
                else if hobby.level == .medium { score += 1 }
            case .medium:
                if hobby.level == .medium { score += 2 }
                else if hobby.level == .easy { score += 1 }
            case .hard:
                if hobby.level == .hard { score += 3 }
                else if hobby.level == .medium { score += 1 }
            }

            // Budget / équipement
            if let b = budgetIndex {
                if b == 0 && hobby.equipementNeeded.count <= 4 { score += 1 }
                if b == 2 && hobby.equipementNeeded.count > 3 { score += 1 }
            }

            // motivation2 affinities
            if let m2 = motivation2Index {
                switch m2 {
                case 0:
                    if hobby.level == .easy { score += 1 }
                case 1:
                    if hobby.popular { score += 1 }
                case 2:
                    if hobby.level != .easy { score += 1 }
                case 3:
                    if [.textile, .diy, .modelage, .accessoires].contains(hobby.category) { score += 2 }
                case 4:
                    if hobby.popular { score += 1 }
                default:
                    break
                }
            }

            // mood mapping
            if let mood = moodIndex {
                switch mood {
                case 0:
                    if hobby.level == .easy { score += 1 }
                case 1:
                    if [.peinture, .dessin, .numerique].contains(hobby.category) { score += 1 }
                case 2:
                    if [.numerique, .modelage, .diy].contains(hobby.category) { score += 1 }
                case 3:
                    if hobby.level == .hard { score += 1 }
                case 4:
                    if hobby.popular { score += 1 }
                default:
                    break
                }
            }

            scored.append((hobby, score))
        }

        // Trier par score décroissant
        scored.sort { $0.1 > $1.1 }

        // Construire liste de recommandations (ordre basé sur score)
        let recommendations = scored.map { $0.0 }

        // Sélectionner jusqu'à 6
        var picked: [Hobby] = Array(recommendations.prefix(6))

        // Si moins de 4, compléter avec hobbies faciles non présents
        if picked.count < 4 {
            let easyLeft = hobbies.filter { hobby in
                hobby.level == .easy && !picked.contains(where: { $0.name == hobby.name })
            }
            for h in easyLeft {
                if picked.count >= 4 { break }
                picked.append(h)
            }
        }

        // Si toujours moins de 4, compléter par n'importe quel hobby distinct
        if picked.count < 3 {
            for h in hobbies {
                if !picked.contains(where: { $0.name == h.name }) {
                    picked.append(h)
                    if picked.count >= 3 { break }
                }
            }
        }

        // Assignation à l'utilisateur courant
        session.currentUser.recommandations = picked

        // Nettoyage des réponses temporaires
        session.clearOnboardingAnswers()
    }
}
