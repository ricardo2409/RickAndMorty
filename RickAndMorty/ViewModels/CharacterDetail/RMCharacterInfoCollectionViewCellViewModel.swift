//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/16/23.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    public let value: String
    public let title: String

    init(
        value: String,
        title: String
        ){
            self.value = value
            self.title = title
        }
}
