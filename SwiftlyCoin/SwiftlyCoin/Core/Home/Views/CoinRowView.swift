import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
            
            
        }
        .font(.subheadline)
    }
}

struct CoinViewPreview: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack {
            Text("\(coin.rank)")
                .foregroundStyle(Color.colorTheme.secondaryText)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .bold()
        }
        .padding(.horizontal)
    }
    
    private var centerColumn: some View {
        HStack {
            if showHoldingsColumn {
                VStack(alignment: .trailing) {
                    Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                        .bold()
                    Text(coin.currentHoldings?.asNumberString() ?? "\(0)")
                }
                .foregroundStyle(Color.colorTheme.accent)
            }
        }
    }
    
    private var rightColumn: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                Text(coin.priceChangePercentage24H?.asStringPercent() ?? "0.00%")
                    .foregroundStyle((coin.priceChange24H ?? 0) >= 0 ? Color.colorTheme.green : Color.colorTheme.red )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .padding(.horizontal)
    }
    
}
