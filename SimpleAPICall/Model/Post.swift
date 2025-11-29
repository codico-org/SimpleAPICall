//
//  Post.swift
//  SimpleAPICall
//
//  Created by Nicolò Curioni on 29/11/25.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
    var shortTitle: String {
        return String(title.prefix(50)) +  (title.count > 50 ? "..." : "")
    }
}
