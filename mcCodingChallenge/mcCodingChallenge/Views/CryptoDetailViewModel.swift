//
//  CryptoDetailViewModel.swift
//  mcCodingChallenge
//
//  Created by Cliff on 8/11/2024.
//

import Foundation
import UIKit
import Combine

final class CryptoDetailViewModel {
    var cancellables = Set<AnyCancellable>()
    private let crypto: Crypto
    
    // UI
    var title: String { crypto.name }
    var symbol: String { crypto.symbol }
    var price: String { "\(NumberFormatter().formatMoney(amount: crypto.currentPrice))" }
    var priceChange: String { "\(NumberFormatter().formatMoney(amount: crypto.priceChange))" }
    var priceChangePercent: String { "\(crypto.priceChangePercent)%" }
    var priceChangeColor: UIColor { crypto.priceChange < 0 ? .red : .systemGreen }
    var iconUrl: String { crypto.imageUrl }
    var today: String { "Today" }
    
    init(crypto: Crypto) {
        self.crypto = crypto
    }
}
