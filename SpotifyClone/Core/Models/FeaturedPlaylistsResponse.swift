//
//  FeaturedPlaylists.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 29/04/21.
//

import Foundation

// MARK: - FeaturedPlaylists
struct FeaturedPlaylistsResponse: Codable {
    let message: String
    let playlists: PlaylistResponse
}

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

// MARK: - Playlists
struct PlaylistResponse: Codable {
    let items: [ItemPlaylist]
}

// MARK: - ItemPlaylist
struct ItemPlaylist: Codable {
    let collaborative: Bool
    let itemDescription: String
    let externalUrls: [String: String]
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let snapshotID: String
    let tracks: Tracks
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative
        case itemDescription = "description"
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
    
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String?
    let externalUrls: ExternalUrls
    let href: String
    let id, type, uri: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, type, uri
        case name
    }
}


// MARK: - Tracks
struct Tracks: Codable {
    let href: String
    let total: Int
}
