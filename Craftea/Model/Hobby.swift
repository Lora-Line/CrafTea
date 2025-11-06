//
//  Hobby.swift
//  Craftea
//
//  Created by apprenant75 on 27/10/2025.
//

import Foundation


struct Hobby: Identifiable {
    let id = UUID()
    var name: HobbyName
    var description: String
    var image: String
    var level: Level
    var category: Category
    var equipementNeeded: [BaseEquipment]
    var technicalBasis: [Technique]
    var popular: Bool 
}

enum HobbyName: String, CaseIterable {
    case PeintureAcrylique = "Peinture acrylique"
    case Aquarelle = "Aquarelle"
    case Dessin = "Dessin au crayon"
    case PeintureGalet = "Peinture sur galet"
    case Broderie = "Broderie"
    case Crochet = "Crochet"
    case Couture = "Couture à la main"
    case Poterie = "Poterie"
    case Bougies = "Bougies artisanales"
    case Savons = "Savons maison"
    case Scrapbooking = "Scrapbooking"
    case Origami = "Origami"
    case Bijoux = "Création de bijoux"
    case Macrame = "Macramé"
    case DessinNumerique = "Dessin numérique"
    case Modelisation3D = "Modélisation 3D"
    case Photomontage = "Photomontage"
    case EcritureCreative = "Écriture créative"
    case Calligraphie = "Calligraphie"
    case JournalCreatif = "Journal créatif"
}


enum Level : String, CaseIterable {
    case easy = "Facile"
    case medium = "Moyen"
    case hard = "Difficile"
}

enum Category : String, CaseIterable {
    case textile = "Textile"
    case peinture = "Peinture"
    case dessin = "Dessin"
    case modelage = "Modelage"
    case diy = "DIY"
    case papeterie = "Papeterie"
    case papier = "Papier"
    case accessoires = "Accessoires"
    case numerique = "Numérique"
    case ecriture = "Écriture"   
}

struct BaseEquipment: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var image: String
}

struct Technique: Identifiable {
    let id = UUID()
    var name: String
    var but: String
    var description: String
    var image: String?
}

