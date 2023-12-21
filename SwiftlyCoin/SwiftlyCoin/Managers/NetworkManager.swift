//
//  NetworkManager.swift
//  SwiftlyCoin
//
//  Created by Михаил on 15.12.2023.
//

import Foundation
import Combine

enum NetworkError: LocalizedError {
    case badURLResponse(url: URL)
    case uknownError
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(url: let url):
            return "❗️Bad responce from URL \(url)"
        case .uknownError:
            return "Unkown error"
        }
    }
}

class NetworkManager {
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap({ try handleURLRequest(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("error downloading \(error.localizedDescription)")
        }
    }
    
    static func handleURLRequest(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let responce = output.response as? HTTPURLResponse,
              responce.statusCode >= 200 && responce.statusCode < 300 else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }
    
}
