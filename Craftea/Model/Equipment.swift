//
//  Equipment.swift
//  Craftea
//
//  Created by apprenant75 on 27/10/2025.
//

import Foundation


enum EquipmentCategory: String, CaseIterable {
    case don = "Don"
    case pret = "Prêt"
    case echange = "Échange"
}

struct Materiel: Identifiable {
    let id = UUID()
    let nom: String
    var image: String
    let description: String
    let vendeur: User
    let typeMateriel: EquipmentCategory
}

struct MaterielPro: Identifiable {
    let id = UUID()
    let nom: String
    var image: String
    let description: String
    let vendeur: String
    let prix: String
}

