//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//

import UIKit
//////Controller to show and search Locations

final class RMLocationViewController: UIViewController, RMLocationViewViewModelDelegate {

    private let primaryView = RmLocationView()
    
    private let viewModel = RMLocationViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        title = "Locations"
        addSearchButton()
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    private func addSearchButton () {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))

    }
    
    
    @objc private func didTapSearch() {
        
    }
    
    
    //MARK: - LocationViewModel Delegate
    
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}
