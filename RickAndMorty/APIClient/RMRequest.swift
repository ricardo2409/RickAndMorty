//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//

import Foundation

final class RMRequest {
    //Base URl
    //Endpoint
    //Path component
    //Query parameters
    ///API constants
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    ///Desired endpoint
    private let endpoint: RMEndPoint
    /// Path components for API if any
    private let pathComponents: [String]
    /// Query arguments for the aPI if any
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue
        
        
        if !pathComponents.isEmpty{
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty{
            string += "?"
            //name = value&name=value
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        
        return string
    }
    /// Computed and constructed aPI url
    public var url: URL? {
        return URL(string: urlString)
    }
    public let httpMethod = "GET"
    

    init(endpoint: RMEndPoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
        
    }
    
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
