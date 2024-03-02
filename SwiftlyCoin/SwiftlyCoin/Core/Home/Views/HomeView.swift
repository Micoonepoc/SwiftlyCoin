import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State var showPortfolio: Bool = false
    @State var showAddCoin: Bool = false
    @State var selectedCoin: CoinModel? = nil
    @State var showDetails: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.colorTheme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showAddCoin, content: {
                    AddCoinView()
                        .environmentObject(vm)
                })
                        
            VStack {
                HomeViewHeader
                
                HomeStatisticView(showPortfolio: $showPortfolio)
                
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
        .navigationDestination(isPresented: $showDetails) {
            DetailLoadingView(coin: $selectedCoin)
        }
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetails.toggle()
    }
}

extension HomeView {
    
    private var HomeViewHeader: some View {
        HStack {
            CircleButtonView(imageName: showPortfolio ? "plus" : "info")
                .onTapGesture {
                    if showPortfolio {
                        showAddCoin.toggle()
                    }
                }
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
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .refreshable {
            print("refreshing coin list")
            vm.reloadData()
        }
        .listStyle(PlainListStyle())
    }
    
    private var PortfolioRow: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .refreshable {
            print("refresh portfolio list")
            vm.reloadData()
        }
        .listStyle(PlainListStyle())
    }
    
    private var ColumnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0: 180))
            }
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                    }
                }
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


