//
//  RMSettingView.swift
//  RickAndMorty
//
//  Created by Ricardo Trevino on 1/25/23.
//

import SwiftUI

struct RMSettingView: View {
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        List(viewModel.cellViewModels){ viewModel in
            HStack{
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                        .padding(8)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(6)
                }
                
                Text(viewModel.title)
                    .padding(.leading, 10)
                Spacer() //For clicking anywhere on the cell
            }
            .padding(.bottom, 3)
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
            
        }
    }
}

struct RMSettingView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0) {option in
                
            }
        })))
    }
}
