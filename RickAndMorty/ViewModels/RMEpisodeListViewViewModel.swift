//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/20/23.
//

import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didSelectEpisode(_ episode: RMEpisode)
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
}

final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
    private var isLoadingMoreEpisodes = false
    private let borderColors: [UIColor] = [
        .systemBlue,
        .systemGray,
        .systemGreen,
        .systemRed,
        .systemPurple,
        .systemYellow,
        .systemMint,
        .systemIndigo
    ]
    private var episodes: [RMEpisode] = [] {
        didSet {
            print("Creating ViewModels")
            for episode in episodes{
                let viewModel = RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: episode.url), borderColor: borderColors.randomElement() ?? .systemBlue)
                
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    
    /// Fetch initail set of episodes (20)
    public func fetchEpisodes() {
        RMService.shared.execute(.listEpisodesRequest, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.results
                let info = model.info
                self?.episodes = results
                self?.apiInfo = info
                //let info = model.info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()

                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    /// If aditional episodes needed
    public func fetchAditionalEpisodes(url: URL){
        // Fetch RMEpisodes
        guard !isLoadingMoreEpisodes else {
            return
        }
        isLoadingMoreEpisodes = true
        //print("Fetching more characters")

        guard let request = RMRequest(url: url) else {
            isLoadingMoreEpisodes = false
            print("Failed to create request")
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreresults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                let originalCount = strongSelf.episodes.count
                let newCount = moreresults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
                
                strongSelf.episodes.append(contentsOf: moreresults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreEpisodes(with: indexPathsToAdd)
                    
                    strongSelf.isLoadingMoreEpisodes = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreEpisodes = false

            }
        }
        
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
}

extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
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
        let width = (bounds.width - 20)
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selection = episodes[indexPath.row]
        delegate?.didSelectEpisode(selection)
    }
}

extension RMEpisodeListViewViewModel : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator, !isLoadingMoreEpisodes, !cellViewModels.isEmpty, let nextUrlString = apiInfo?.next, let url = URL(string: nextUrlString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {[weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            //100 is size of spinner
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                //At the bottom
                //Should fetch more
                self?.fetchAditionalEpisodes(url: url)
            }
            t.invalidate()
        }
    }
}
