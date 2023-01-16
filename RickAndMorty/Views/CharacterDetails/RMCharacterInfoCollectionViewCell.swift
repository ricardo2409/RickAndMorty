//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/16/23.
//

import UIKit

class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints(){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel){
        
    }
}
