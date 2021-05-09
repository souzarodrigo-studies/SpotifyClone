//
//  SearchViewController.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 28/04/21.
//

import SafariServices
import UIKit

class SearchViewController: UIViewController {

    let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsViewController())
        search.searchBar.placeholder = "Songs, Artists, Albums"
        search.searchBar.searchBarStyle = .minimal
        search.definesPresentationContext = true
        return search
    }()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ -> NSCollectionLayoutSection? in
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(150)
                    ),
                    subitem: item,
                    count: 2
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                
                return NSCollectionLayoutSection(group: group)
            }
        )
    )
    
    private var categories = [Category]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        
        APICaller.shared.getCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    
                    self?.categories = categories
                    self?.collectionView.reloadData()
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
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

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        resultController.delegate = self
        // perform Serch
        APICaller.shared.searchCategories(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    resultController.update(with: results)
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.row]
        let viewModel = CategoryCollectionViewCellViewModel(
            title: category.name,
            artworkURL: URL(string: category.icons.first?.url ?? "")
        )
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        let categoryView = CategoryViewController(category: category)
        categoryView.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(categoryView, animated: true)
    }
    
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    
    func showResult(_ result: SearchResult) {
        
        switch result {
        case .artist(let model):
            guard let url = URL(string: model.externalUrls.spotify) else { return }
            let safariScreen = SFSafariViewController(url: url)
            present(safariScreen, animated: true)
            
            break
        case .album(let model):
            let controller = AlbumViewController(album: model)
            controller.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(controller, animated: true)
            break
        case .track(let track):
            PlaybackPresenter.shared.startPlayback(from: self, track: track)
            break
        case .playlist(let model):
            let controller = PlaylistViewController(playlist: model)
            controller.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(controller, animated: true)
            break
        }
    }
    
    
}
