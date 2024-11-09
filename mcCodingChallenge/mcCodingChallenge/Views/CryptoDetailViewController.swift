//
//  CryptoDetailViewController.swift
//  mcCodingChallenge
//
//  Created by Cliff on 8/11/2024.
//

import UIKit
import Combine
import DGCharts

class CryptoDetailViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    let viewModel: CryptoDetailViewModel!
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        
        stackView.addArrangedSubview(infoStackView)
        stackView.addArrangedSubview(priceLineChartView)
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
//        stackView.addArrangedSubview(UIView()) // Spacer view
        
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
//        stackView.addArrangedSubview(UIView()) // Spacer view
        
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
    
    lazy var priceLineChartView: LineChartView = {
        let chart = LineChartView()
        chart.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        chart.defaultSettings()
        
        chart.generateDataSet(for: [
            ChartDataEntry(x: 100, y: 300),
            ChartDataEntry(x: 200, y: 400),
            ChartDataEntry(x: 300, y: 500),
            ChartDataEntry(x: 400, y: 200),
            ChartDataEntry(x: 500, y: 305)
        ])
        
        return chart
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
        
        self.title = viewModel.title
        self.view.backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        // stack view constraints
        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])
        
        // Icon
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        // Line Chart
        NSLayoutConstraint.activate([
            priceLineChartView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
