//
//  NewReleasesResponse.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 29/04/21.
//

import Foundation

// MARK: - NewReleasesResponse
struct NewReleasesResponse: Codable {
    let albums: Albums
}

// MARK: - Albums
struct Albums: Codable {
    let href: String
    let items: [Album]
    let limit: Int
    let next: String
    let offset: Int
    let total: Int
}

// MARK: - Album
struct Album: Codable {
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    var images: [Image]
    let name, releaseDate, releaseDatePrecision: String
    let totalTracks: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let images: [Image]?
    let id, name, type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, images, id, name, type, uri
    }
}
