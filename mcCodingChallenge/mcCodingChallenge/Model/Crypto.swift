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
    let value: Double
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case symbol = "symbol"
        case value = "current_price"
        case imageUrl = "image"
    }
    
    init(name: String, symbol: String, value: Double, imageUrl: String) {
        self.name = name
        self.symbol = symbol
        self.value = value
        self.imageUrl = imageUrl
    }
}
