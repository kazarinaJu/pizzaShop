//
//  ProductPromoCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 08.08.2024.
//

import UIKit
import SnapKit

final class ProductPromoCell: UITableViewCell {
    
    var onPriceButtonTapped: ((Product)->())?

    private var product: Product?
    
    static let reuseId = "ProductPromoCell"
    
    private var verticalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var detailLabel: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var priceButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = .orange.withAlphaComponent(0.2)
        button.layer.cornerRadius = 15
        button.setTitleColor(.brown, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.addTarget(nil, action: #selector(priceButtonTapped(_:)), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return button
    }()
    
    private var productImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 0.8 * ScreenSize.width).isActive = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        self.product = product
        nameLabel.text = product.name
        detailLabel.text = product.detail
        priceButton.setTitle("от \(product.price) ₽", for: .normal)
        productImageView.image = UIImage(named: product.image)
    }
    
    @objc func priceButtonTapped(_ sender: UIButton) {
        guard let product else { return }
        onPriceButtonTapped?(product)
    }
}

extension ProductPromoCell {
    
    private func setupViews() {
        selectionStyle = .none
    
        contentView.addSubview(verticalStackView)
        contentView.addSubview(priceButton)
        verticalStackView.addArrangedSubview(productImageView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(detailLabel)
    }
    
    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.right.left.equalTo(contentView).inset(8)
        }
        
        priceButton.snp.makeConstraints { make in
            make.top.equalTo(verticalStackView.snp.bottom).inset(8)
            make.right.equalTo(contentView).inset(8)
            make.bottom.equalTo(contentView).inset(8)
        }
    }
}
