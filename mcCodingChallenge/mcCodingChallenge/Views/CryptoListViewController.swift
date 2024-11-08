//
//  CryptoListViewController.swift
//  mcCodingChallenge
//
//  Created by Cliff on 7/11/2024.
//

import UIKit
import Combine

final class CryptoListViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    let viewModel: CryptoListViewModel = CryptoListViewModel()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
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
        tableView.refreshControl = refreshControl
        
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
        viewModel.fetchData()
    }
    
    /// Begin observing the view models view state and act according to published values
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
                self?.displayError()
                self?.hideLoader()
                
            }
        }.store(in: &cancellables)
    }
    
    /// Setup constraints for the layout
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
    
    /// Show the loader
    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.loader.startAnimating()
        }
    }
    
    /// Hide the loader
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.loader.stopAnimating()
        }
    }
    
    /// Create and display a generic error message that retries on action
    func displayError() {
        let alert = UIAlertController(title: "Something went wrong",
                                      message: nil,
                                      preferredStyle: .alert)

        let action = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            self?.viewModel.fetchData()
        }
    
        alert.addAction(action)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    /// Triggers on pull down to fetch again
    @objc func refreshData() {
        viewModel.fetchData()
    }
}

// MARK: UITableViewDataSource

extension CryptoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the cell after selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

