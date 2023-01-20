//
//  RmGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/20/23.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable{
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [RMEpisode]
}
