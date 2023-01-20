//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/20/23.
//

import UIKit

class RMEpisodeDetailViewViewModel {
    
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?){
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    //Once it was created
    
    private func fetchEpisodeData() {
        guard let url = endpointUrl,  let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                break
            }
        }
    }
}
