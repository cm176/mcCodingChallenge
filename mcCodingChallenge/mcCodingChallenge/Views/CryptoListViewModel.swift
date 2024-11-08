//
//  CryptoListViewModel.swift
//  mcCodingChallenge
//
//  Created by Cliff on 7/11/2024.
//

import Foundation
import UIKit
import Combine


final class CryptoListViewModel: NSObject {
    var cancellables = Set<AnyCancellable>()
    
    enum CryptoListViewState {
        case loading
        case content
        case detail(Crypto)
        case error
    }
    
    private(set) var viewState = PassthroughSubject<CryptoListViewState, Never>()
    private(set) var cryptoList: [Crypto] = []
    private let cryptoService: CryptoServicing
    let title = "Crypto"
    
    init(cryptoService: CryptoServicing = CryptoService()) {
        self.cryptoService = cryptoService
        
        super.init()
    }
    
    /// Fetch data from service and publish view state accordingly
    func fetchData() {
        viewState.send(.loading)
        cryptoService.getCryptoList().sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.viewState.send(.content)
            case .failure(_):
                self?.viewState.send(.error)
            }
        } receiveValue: { [weak self] list in
            self?.cryptoList = list
            self?.sortCrypto()
        }.store(in: &cancellables)
    }
    
    private func sortCrypto() {
        cryptoList.sort { $0.currentPrice > $1.currentPrice }
        cryptoList = Array(cryptoList.prefix(5))
    }
}

// MARK: UITableViewDataSource

extension CryptoListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let crypto = cryptoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoTableViewCell", for: indexPath) as! CryptoTableViewCell
        cell.bind(crypto)
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension CryptoListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the cell after selection
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCrypto = cryptoList[indexPath.row]

        // navigate forward
        viewState.send(.detail(selectedCrypto))
    }
}
