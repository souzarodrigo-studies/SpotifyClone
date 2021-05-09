//
//  PlaylistDetailsResponse.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 02/05/21.
//

import Foundation

// MARK: - PlaylistDetailsResponse
struct PlaylistDetailsResponse: Codable {
    let collaborative: Bool
    let playlistDetailsResponseDescription: String
    let externalUrls: ExternalUrls
    let followers: Followers
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let primaryColor: String?
    let playlistDetailsResponsePublic: Bool
    let snapshotID: String
    let tracks: PlaylistTracksResponse
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative
        case playlistDetailsResponseDescription = "description"
        case externalUrls = "external_urls"
        case followers, href, id, images, name, owner
        case primaryColor = "primary_color"
        case playlistDetailsResponsePublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - Tracks
struct PlaylistTracksResponse: Codable {
    let items: [ItemPlaylistTrack]
}

// MARK: - ItemPlaylist
struct ItemPlaylistTrack: Codable {
    //let addedAt: Date?
    let addedBy: Owner
    let isLocal: Bool
    let track: AudioTrack?

    enum CodingKeys: String, CodingKey {
        case addedBy = "added_by"
        case isLocal = "is_local"
        case track
    }
}

// MARK: - Track
struct Track: Codable {
    let album: Album
    let artists: [Owner]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let episode, explicit: Bool
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let popularity: Int
    let previewURL: String?
    let track: Bool?
    let trackNumber: Int
    let type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case episode, explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case track
        case trackNumber = "track_number"
        case type, uri
    }
}

