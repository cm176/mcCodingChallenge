//
//  CryptoServiceTests.swift
//  mcCodingChallengeTests
//
//  Created by Cliff on 8/11/2024.
//

import XCTest
import Combine
@testable import mcCodingChallenge

final class CryptoServiceTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    var cryptoService: CryptoService!
    var mockSession: MockURLSession!
    var mockCache: URLCache!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        mockCache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)
        cryptoService = CryptoService(session: mockSession, cache: mockCache)
    }

    override func tearDown() {
        cryptoService = nil
        mockSession = nil
        mockCache.removeAllCachedResponses()
        mockCache = nil
        super.tearDown()
    }
    
    /// Test that it successfully returns a crytpo list
    func testGetCryptoList_Success() {
        let mockData = cryptoMockJSON.data(using: .utf8)!
        mockSession.setMockData(mockData)
        mockSession.setMockResponse(HTTPURLResponse(url: URL(string: "https://api.coingecko.com/api/v3/coins/market")!,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)!)

        var fetchedCrypto: [Crypto]?
        let expectation = self.expectation(description: "Fetching crypto")

        cryptoService.getCryptoList().sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected Failure \(error.localizedDescription)")
            }
        } receiveValue: { result in
            fetchedCrypto = result
        }.store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertEqual(fetchedCrypto?.count, 5)
        XCTAssertEqual(fetchedCrypto?[0].name, "Bitcoin")
        XCTAssertEqual(fetchedCrypto?[1].name, "Ethereum")
        XCTAssertEqual(fetchedCrypto?[2].name, "Tether")
        XCTAssertEqual(fetchedCrypto?[3].name, "Solana")
        XCTAssertEqual(fetchedCrypto?[4].name, "BNB")
    }
    
    /// Tests that it succesfully returns and error on failure
    func testGetCryptoList_Failure() {
        let error = NSError(domain: "NetworkError", code: 400, userInfo: nil)
        mockSession.setMockError(error)

        var fetchedCrypto: [Crypto]?
        var fetchedError: Error?
        let expectation = self.expectation(description: "Fetching crypto")

        cryptoService.getCryptoList().sink { completion in
            switch completion {
            case .finished:
                XCTFail("Unexpected success")
            case .failure(let error):
                fetchedError = error
                expectation.fulfill()
            }
        } receiveValue: { result in
            fetchedCrypto = result
        }.store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertNil(fetchedCrypto)
        XCTAssertNotNil(fetchedError)
    }
    
    func testGetCryptoList_DecodingFailure() {
        let mockData = """
        [
            {"invalidField": "Invalid data"}
        ]
        """.data(using: .utf8)!
        mockSession.setMockData(mockData)
        mockSession.setMockResponse(HTTPURLResponse(url: URL(string: "https://api.coingecko.com/api/v3/coins/market")!,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)!)

        var fetchedCrypto: [Crypto]?
        var fetchedError: Error?
        let expectation = self.expectation(description: "Fetching crypto")

        cryptoService.getCryptoList().sink { completion in
            switch completion {
            case .finished:
                XCTFail("Unexpected success")
            case .failure(let error):
                fetchedError = error
                expectation.fulfill()
            }
        } receiveValue: { result in
            fetchedCrypto = result
        }.store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertNil(fetchedCrypto)
        XCTAssertNotNil(fetchedError)
    }
    
    /// Tests that it properly caches the API response
    func testUrlCache() {
        let mockData = cryptoMockJSON.data(using: .utf8)!
        let mockResponse = HTTPURLResponse(url: URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=5")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
        mockSession.setMockData(mockData)
        mockSession.setMockResponse(mockResponse)
        mockSession.cacheResponse(for: URLRequest(url: mockResponse.url!), data: cryptoSingleMockJSON.data(using: .utf8)!, response: mockResponse)


        var fetchedCrypto: [Crypto]?
        let expectation = self.expectation(description: "Fetching crypto")

        cryptoService.getCryptoList().sink { completion in
            switch completion {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected Failure \(error.localizedDescription)")
            }
        } receiveValue: { result in
            fetchedCrypto = result
        }.store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)

        XCTAssertEqual(fetchedCrypto?.count, 1)
        XCTAssertEqual(fetchedCrypto?[0].name, "Bitcoin")
    }
}
