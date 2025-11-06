//
//  UnsplashManager.swift
//  Craftea
//
//  Created by chatGPT on 28/10/2025.
//


import SwiftUI

fileprivate struct UnsplashSearchResult: Codable {
    struct Photo: Codable {
        let urls: [String: String]
    }
    let results: [Photo]
}



final class UnsplashService {
    private let accessKey: String
    private let baseURL = "https://api.unsplash.com/search/photos"
    
    init(accessKey: String) {
        self.accessKey = accessKey
    }
    
    func fetchImageURL(for query: String) async -> String? {
        let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let cacheName = safeQuery.replacingOccurrences(of: " ", with: "_")
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(cacheName).png")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return "file://\(fileURL.path)"
        }
        
        guard var components = URLComponents(string: baseURL) else { return nil }
        components.queryItems = [
            URLQueryItem(name: "query", value: safeQuery),
            URLQueryItem(name: "per_page", value: "1"),
            URLQueryItem(name: "orientation", value: "portrait")
        ]
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                print("Unsplash API returned code:", (response as? HTTPURLResponse)?.statusCode ?? 0)
                return nil
            }
            let decoded = try JSONDecoder().decode(UnsplashSearchResult.self, from: data)
            guard let remoteURLString = decoded.results.first?.urls["regular"], let remoteURL = URL(string: remoteURLString) else {
                print("No image found for query:", safeQuery)
                return nil
            }
            
            let (imageData, _) = try await URLSession.shared.data(from: remoteURL)
            if let uiImage = UIImage(data: imageData) {
                try uiImage.pngData()?.write(to: fileURL)
                return "file://\(fileURL.path)"
            }
            
            return remoteURLString
        } catch {
            print("Unsplash fetch error for '\(query)':", error.localizedDescription)
            return nil
        }
    }
}
