//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/2/23.
//
import StoreKit
import SafariServices
import SwiftUI
import UIKit
///Controller for settings

final class RMSettingsViewController: UIViewController {
   
    
    private var settingsSwiftUIController: UIHostingController<RMSettingView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(rootView: RMSettingView(viewModel: RMSettingsViewViewModel(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0) {[weak self] option in
                self?.handleTap(option: option)
            }
        }))))
        
        addChild(settingsSwiftUIController)
        
        settingsSwiftUIController.didMove(toParent: self)
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetUrl {
            //open website
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }else if option == .rateApp {
            //open prompt
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
    
}
