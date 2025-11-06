//
//  NotificationCardView.swift
//  Craftea
//
//  Created by Hava Bakrieva on 29/10/2025.
//

import SwiftUI

public struct NotificationCardView: View {
    let notification: NotificationModel
    let onDelete: (() -> Void)?
    
    public init(notification: NotificationModel, onDelete: (() -> Void)? = nil) {
        self.notification = notification
        self.onDelete = onDelete
    }
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.almostWhite)
                .shadow(color:.gray.opacity(0.2), radius:4, x:0, y:2)
                .frame(width: 370, height: 100)
            HStack(alignment: .top) {
                Image(notification.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    //.shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                    .padding(.leading)
                VStack(alignment: .leading) {
                    HStack {
                        Text(notification.message)
                            .mainText(bold: true).foregroundStyle(Color.textPrimary).multilineTextAlignment(.leading)
                            .padding(.vertical, 3)
                        
                        
                        
                        
                    }
                    
                    Text(notification.timeAgo)
                        .secondaryText().foregroundColor(.textSecondary).multilineTextAlignment(.leading)
                }.padding(.horizontal, 5)
                
                Spacer()
                if let onDelete {
                    Button(action: onDelete) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.borderless)
                    .padding(.horizontal, 10)
                }
                
            }.padding(7)
                .frame(width: 380)
            
            
        }
    }
}


#Preview {
    NotificationCardView(notification: mockNotifications[0])
}
