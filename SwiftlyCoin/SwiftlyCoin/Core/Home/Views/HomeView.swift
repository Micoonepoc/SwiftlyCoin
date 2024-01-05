//
//  HomeView.swift
//  SwiftlyCoin
//
//  Created by Михаил on 30.11.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.colorTheme.background
                .ignoresSafeArea()
                        
            VStack {
                HomeViewHeader
                
                SearchBarView(textFieldText: $vm.searchText)
                
               ColumnTitles
                
                if showPortfolio {
                    PortfolioRow
                        .transition(.move(edge: .trailing))
                }
                
                if !showPortfolio {
                    CoinsRow
                        .transition(.move(edge: .leading))
                }
                Spacer(minLength: 0)
            }
        }
    }
}

extension HomeView {
    
    private var HomeViewHeader: some View {
        HStack {
            CircleButtonView(imageName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(CircleButtonAnimationView(animate: $showPortfolio))

            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .animation(.none)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.colorTheme.accent)
            
            Spacer()

            CircleButtonView(imageName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
    
    private var CoinsRow: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var PortfolioRow: some View {
        List {
            ForEach(vm.portlofioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var ColumnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.colorTheme.secondaryText)
        .padding(.horizontal)
    }
    
}

struct HomeViewPreview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .toolbar(.hidden)
        }
        .environmentObject(dev.homeVM)
    }
}
