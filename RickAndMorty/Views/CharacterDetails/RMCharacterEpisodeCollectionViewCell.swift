//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/16/23.
//

import UIKit

class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints(){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel){
        
    }
}
