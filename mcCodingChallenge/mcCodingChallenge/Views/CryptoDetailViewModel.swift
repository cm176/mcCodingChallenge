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
    
    enum CryptoDetailViewState {
        case loading
        case content
        case error
    }
    
    private(set) var viewState = PassthroughSubject<CryptoDetailViewState, Never>()
    private let cryptoService: CryptoServicing
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
    
    init(crypto: Crypto, cryptoSerivce: CryptoServicing = CryptoService()) {
        self.crypto = crypto
        self.cryptoService = cryptoSerivce
    }
    
    func fetchData() {
        cryptoService.getCryptoChart(for: crypto.id).sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.viewState.send(.content)
                
            case .failure(let error):
                self?.viewState.send(.error)
            }
        } receiveValue: { chartData in
            print(chartData)
        }.store(in: &cancellables)
    }
}
