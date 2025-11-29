//
//  APIService.swift
//  SimpleAPICall
//
//  Created by Nicolò Curioni on 29/11/25.
//

import Foundation
import Combine

@MainActor
class APIService: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
            
            posts = decodedPosts
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
