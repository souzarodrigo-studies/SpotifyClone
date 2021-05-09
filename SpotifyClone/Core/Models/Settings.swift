//
//  Settings.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 29/04/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
