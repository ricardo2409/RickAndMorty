//
//  RMEndPoint.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//

import Foundation

@frozen enum RMEndPoint: String , Hashable, CaseIterable{
    case character // "character"
    case location
    case episode
}
