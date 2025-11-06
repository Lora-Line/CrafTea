//
//  MessageCardView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 27/10/2025.
//

import SwiftUI

public struct MessageCardView: View {
    var conversation: Conversation
    @Environment(Session.self) private var session
    public var body: some View {
        if let otherUser = conversation.participants.first(where: { $0.id != session.currentUser.id }) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.almostWhite)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    .frame(width: 370, height: 100)

                HStack {
                    NavigationLink(destination: UserProfilView(otherUser: otherUser)){
                        // Prefer local image data if available
                        if let data = otherUser.imageData, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .padding(.leading)
                        } else {
                            Image(otherUser.imageProfil ?? "placeholder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .padding(.leading)
                        }
                    }

                    

                    VStack(alignment: .leading, spacing: 6) {

                        HStack {
                            Text(otherUser.name)
                                .mainText(bold: true).foregroundStyle(Color.textPrimary).multilineTextAlignment(.leading)
                            ScoreTag(score: otherUser.score)

                            Spacer()
                        }


                        Text(conversation.theme)
                            .secondaryText().foregroundColor(.textSecondary).multilineTextAlignment(.leading)


                        if let lastMessage = conversation.messages.last {
                            Text(lastMessage.content)
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                    }
                    .padding(.leading, 4)
                    .padding(.trailing, 8)
                }
                .padding(7)
                .frame(width: 380)
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    MessageCardView(conversation: mockConversations[0])
        .environment(Session(currentUser: users[0]))
}
