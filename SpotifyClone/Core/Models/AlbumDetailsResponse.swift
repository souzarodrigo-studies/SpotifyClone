//
//  AlbumDetailsResponse.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 02/05/21.
//

import Foundation

// MARK: - AlbumDetailsResponse
struct AlbumDetailsResponse: Codable {
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let id: String
    let images: [Image]
    let label:String
    let name: String
    let tracks: TracksResponse

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case id, images, label, name
        case tracks
    }
}

// MARK: - Tracks
struct TracksResponse: Codable {
    let href: String
    let items: [AudioTrack]
    let limit: Int
    let offset: Int
    let total: Int
}

// MARK: - Item
struct ItemTrack: Codable {
    let album: Album?
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMS: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let trackNumber: Int
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case album
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name
        case trackNumber = "track_number"
        case type, uri
    }
}
