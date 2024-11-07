//
//  Crypto.swift
//  mcCodingChallenge
//
//  Created by Cliff on 7/11/2024.
//

import Foundation

class Crypto: Decodable {
    let name: String
    let symbol: String
    let value: String
    let imageUrl: String
    
    init(name: String, symbol: String, value: String, imageUrl: String) {
        self.name = name
        self.symbol = symbol
        self.value = value
        self.imageUrl = imageUrl
    }
}
