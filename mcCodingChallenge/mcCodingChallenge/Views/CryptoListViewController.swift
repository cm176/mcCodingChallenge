//
//  CryptoListViewController.swift
//  mcCodingChallenge
//
//  Created by Cliff on 7/11/2024.
//

import UIKit
import Combine

class CryptoListViewController: UIViewController, UITableViewDelegate {
    var cancellables = Set<AnyCancellable>()
    
    let viewModel: CryptoListViewModel = CryptoListViewModel()
    
    //UI
    lazy var loader: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        
        return loadingIndicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = viewModel
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: "CryptoTableViewCell")
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Crypto"
        self.view.backgroundColor = .white
        showLoader()
        setupConstraints()
        bindViewState()
        setupConstraints()
    }
    
    func bindViewState() {
        viewModel.viewState.sink { [weak self] viewState in
            switch viewState {
            case .loading:
                self?.showLoader()
                
            case .content:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                self?.hideLoader()
                
            case .error:
                self?.hideLoader()
                
            }
        }.store(in: &cancellables)
    }
    
    func setupConstraints() {
        // Table view constraints
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Loader constraints
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.loader.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.loader.stopAnimating()
        }
    }
}

