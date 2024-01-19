//
//  MarketDataService.swift
//  SwiftlyCoin
//
//  Created by Михаил on 19.01.2024.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketSubscription?.cancel()
            })
    }
}

