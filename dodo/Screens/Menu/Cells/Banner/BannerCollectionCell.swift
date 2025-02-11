//
//  BannerCollectionCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 17.02.2024.
//

import UIKit
import SnapKit
import DodoNetworkLayer
import Kingfisher

final class BannerCollectionCell: UICollectionViewCell {
    
    var onPriceButtonTapped: ((Product)->())?
    private var product: Product?
    
    static let reuseId = "BannerCollectionCell"
    
    private var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        return imageView
    }()
    
    private var bannerLabel = CustomLabel.leftRoundedBold15
    
    private var bannerPriceButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.titleLabel?.font = Fonts.proRoundedRegular15
        button.backgroundColor = Colors.orange.withAlphaComponent(0.2)
        button.layer.cornerRadius = 15
        button.setTitleColor(Colors.brown, for: .normal)
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
        //bannerImageView.image = UIImage(named: product.image)
        bannerLabel.text = product.name
        bannerPriceButton.setTitle("от \(product.price) ₽", for: .normal)
        
        //        let url = URL(string: "https://i.postimg.cc/GtZGw6q5/temp-Image-UEe31j.avif")
        //        bannerImageView.kf.setImage(with: url)
        
        if let url = URL.init(string: product.image) {
            bannerImageView.kf.setImage(with: url, placeholder: UIImage(named: "default"))
        } else {
            bannerImageView.image = UIImage(named: "default")
        }
    }
    
    @objc func priceButtonTapped(_ sender: UIButton) {
        guard let product else { return }
        onPriceButtonTapped?(product)
    }
    
    private func setupViews() {
        contentView.addSubview(bannerImageView)
        contentView.addSubview(bannerLabel)
        contentView.addSubview(bannerPriceButton)
        
        contentView.backgroundColor = Colors.white
        contentView.applyShadow(cornerRadius: 10)
        
        bannerLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(contentView).inset(8)
        }
        bannerLabel.snp.makeConstraints { make in
            make.left.equalTo(bannerImageView.snp.right).offset(16)
            make.top.equalTo(contentView).inset(16)
            make.right.equalTo(contentView).inset(8)
        }
        bannerPriceButton.snp.makeConstraints { make in
            make.left.equalTo(bannerImageView.snp.right).offset(16)
            make.top.equalTo(bannerLabel.snp.bottom).offset(16)
            make.bottom.lessThanOrEqualTo(contentView).inset(16)
        }
    }
}
