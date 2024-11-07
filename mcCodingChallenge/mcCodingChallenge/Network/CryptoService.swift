//
//  CryptoService.swift
//  mcCodingChallenge
//
//  Created by Cliff on 7/11/2024.
//

import Foundation
import Combine


protocol CryptoServicing {
    func getCryptoList() -> AnyPublisher<[Crypto], Error>
}

final class CryptoService: CryptoServicing {
    let baseUrl = "https://api.coingecko.com/api/v3"
    let APIKey = "CG-98iTcqvHahg8nayMn9NZMJr2"
    
    // hit the /coins/markets API
    func getCryptoList() -> AnyPublisher<[Crypto], Error> {
        return Future<[Crypto], Error> { [weak self] promise in
            guard let self = self else { return }
            
            if let url = URL(string: "\(baseUrl)/coins/markets?vs_currency=usd&order=current_price_desc&per_page=10") {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "accept")
                request.addValue(APIKey, forHTTPHeaderField: "x-cg-demo-api-key")
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Error fetching crypto: \(String(describing: error))")
                        promise(.failure(error!))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode([Crypto].self, from: data)
                        print(response)
                        promise(.success(response))
                    } catch {
                        print(error.localizedDescription)
                    }
                }.resume()
            }
        }.eraseToAnyPublisher()
        
    }
}

