//
//  SearchResultResponse.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 06/05/21.
//

import Foundation

struct SearchResultResponse: Codable {
    let albums: SearchAlbumResponse
    let artists: SearchArtitstResponse
    let playlists: SearchPlaylistResponse
    let tracks: SearchTrackResponse
}

struct SearchAlbumResponse: Codable {
    let items: [Album]
}

struct SearchArtitstResponse: Codable {
    let items: [Artist]
}

struct SearchPlaylistResponse: Codable {
    let items: [ItemPlaylist]
}

struct SearchTrackResponse: Codable {
    let items: [AudioTrack]
}
