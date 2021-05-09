//
//  HomeTabBarViewController.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 28/04/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configurationTabBar()
    }
    
    // MARK: - TAB Bar ( configuração )
    func configurationTabBar() {
        
        let home = HomeViewController()
        let search = SearchViewController()
        let library = LibraryViewController()
        
        home.title = "Browser"
        search.title = "Search"
        library.title = "Library"
        
        home.navigationItem.largeTitleDisplayMode = .always
        search.navigationItem.largeTitleDisplayMode = .always
        library.navigationItem.largeTitleDisplayMode = .always
        
        let navigationHome = UINavigationController(rootViewController: home)
        let navigationSearch = UINavigationController(rootViewController: search)
        let navigationLibrary = UINavigationController(rootViewController: library)
        
        navigationHome.navigationBar.tintColor = .label
        navigationSearch.navigationBar.tintColor = .label
        navigationLibrary.navigationBar.tintColor = .label
        
        navigationHome.tabBarItem = UITabBarItem(title: "Browser", image: UIImage(systemName: "house"), tag: 1)
        navigationSearch.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        navigationLibrary.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 1)
        
        navigationHome.navigationBar.prefersLargeTitles = true
        navigationSearch.navigationBar.prefersLargeTitles = true
        navigationLibrary.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navigationHome, navigationSearch, navigationLibrary], animated: true)
        
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
