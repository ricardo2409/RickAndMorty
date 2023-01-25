//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/25/23.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactME
    case apiReference
    case viewCode
    
    var targetUrl : URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactME:
            return URL(string: "https://instagram.com/ricardo2409")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation/#introduction")
        case .viewCode:
            return URL(string: "https://github.com/ricardo2409")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactME:
            return "Contact Me"
        case .apiReference:
            return "API Reference"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactME:
            return .systemRed
        case .apiReference:
            return .systemPurple
        case .viewCode:
            return .systemPink
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactME:
            return UIImage(systemName: "paperplane")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
