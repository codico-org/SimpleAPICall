//
//  ContentView.swift
//  SimpleAPICall
//
//  Created by Nicolò Curioni on 29/11/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var apiService = APIService()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if apiService.isLoading {
                    ProgressView("Fetching data...")
                } else if let errorMessage = apiService.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundStyle(.red)
                        .padding()
                } else if !apiService.posts.isEmpty {
                    List(apiService.posts) { post in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(post.title)
                                .font(.headline)
                            
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(3)
                            
                            Text("User ID: \(post.userId)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                } else if !apiService.isLoading {
                    Text("No posts to display. Tap the button to fetch new ones.")
                        .foregroundStyle(.secondary)
                }
                
                Button("Load Posts") {
                    Task {
                        await apiService.fetchPosts()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Simple")
            .task {
                await apiService.fetchPosts()
            }
        }
    }
}

#Preview {
    HomeView()
}
