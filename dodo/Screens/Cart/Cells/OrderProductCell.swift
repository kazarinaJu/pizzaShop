//
//  CartProductCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 26.02.2024.
//

import UIKit
import SnapKit

final class OrderProductCell: UITableViewCell {
    
    var onProductCountChanged : ((Product) -> ())?
   
    private var product: Product?
    static let reuseId = "OrderProductCell"
    private lazy var stepperView = CustomStepper()
    
    private var horizontalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var productImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 0.20 * ScreenSize.width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.20 * ScreenSize.width).isActive = true
        return imageView
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
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private var priceStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var priceLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        setupStepper()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        self.product = product
        
        productImageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        detailLabel.text = "\(product.size ?? ""), \(product.dough ?? "")"
        stepperView.currentValue = product.count
        priceLabel.text = String(product.price * product.count)
    }
    
    private func setupStepper() {
        stepperView.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)
    }
    
    @objc private func stepperChangedValueAction(_ sender: CustomStepper) {
        self.product?.count = sender.currentValue
        guard let product = product else { return }
        onProductCountChanged?(product)
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(productImageView)
        horizontalStackView.addArrangedSubview(nameLabel)
        horizontalStackView.addArrangedSubview(detailLabel)
        
        contentView.addSubview(priceStackView)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(stepperView)
        
    }
    
    private func setupConstraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(8)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(horizontalStackView).inset(8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.top.equalTo(horizontalStackView).inset(16)
            make.right.equalTo(horizontalStackView)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.right.equalTo(horizontalStackView)
            make.bottom.equalTo(horizontalStackView.snp.bottom).inset(8)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(8)
            make.left.right.bottom.equalTo(contentView).inset(8)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(priceStackView).inset(8)
            make.left.equalTo(priceStackView).inset(20)
        }
        stepperView.snp.makeConstraints { make in
            make.top.bottom.equalTo(priceStackView).inset(8)
            make.width.equalTo(110)
            make.height.equalTo(30)

        }
    }
}
