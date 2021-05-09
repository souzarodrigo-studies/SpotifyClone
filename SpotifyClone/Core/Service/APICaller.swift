//
//  APICaller.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 28/04/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    // MARK: - Album
    
    public func getAlbumDetails(
        for album: Album,
        completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/albums/" + album.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    // MARK: - Playlist
    
    public func getPlaylistDetails(
        for playlist: ItemPlaylist,
        completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    // MARK: - Track
    
//    public func getCurrentUserProfile(
//        completion: @escaping (Result<UserProfile, Error>) -> Void
//    )
    
    // MARK: - Profile
    
    public func getCurrentUserProfile(
        completion: @escaping (Result<UserProfile, Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/me"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - New Releases
    
    public func getNewReleases(
        completion: @escaping (Result<NewReleasesResponse, Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limite=50"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Featured Playlist
    
    public func getFeaturedPlaylists(
        completion: @escaping (Result<FeaturedPlaylistsResponse, Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limite=20"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Recommendations
    
    public func getRecommendations(
        genres: Set<String>,
        completion: @escaping (Result<RecommendationsResponse, Error>) -> Void
    ) {
        let seeds = genres.joined(separator: ",")
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/recommendations?seed_genres=\(seeds)"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Recommendations Genres
    
    public func getRecommendedGenres(
        completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Category
    
    public func getCategories(
        completion: @escaping (Result<[Category], Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/categories"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    completion(.success(result.categories.items))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getCategoriesPlaylists(
        category: Category,
        completion: @escaping (Result<[ItemPlaylist], Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(CategoryPlaylistsResponse.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Search
    
    public func searchCategories(
        with query: String,
        completion: @escaping (Result<[SearchResult], Error>) -> Void
    ) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    var searchResults = [SearchResult]()
                    
                    searchResults.append(contentsOf: result.tracks.items.compactMap({ .track(model: $0) }))
                    searchResults.append(contentsOf: result.albums.items.compactMap({ .album(model: $0) }))
                    searchResults.append(contentsOf: result.artists.items.compactMap({ .artist(model: $0) }))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({ .playlist(model: $0) }))
                    
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Private
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    enum APIError: Error {
        case faileedToGetData
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
