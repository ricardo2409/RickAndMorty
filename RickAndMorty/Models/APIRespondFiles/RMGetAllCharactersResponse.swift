//
//  RMGetCharactersResponse.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/3/23.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable{
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [RMCharacter]
}



