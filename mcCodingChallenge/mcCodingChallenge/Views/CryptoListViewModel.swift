//
//  CryptoListViewModel.swift
//  mcCodingChallenge
//
//  Created by Cliff on 7/11/2024.
//

import Foundation
import UIKit
import Combine


final class CryptoListViewModel: NSObject, UITableViewDataSource {
    var cancellables = Set<AnyCancellable>()
    enum CryptoListViewState {
        case loading
        case content
        case error
    }
    
    private(set) var viewState = CurrentValueSubject<CryptoListViewState, Never>(.loading)
    private(set) var cryptoList: [Crypto] = []
    private let cryptoService: CryptoServicing
    
    init(cryptoService: CryptoServicing = CryptoService()) {
        self.cryptoService = cryptoService
        
        super.init()
        
        fetchData()
    }
    
    private func fetchData() {
        cryptoService.getCryptoList().sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.viewState.send(.content)
            case .failure(_):
                self?.viewState.send(.error)
            }
        } receiveValue: { [weak self] list in
            self?.cryptoList = list
        }.store(in: &cancellables)
    }
    
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
