//
//  EmptyCartVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 23.02.2024.
//

import UIKit
import SnapKit

final class EmptyCart: UIView {
    
    var onGoToMenuTapped: (() -> ())?
    
    private var emptyCartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.emptyCart
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 0.6 * ScreenSize.width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.6 * ScreenSize.width).isActive = true
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.configure(
            text: Texts.Cart.emptyCartTitle,
            font: Fonts.proRoundedBold22
        )
        return label
    }()
    
    private var descriptionLabel: CustomLabel = {
        let label = CustomLabel()
        label.configure(
            text: Texts.Cart.emptyCartDescription
        )
        return label
    }()
    
    private var priceLabel: CustomLabel = {
        let label = CustomLabel()
        label.configure(
            text: Texts.Cart.emptyCartPrice
        )
        return label
    }()
    
    private var goToMenuButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Перейти в меню", for: .normal)
        button.titleLabel?.font = Fonts.proRoundedRegular15
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(goToMenuButtonTapped), for: .touchUpInside)
        
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
    
    @objc private func goToMenuButtonTapped() {
        onGoToMenuTapped?()
    }

    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(emptyCartImageView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(priceLabel)
        self.addSubview(goToMenuButton)
    }
    
    private func setupConstraints() {
        emptyCartImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(160)
            make.centerX.equalTo(self)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyCartImageView.snp.bottom).offset(50)
            make.centerX.equalTo(self)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.centerX.equalTo(self)
        }
        goToMenuButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(15)
            make.left.right.equalTo(self).inset(50)
            make.centerX.equalTo(self)
        }
    }
}
