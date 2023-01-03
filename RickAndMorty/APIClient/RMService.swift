//
//  RMService.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//

import Foundation
/// Primary API service object to get Rick and Morty data
final class RMService {
    static let shared = RMService()
    
    private init() {}
    
    public func execute<T: Codable>(_ request: RMRequest,
                                    expecting type: T.Type,
                        completion: @escaping (Result<String, Error>) -> Void) {
        
    }
}
