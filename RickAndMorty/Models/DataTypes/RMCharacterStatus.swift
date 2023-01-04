//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive:
            return rawValue
        case .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
