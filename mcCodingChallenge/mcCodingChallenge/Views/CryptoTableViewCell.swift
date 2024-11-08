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
        stackView.spacing = 8
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(UIView()) // Spacer view
        stackView.addArrangedSubview(valueLabel)
        
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
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(_ crypto: Crypto) {
        setupConstraints()
        fetch(crypto.imageUrl)
        nameLabel.text = crypto.name
        symbolLabel.text = crypto.symbol
        valueLabel.text = "$\(crypto.value)"
    }
    
    func setupConstraints() {
        
        // Stack view
        contentView.addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 16),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ])
        
    }
    
    func fetch(_ imageUrl: String) {
        if let cachedImage = ImageCache.shared.getImage(for: imageUrl) {
            // Use Cached Image
            iconImageView.image = cachedImage
        } else {
            // Fetch Image
            if let url = URL(string: imageUrl) {
                URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    // Check for errors
                    guard let data = data, error == nil else {
                        print("Error loading image: \(String(describing: error))")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            self?.iconImageView.image = image
                            ImageCache.shared.cache(image, for: imageUrl)
                        } else {
                            print("Failed to create image from data")
                        }
                    }
                }.resume() // Start the task
            }
        }
    }
}
