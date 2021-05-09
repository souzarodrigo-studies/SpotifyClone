//
//  PlaybackPresenter.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 07/05/21.
//

import Foundation
import AVKit
import UIKit

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
     
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let player = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }
        
        return nil
    }
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    private var playerViewController: PlayerViewController?
    
    func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        guard let url = URL(string: track.previewURL ?? "") else {
            print("Name of track: \(track.name)")
            print("Preview URL is nil")
            return
            
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        self.track = track
        self.tracks = []
        let playerView = PlayerViewController()
        playerView.title = track.name
        playerView.dataSource = self
        playerView.delegate = self
        viewController.present(UINavigationController(rootViewController: playerView), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerViewController = playerView
    }
    
    func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        
        self.track = nil
        self.tracks = tracks
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.previewURL ?? "") else {
                return nil
            }
            
            return AVPlayerItem(url: url)
        }))
        self.playerQueue?.volume = 0
        self.playerQueue?.play()
        
        let playerView = PlayerViewController()
        playerView.title = tracks.first?.name
        playerView.dataSource = self
        playerView.delegate = self
        viewController.present(UINavigationController(rootViewController: playerView), animated: true) { [weak self] in
            self?.player?.play()
        }
    }
        
}

extension PlaybackPresenter: PlayerViewControllerDelegate {
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        } else if let player = playerQueue {
            player.advanceToNextItem()
            index += 1
            print(index)
            playerViewController?.refreshUI()
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            player?.pause()
            player?.play()
        } else if let firstItem = playerQueue?.items().first {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 0
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
//        print(currentTrack)
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}
