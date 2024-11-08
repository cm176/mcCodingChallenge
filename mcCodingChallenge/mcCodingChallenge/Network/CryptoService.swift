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
    // Set this to your own API Key
    private let APIKey = "CG-98iTcqvHahg8nayMn9NZMJr2"
    private let session: URLSession
    private let cache: URLCache
    private let baseUrl: String

    init(session: URLSession = URLSession.shared, cache: URLCache = URLCache.shared, baseUrl: String = "https://api.coingecko.com/api/v3") {
        self.session = session
        self.cache = cache
        self.baseUrl = baseUrl
    }
    
    /// Fetch Crypto Currency list
    /// /coins/markets
    /// Params: vs_currecny = usd
    func getCryptoList() -> AnyPublisher<[Crypto], Error> {
        return Future<[Crypto], Error> { [weak self] promise in
            guard let self = self else { return }
            
            // Setup request
            if let url = URL(string: "\(baseUrl)/coins/markets?vs_currency=usd") {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("application/json", forHTTPHeaderField: "accept")
                request.addValue(APIKey, forHTTPHeaderField: "x-cg-demo-api-key")
                
                // Check if cached response exists
                if let data = cache.getCache(for: request) {
                    do {
                        // Decode and return
                        let list = try self.decodeJSON(data: data)
                        promise(.success(list))
                    } catch {
                        // Failed to decode
                        promise(.failure(error))
                    }
                } else {
                    // No cache, fetch the crypto
                    session.dataTask(with: request) { [weak self] data, response, error in
                        guard let self = self else { return }
                        
                        guard let data = data, let response = response, error == nil else {
                            print("Error fetching crypto: \(String(describing: error))")
                            promise(.failure(error ?? NSError(domain: "", code: 400, userInfo: nil)))
                            return
                        }
                        
                        do {
                            // Decode and return
                            let list = try self.decodeJSON(data: data)
                            
                            // Cache the response for future use
                            cache.cache(response: response, data: data, request: request)
                            
                            promise(.success(list))
                        } catch {
                            // Failed to decode
                            promise(.failure(error))
                        }
                    }.resume()
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// Decodes JSON response and returns Crypto Currency array
    private func decodeJSON(data: Data) throws -> [Crypto] {
        let decoder = JSONDecoder()
        let response = try decoder.decode([Crypto].self, from: data)
        return response
    }
}

