//
//  UrlCacheHelper.swift
//  mcCodingChallenge
//
//  Created by Cliff on 8/11/2024.
//

import Foundation

extension URLCache {
    
    /// Caches the response
    func cache(response: URLResponse, data: Data, request: URLRequest) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        self.storeCachedResponse(cachedResponse, for: request)
    }
    
    /// Fetches cached data if it exists and checks it has not yet expired
    func getCache(for request: URLRequest) -> Data? {
        // Set date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        
        guard let cachedResponse = cachedResponse(for: request),
               let response = cachedResponse.response as? HTTPURLResponse,
               let cachedDate = response.allHeaderFields["Date"] as? String,
               let responseDate = dateFormatter.date(from: cachedDate) else { return nil }
        
        // Check if 1 day has passed
        if Date().timeIntervalSince(responseDate) > TimeInterval(24 * 60 * 60) {
            // Cache expired, clear cache and return nil to allow it to re-fetch
            self.removeCachedResponse(for: request)
            return nil
        } else {
            // Cache still fresh, return cached data
            return cachedResponse.data
        }
    }
}
