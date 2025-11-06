//
//  Questions6View.swift
//  Craftea
//
//  Created by Apprenant 83 on 29/10/2025.
//

import SwiftUI

struct Questions6View: View {


    @Environment(Session.self) private var session

    @State private var currentIndex = 0
    @State private var selectedOption: Int? = nil
    
    // Question data
    let questions: [Question] = [
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
        )]
    // Body
    var body: some View {
        let question = questions[currentIndex]
        
        NavigationStack {

            ZStack(alignment: .top) {

                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 224/255, green: 182/255, blue: 252/255),
                        Color(red: 156/255, green: 123/255, blue: 245/255)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottom
                )
                .ignoresSafeArea()


                VStack(alignment: .leading, spacing: 20) {
                    Text("Trouve un loisir qui te correspond !")
                        .secondaryTitle()
                        .padding(.top, 32)
                    ProgressView(value: 6.0 / 7.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color(Color(red: 119/255, green: 87/255, blue: 208/255))))

                    Text(question.text)
                        .mainText(bold: true)
                        .multilineTextAlignment(.leading)
                        .frame(height: 50)
                    VStack(spacing:16){
                        ForEach(question.options.indices, id: \.self) { index in
                            HStack {
                                Text(question.options[index])
                                    .mainText()
                                    .fixedSize(horizontal: false, vertical: true)

                                Spacer(minLength: 16)
                                Image(systemName: selectedOption == index ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedOption == index ? Color(Color(red: 119/255, green: 87/255, blue: 208/255)) : .gray)
                            }
                            .padding(16)
                            .frame(height: 70)
                            .background(selectedOption == index ? .almostWhite.opacity(0.7) : .clear)
                            .cornerRadius(10)
                            .glassEffect(in: RoundedRectangle(cornerRadius: 10))
                            .onTapGesture { selectedOption = index; session.onboardingAnswers[question.key] = index }
                        }

                        Spacer()
                    }.frame(height: 450)


                    NavigationLink(destination: Questions7View()) {
                        HStack(spacing: 16) {
                            Text("Suivant")
                                .secondaryTitle()
                            Image(systemName: "arrow.right")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(selectedOption != nil ? .almostWhite : .almostWhite.opacity(0.5))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(selectedOption != nil ? Color(Color(red: 119/255, green: 87/255, blue: 208/255).opacity(0.9)) : Color(Color(red: 119/255, green: 87/255, blue: 208/255)).opacity(0.5))
                        .cornerRadius(10)
                        .glassEffect(in: RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 20)
                    }
                    .disabled(selectedOption == nil)
                }
                .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    Questions6View().environment(Session(currentUser: users[0]))
        .environment(HobbyViewModel())
        .environment(ConversationStore())
}
