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
    
    //UI
    lazy var loader: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        
        return loadingIndicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = viewModel
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: "CryptoTableViewCell")
        
        return tableView
    }()
    
    let viewModel: CryptoListViewModel = CryptoListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Crypto"
        self.view.backgroundColor = .white
        setupConstraints()
        bindViewState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupConstraints()
        loader.startAnimating()
    }
    
    
    func bindViewState() {
        viewModel.viewState.sink { [weak self] viewState in
            switch viewState {
            case .loading:
                print("loading")
                self?.loader.startAnimating()
                
            case .content:
                print("Display content")
                self?.tableView.reloadData()
//                self?.loader.stopAnimating()
                
                
            case .error:
                print("Display error")
                self?.loader.stopAnimating()
                
            }
        }.store(in: &cancellables)
    }
    
    func setupConstraints() {
        // Loader constraints
        
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        // Table view constraints
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

