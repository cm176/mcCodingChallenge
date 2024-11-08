//
//  MockUrlService.swift
//  mcCodingChallengeTests
//
//  Created by Cliff on 8/11/2024.
//

import Foundation

class MockURLSession: URLSession {
    var mockCache: [URL: CachedURLResponse] = [:]
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        // Return cached data if it exists
        if let cachedResponse = mockCache[request.url!] {
            completionHandler(cachedResponse.data, cachedResponse.response, nil)
        } else {
            // Otherwise, simulate a network request
            completionHandler(mockData, mockResponse, mockError)
        }
        return MockDataTask()
    }
    
    func cacheResponse(for request: URLRequest, data: Data, response: URLResponse) {
        mockCache[request.url!] = CachedURLResponse(response: response, data: data)
    }

    func setMockData(_ data: Data) {
        self.mockData = data
    }

    func setMockError(_ error: Error) {
        self.mockError = error
    }

    func setMockResponse(_ response: URLResponse) {
        self.mockResponse = response
    }
}
