//
//  Crypto.swift
//  mcCodingChallenge
//
//  Created by Cliff on 7/11/2024.
//

import Foundation

class Crypto: Decodable {
    let id: String
    let name: String
    let symbol: String
    let currentPrice: Decimal
    let imageUrl: String
    let priceChange: Decimal
    let priceChangePercent: Decimal
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case currentPrice = "current_price"
        case priceChange = "price_change_24h"
        case priceChangePercent = "price_change_percentage_24h"
        case imageUrl = "image"
    }
    
    init(id: String, name: String, symbol: String, currentPrice: Decimal, priceChange: Decimal, priceChangePercent: Decimal, imageUrl: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.currentPrice = currentPrice
        self.priceChange = priceChange
        self.priceChangePercent = priceChangePercent
        self.imageUrl = imageUrl
    }
}
