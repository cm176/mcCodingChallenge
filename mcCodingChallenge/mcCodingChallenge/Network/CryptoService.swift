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
    func getCryptoList() -> AnyPublisher<[Crypto], Error> {
        return Future<[Crypto], Error> { promise in
            promise(.success([Crypto(name: "Bitcoin", symbol: "BTC", value: "7,0000", imageUrl: "bleepbloop"),
                              Crypto(name: "Etherium", symbol: "ETH", value: "5,000", imageUrl: "bloopbleep")]))
        }.eraseToAnyPublisher()
    }
}

