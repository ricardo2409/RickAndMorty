//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//

import UIKit
//////Controller to show and search Episodes

final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {

    
    private let episodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Episodes"
        
        view.addSubview(episodeListView)
        setUpView()
        addSearchButton()
    }
    
    private func addSearchButton () {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))

    }
    
    @objc private func didTapSearch() {
        
    }
    private func setUpView(){
        episodeListView.delegate = self
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    func rmEpisodeListView(_ characterListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        //Open detail controller for that episode
        let detailVC = RMEpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }


}
