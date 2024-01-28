//
//  AddCoinImageView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 26.01.2024.
//

import SwiftUI

struct AddCoinImageView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.colorTheme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name.uppercased())
                .font(.caption2)
                .foregroundStyle(Color.colorTheme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct AddCoinImagePreview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddCoinImageView(coin: dev.coin)
        }
    }
}
