//
//  MockCryptoService.swift
//  mcCodingChallengeTests
//
//  Created by Gloomy on 8/11/2024.
//

import Foundation
import Combine
@testable import mcCodingChallenge

final class MockCryptoService: CryptoServicing {
    var shouldError = false

    func getCryptoList() -> AnyPublisher<[Crypto], any Error> {
        if self.shouldError {
            return Result.failure(NSError()).publisher.eraseToAnyPublisher()
        }
        
        
        return Result.success([Crypto(name: "CliffCoin", symbol: "CC", value: 100, imageUrl: "test"),
                               Crypto(name: "MasterCoin", symbol: "MC", value: 200, imageUrl: "testing")]).publisher.eraseToAnyPublisher()
    }
}
