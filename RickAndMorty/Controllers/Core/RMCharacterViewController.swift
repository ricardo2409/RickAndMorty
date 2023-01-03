//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//

import UIKit
///Controller to show and search Characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RMRequest(endpoint: .character, pathComponents: ["1"], queryParameters: [URLQueryItem(name: "name", value: "rick"), URLQueryItem(name: "status", value: "alive")])
        print(request.url)
    }
    



}
