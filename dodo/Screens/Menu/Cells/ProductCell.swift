//
//  ProductCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 27.01.2024.
//

import UIKit
import SnapKit

final class ProductCell: UITableViewCell {

    var onPriceButtonTapped: ((Product)->())? //1. declaration

    private var product: Product?
    
    static let reuseId = "ProductCell"
    
    private var containerView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.applyShadow(cornerRadius: 10)
        return view
    }()
    
    private var verticalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
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
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 0.40 * ScreenSize.width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.40 * ScreenSize.width).isActive = true
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
        onPriceButtonTapped?(product) //3. call
    }
}

extension ProductCell {
    
    private func setupViews() {
        selectionStyle = .none
    
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(detailLabel)
        verticalStackView.addArrangedSubview(priceButton)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(8)
        }
        
        productImageView.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(8)
            make.centerY.equalTo(containerView)
            make.top.bottom.greaterThanOrEqualTo(containerView).inset(8)
        }
        verticalStackView.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(containerView).inset(8)
            make.left.equalTo(productImageView.snp.right).offset(8)
        }
    }
}
