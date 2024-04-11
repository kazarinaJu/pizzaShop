//
//  BannerCollectionCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 17.02.2024.
//

import UIKit
import SnapKit

final class BannerCollectionCell: UICollectionViewCell {
    
    var onPriceButtonTapped: ((Product)->())?
    private var product: Product?
    
    static let reuseId = "BannerCollectionCell"
    
    private var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hawaii")
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private var bannnerLabel: UILabel = {
        let label = UILabel()
        label.text = "Пепперони"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var bannerPriceButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("от 100 ₽", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = .orange.withAlphaComponent(0.2)
        button.layer.cornerRadius = 15
        button.setTitleColor(.brown, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.addTarget(nil, action: #selector(priceButtonTapped(_:)), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        self.product = product
        bannerImageView.image = UIImage(named: product.image)
        bannnerLabel.text = product.name
        bannerPriceButton.setTitle("от \(product.price) ₽", for: .normal)
    }
    
    @objc func priceButtonTapped(_ sender: UIButton) {
        guard let product else { return }
        onPriceButtonTapped?(product)
    }
    
    private func setupViews() {
        contentView.addSubview(bannerImageView)
        contentView.addSubview(bannnerLabel)
        contentView.addSubview(bannerPriceButton)
        
        contentView.backgroundColor = .white
        contentView.applyShadow(cornerRadius: 10)
    }
    
    private func setupConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(contentView).inset(8)
        }
        bannnerLabel.snp.makeConstraints { make in
            make.left.equalTo(bannerImageView.snp.right).offset(16)
            make.top.equalTo(contentView).inset(16)
        }
        bannerPriceButton.snp.makeConstraints { make in
            make.left.equalTo(bannerImageView.snp.right).offset(16)
            make.top.equalTo(bannnerLabel.snp.bottom).offset(16)
        }
    }
}
