//
//  AllCategoriesResponse.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 06/05/21.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}


struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [Image]
}
