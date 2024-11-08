//
//  CryptoTableViewCell.swift
//  mcCodingChallenge
//
//  Created by Cliff on 7/11/2024.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 8
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(UIView()) // Spacer view
        stackView.addArrangedSubview(priceLabel)
        
        return stackView
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(symbolLabel)
        stackView.addArrangedSubview(UIView())
        
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ crypto: Crypto) {
        iconImageView.fetch(crypto.imageUrl)
        nameLabel.text = crypto.name
        symbolLabel.text = crypto.symbol
        priceLabel.text = "\(NumberFormatter().formatMoney(amount: crypto.currentPrice))"
    }
    
    func setupConstraints() {
        
        // Stack view
        contentView.addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        // Icon
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}
