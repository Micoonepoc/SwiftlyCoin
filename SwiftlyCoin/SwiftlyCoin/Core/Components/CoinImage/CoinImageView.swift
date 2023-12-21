//
//  CoinImageView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 20.12.2023.
//

import SwiftUI


struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.colorTheme.secondaryText)
            }
        }
    }
}

struct CoinImagePreview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CoinImageView(coin: dev.coin)
                .toolbar(.hidden)
        }
        .environmentObject(dev.homeVM)
    }
}
