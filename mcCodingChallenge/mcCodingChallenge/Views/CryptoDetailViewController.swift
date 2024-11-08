//
//  CryptoDetailViewController.swift
//  mcCodingChallenge
//
//  Created by Cliff on 8/11/2024.
//

import UIKit
import Combine

class CryptoDetailViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    let viewModel: CryptoDetailViewModel!
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 8
        
        stackView.addArrangedSubview(infoStackView)
        stackView.addArrangedSubview(UIView()) // Spacer view
        
        return stackView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        stackView.addArrangedSubview(priceStackView)
        stackView.addArrangedSubview(UIView()) // Spacer view
        stackView.addArrangedSubview(iconImageView)
        
        return stackView
    }()
    
    lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        stackView.addArrangedSubview(currentPriceLabel)
        stackView.addArrangedSubview(priceChangeStackView)
        stackView.addArrangedSubview(UIView())
        
        return stackView
    }()
    
    lazy var priceChangeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        stackView.addArrangedSubview(priceChangeLabel)
        stackView.addArrangedSubview(priceChangePercentLabel)
        stackView.addArrangedSubview(todayLabel)
        stackView.addArrangedSubview(UIView())
        
        return stackView
    }()
    
    lazy var currentPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = viewModel.price
        
        return label
    }()
    
    lazy var priceChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = viewModel.priceChange
        label.textColor = viewModel.priceChangeColor
        
        return label
    }()
    
    lazy var priceChangePercentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = viewModel.priceChangePercent
        label.textColor = viewModel.priceChangeColor
        
        return label
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = viewModel.today
        label.textColor = .gray
        
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.fetch(viewModel.iconUrl)
        
        return imageView
    }()
    
    init(viewModel: CryptoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        self.title = viewModel.title
        self.view.backgroundColor = .white
        
        // stack view constraints
        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Icon
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
