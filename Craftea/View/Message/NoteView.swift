//
//  NoteView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//

import SwiftUI

struct NoteView: View {
    var userNote: User
    var materiel: Materiel?
    @State private var rating = 0
    @State private var text = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            LinearGradient(
                gradient: Gradient(colors: [.clear, .primaryPurpule.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack(){
                    Image(userNote.imageProfil ?? "placeholder")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                        .padding(.trailing, 16)
                    VStack{
                        HStack{
                            Text(userNote.name).tertiaryTitle()
                            Spacer()
                        }.padding(.bottom, 1)
                        HStack{
                            Text(materiel?.typeMateriel.rawValue ?? "Don")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 119/255, green: 87/255, blue: 208/255))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .glassEffect(.regular.tint(.primaryPurpule.opacity(0.3)),
                                             in: RoundedRectangle(cornerRadius: 8))
                            Text(materiel?.nom ?? "Don de pelotes")
                                .mainText().foregroundColor(.textSecondary)
                            Spacer()
                        }
                    }
                    Spacer()
                }.padding(.horizontal, 24)
                    .padding(.vertical, 32)
                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.secondaryOrange)
                            .onTapGesture {
                                rating = index
                            }
                    }
                }
                
                Text(message(for: rating))
                    .font(.headline)
                    .foregroundColor(.primaryPurpule)
                Text("Un petit commentaire ?")
                TextEditor(text: $text)
                    .frame(width: 350, height: 200)
                    .padding(8)
                    .background(Color(.almostWhite))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .font(.body)
                ButtonComponent(text: "Envoyer", style: rating == 0 ? .disabled : .filled, size: .small, action: {userNote.score = (userNote.score + Double(rating))/2
                    dismiss()
                }).disabled(rating == 0)
                Spacer()
            }
            .animation(.easeInOut, value: rating)
        }
        
    }
    
    func message(for rating: Int) -> String {
        switch rating {
        case 1: return "Pas terrible"
        case 2: return "Bof, moyen"
        case 3: return "Correct"
        case 4: return "Très bien !"
        case 5: return "Excellent !"
        default: return "Appuie sur une étoile pour noter"
        }
    }
}


#Preview {
    NoteView(userNote: users[2])
}
