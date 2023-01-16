//
//  RmCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/16/23.
//

import Foundation
final class RmCharacterPhotoCollectionViewCellViewModel {
   
    private let imageUrl: URL?
    
    init(imageUrl: URL?){
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
