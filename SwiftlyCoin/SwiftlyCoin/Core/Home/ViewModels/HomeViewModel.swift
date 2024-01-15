import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portlofioCoins: [CoinModel] = []
    
    @Published var searchText = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = CoinDataService()
    
    init() {
        addSubscriber()
    }
    
     func addSubscriber() {
         $searchText
             .combineLatest(dataService.$allCoins)
             .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
             .map(filterCoins)
             .sink { [weak self] (returnedCoins) in
                 self?.allCoins = returnedCoins
             }
             .store(in: &cancellables)
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
