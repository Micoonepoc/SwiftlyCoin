//
//  DetailView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 02.03.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailViewPreview: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
