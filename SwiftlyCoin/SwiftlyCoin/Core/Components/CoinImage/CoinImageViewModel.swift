//
//  CoinImageViewModel.swift
//  SwiftlyCoin
//
//  Created by Михаил on 20.12.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    private let imageService: CoinImageService
    private let coin: CoinModel
    private var cancellabels = Set<AnyCancellable>()
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageService = CoinImageService(coin: coin)
        addSubscriber()
        isLoading = true
    }
    
    func addSubscriber() {
        imageService.$image
            .sink { [weak self](_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellabels)

    }
    
}
