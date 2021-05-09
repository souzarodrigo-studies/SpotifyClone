//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Rodrigo Santos on 28/04/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    private  let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondaryLabel
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.systemGroupedBackground, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Spotify"
        view.backgroundColor = .systemGreen
        
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signInButton.frame = CGRect(
            x: 20,
            y: view.height - 50 - view.safeAreaInsets.bottom,
            width: view.width - 40,
            height: 50
        )
    }
    
    @objc func didTapSignIn() {
        let authView = AuthViewController()
        
        authView.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        
        authView.navigationItem.largeTitleDisplayMode = .always
        navigationController?.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(authView, animated: true)
    }

    private func handleSignIn(success: Bool) {
        // Log users in or yell at then for error
        
        guard success else {
        
            let alert = UIAlertController(title: "Oops", message: "Something went wrong when signing in ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBar = TabBarViewController()
        mainAppTabBar.modalPresentationStyle = .fullScreen
        present(mainAppTabBar, animated: true)
            
        
    }
}

