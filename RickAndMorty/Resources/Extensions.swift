//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/3/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}
