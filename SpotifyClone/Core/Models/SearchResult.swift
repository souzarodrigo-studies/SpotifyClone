//
//  SearchResult.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 06/05/21.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: ItemPlaylist)
    case track(model: AudioTrack)
}
