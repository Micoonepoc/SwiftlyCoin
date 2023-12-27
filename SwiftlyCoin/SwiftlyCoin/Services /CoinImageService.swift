//
//  CoinImageService.swift
//  SwiftlyCoin
//
//  Created by Михаил on 20.12.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let localFileManager = LocalFileManager.shared
    private let coinImageName: String
    private let folderName = "swiflycoin_images"
    
    init(coin: CoinModel) {
        self.coin = coin
        coinImageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = localFileManager.getImage(imageName: coinImageName, folderName: folderName) {
            image = savedImage
            print("Getting image from file manager!")
        } else {
            downloadCoinImage()
            print("Downloading image")
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
            imageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedImages) in
                guard let self = self, let downloadedImages = returnedImages else { return }
                self.image = downloadedImages
                self.imageSubscription?.cancel()
                self.localFileManager.saveImages(image: downloadedImages, imageName: self.coinImageName, folderName: self.folderName)
            })
    }
    
}
