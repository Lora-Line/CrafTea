//
//  User.swift
//  Craftea
//
//  Created by apprenant75 on 27/10/2025.
//

import Foundation
import Observation

@Observable
class User: Identifiable {
    let id = UUID()
    var name: String
    var surname: String
    var mail: String
    var pseudo: String
    var password: String
    var location: String?
    var score: Double
    var niveau: Double
    var favoriteEquipment: [Materiel]
    var favoriteEquipmentPro : [MaterielPro]
    var favoritesHobby: [Hobby]
    var equipment: [Materiel?]
    var recommandations: [Hobby]
    var imageProfil: String?
    
    init(name: String, surname: String, mail: String, pseudo: String, password: String, location: String? = nil, score: Double = 5, niveau: Double = 0.0, favoriteEquipment: [Materiel] = [], favoriteEquipmentPro : [MaterielPro] = [], favoritesHobby: [Hobby] = [], equipment: [Materiel] = [], recommandations: [Hobby] = [], imageProfil: String? = nil) {
        self.name = name
        self.surname = surname
        self.mail = mail
        self.pseudo = pseudo
        self.password = password
        self.location = location
        self.score = score
        self.niveau = niveau
        self.favoriteEquipment = favoriteEquipment
        self.favoriteEquipmentPro = favoriteEquipmentPro
        self.favoritesHobby = favoritesHobby
        self.equipment = equipment
        self.recommandations = recommandations
        self.imageProfil = imageProfil
    }
}

