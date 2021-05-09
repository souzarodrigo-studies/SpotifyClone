//
//  Recommendations.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 29/04/21.
//

import Foundation

// MARK: - RecommendationsResponse
struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
    let seeds: [Seed]
}

// MARK: - Seed
struct Seed: Codable {
    let initialPoolSize, afterFilteringSize, afterRelinkingSize: Int
    let id, type: String
    let href: String?
}

// MARK: - Track
struct AudioTrack: Codable {
    var album: Album?
    let artists: [Artist]
    let discNumber, durationMS: Int
    let explicit: Bool
    //let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let popularity: Int?
    let trackNumber: Int
    let type, uri: String
    let previewURL: String?

    enum CodingKeys: String, CodingKey {
        case album, artists
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        //case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case trackNumber = "track_number"
        case type, uri
        case previewURL = "preview_url"
    }
}

// MARK: - Album
struct TrackAlbum: Codable {
    let albumType: String
    let artists: [Artist]
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name, releaseDate, releaseDatePrecision: String
    let totalTracks: Int
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String
}
