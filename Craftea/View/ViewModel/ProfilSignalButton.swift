//
//  ProfilSignalButton.swift
//  Craftea
//
//  Created by Andréa  on 29/10/2025.
//

import SwiftUI

struct ProfilSignalButton: View {
    @State private var showingAlert = false

    var body: some View {
        Button(action: {
            showingAlert = true
        }) {
            Image(systemName: "flag.fill")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("primaryPurpule"))
        }
        .alert("Souhaitez-vous signaler ce profil ?", isPresented: $showingAlert) {
            Button("Signaler", role: .destructive) {
                // Action de signalement ici
            }
            Button("Bloquer", role: .destructive) {
                // Action de blocage ici
            }
            Button("Fermer", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationStack {
        Text("Profil")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ProfilSignalButton()
                }
            }
    }
}
