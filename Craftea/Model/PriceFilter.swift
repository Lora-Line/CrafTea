//
//  Untitled.swift
//  Craftea
//
//  Created by Apprenant 80 on 31/10/2025.
//

import SwiftUI

enum PriceRange: String, CaseIterable, Identifiable {
    case all = "Tous les prix"
    case range1 = "1 € – 10 €"
    case range2 = "10 € – 20 €"
    case range3 = "20 € – 30 €"
    case range4 = "30 € et plus"
    
    var id: String { self.rawValue }
    
    func contains(_ price: Double) -> Bool {
        switch self {
        case .all: return true
        case .range1: return price >= 1 && price <= 10
        case .range2: return price > 10 && price <= 20
        case .range3: return price > 20 && price <= 30
        case .range4: return price > 30
        }
    }
}
