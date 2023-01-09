//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/3/23.
//

import UIKit


protocol CharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ character: RMCharacter)
}

final class CharacterListViewViewModel: NSObject {
    
    public weak var delegate: CharacterListViewViewModelDelegate?
    private var isLoadingMoreCharacters = false
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
                cellViewModels.append(viewModel)

            }
        }
    }
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    /// Fetch initail set of characters (20)
    public func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.results
                let info = model.info
                self?.characters = results
                self?.apiInfo = info
                //let info = model.info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()

                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    /// If aditional characers needed
    public func fetchAditionalCharacters(){
        // Fetch Characters
        isLoadingMoreCharacters = true
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
}

extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsopported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsopported")
        }
        footer.startAnimatinng()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

extension CharacterListViewViewModel : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacters else {
            return
        }
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        //100 is size of spinner
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            //At the bottom
            //Should fetch more
            fetchAditionalCharacters()
        }
    }
}
