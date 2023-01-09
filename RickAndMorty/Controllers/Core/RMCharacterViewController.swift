//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//

import UIKit
///Controller to show and search Characters
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {

    
    private let characterListView = CharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        
        view.addSubview(characterListView)
        setUpView()
        
    }
    private func setUpView(){
        characterListView.delegate = self
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    func rmCharacterListView(_ characterListView: CharacterListView, didSelectCharacter character: RMCharacter) {
        //Open detail controller for that character
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
