import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portlofioCoins: [CoinModel] = []
    
    @Published var isLoading: Bool = false
    
    @Published var searchText = ""
    
    @Published var statistics: [StatisticModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private let coinDataService = CoinDataService()
    
    init() {
        addSubscriber()
    }
    
     func addSubscriber() {
         $searchText
             .combineLatest(coinDataService.$allCoins)
             .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
             .map(filterCoins)
             .sink { [weak self] (returnedCoins) in
                 self?.allCoins = returnedCoins
             }
             .store(in: &cancellables)
         
         marketDataService.$marketData
             .map { (marketDataModel) -> [StatisticModel] in
                 
                 var stats: [StatisticModel] = []
                 
                 guard let data = marketDataModel else {
                     return stats
                 }
                 
                 let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentage: data.marketCapChangePercentage24HUsd)
                 let totalVolume = StatisticModel(title: "Total Volume", value: data.volume)
                 let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
                 let portfolioValue = StatisticModel(title: "Portfolio", value: "$0.00", percentage: 0)
                 
                 stats.append(contentsOf: [
                    marketCap,
                    totalVolume,
                    btcDominance,
                    portfolioValue
                 ])
                 return stats
             }
             .sink { [weak self] (returnedData) in
                 self?.statistics = returnedData
                 self?.isLoading = false
             }
             .store(in: &cancellables)
         
         $allCoins
             .combineLatest(portfolioDataService.$savedEntities)
             .map { (coinModels, portfolioEntities) -> [CoinModel] in
                 
                 coinModels
                     .compactMap { (coin) -> CoinModel? in
                         guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id}) else {
                             return nil
                         }
                         return coin.updateHoldings(amount: entity.amount)
                     }
             }
             .sink { [weak self] (returnedCoins) in
                 self?.portlofioCoins = returnedCoins
             }
             .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText)
        }
    }
    
}
