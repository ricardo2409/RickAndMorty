//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/20/23.
//

import UIKit

/// VC to show details about a single episode
final class RMEpisodeDetailViewController: UIViewController {

    private let detailView = RMEpisodeDetailView()
    private let viewModel: RMEpisodeDetailViewViewModel
    //MARK: - Init
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        title = "Episode"
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    

    private func addConstraints(){
        NSLayoutConstraint.activate([
            
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func didTapShare() {
        
    }

}
