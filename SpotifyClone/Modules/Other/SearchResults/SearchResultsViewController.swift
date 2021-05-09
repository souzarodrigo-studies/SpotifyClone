//
//  SearchResultsViewController.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 28/04/21.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func showResult(_ result: SearchResult)
}

class SearchResultsViewController: UIViewController {
    
    private var sections: [SearchSection] = []
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.register(SearchResultsDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultsDefaultTableViewCell.identifier)
        tableView.register(SearchResultsSubtitleTableViewCellTableViewCell.self, forCellReuseIdentifier: SearchResultsSubtitleTableViewCellTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with results: [SearchResult]) {
        let artists = results.filter({
            switch $0 {
            case .artist: return true
            default: return false
            }
        })
        
        let albums = results.filter({
            switch $0 {
            case .album: return true
            default: return false
            }
        })
        
        let tracks = results.filter({
            switch $0 {
            case .track: return true
            default: return false
            }
        })
        
        let playlists = results.filter({
            switch $0 {
            case .playlist: return true
            default: return false
            }
        })
        
        self.sections = [
            SearchSection(title: "Songs", results: tracks),
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Albums", results: albums),
        ]
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        
        
        switch result {
        case .track(let track):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsSubtitleTableViewCellTableViewCell.identifier, for: indexPath) as? SearchResultsSubtitleTableViewCellTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultsSubtitleTableViewCellTableViewCellViewModel(
                title: track.name,
                subTitle: track.artists.first?.name ?? "",
                imageURL: URL(string: track.album?.images.first?.url ?? "")
            )
            cell.configure(with: viewModel)
            return cell
        case .artist(let artist):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsDefaultTableViewCell.identifier, for: indexPath) as? SearchResultsDefaultTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultsDefaultTableViewCellViewModel(
                title: artist.name,
                imageURL: URL(string: artist.images?.first?.url ?? "")
            )
            cell.configure(with: viewModel)
            return cell
        case .album(let album):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsSubtitleTableViewCellTableViewCell.identifier, for: indexPath) as? SearchResultsSubtitleTableViewCellTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultsSubtitleTableViewCellTableViewCellViewModel(
                title: album.name,
                subTitle: album.artists.first?.name ?? "",
                imageURL: URL(string: album.images.first?.url ?? "")
            )
            cell.configure(with: viewModel)
            return cell
        case .playlist(let playlist):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsSubtitleTableViewCellTableViewCell.identifier, for: indexPath) as? SearchResultsSubtitleTableViewCellTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultsSubtitleTableViewCellTableViewCellViewModel(
                title: playlist.name,
                subTitle: playlist.owner.displayName ?? "",
                imageURL: URL(string: playlist.images.first?.url ?? "")
            )
            cell.configure(with: viewModel)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.showResult(result)
    }
    
}
