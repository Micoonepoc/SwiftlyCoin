//
//  HomeViewModel.swift
//  SwiftlyCoin
//
//  Created by Михаил on 09.12.2023.
//

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
         dataService.$allCoins
             .sink { [weak self] (returnedCoins) in
                 self?.allCoins = returnedCoins
             }
             .store(in: &cancellables)
    }
    
}
