//
//  CryptoChart.swift
//  mcCodingChallenge
//
//  Created by Cliff on 9/11/2024.
//

import Foundation

class CryptoChart: Decodable {
    var prices: [[Decimal]]
    
    init(prices: [[Decimal]]) {
        self.prices = prices
    }
}
