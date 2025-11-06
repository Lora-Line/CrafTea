//
//  NotificationModel.swift
//  Craftea
//
//  Created by Hava Bakrieva on 04/11/2025.
//

import Foundation

public struct NotificationModel: Identifiable {
    public let id = UUID()
    public let userName: String
    public let timeAgo: String
    public let imageName: String
    public let message: String
}
