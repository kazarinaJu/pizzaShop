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
        imageView.image = UIImage(named: "emptyCart")
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 0.6 * ScreenSize.width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.6 * ScreenSize.width).isActive = true
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Пока тут пусто"
        label.font = UIFont(name: "SFProRounded-Bold", size: 22)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Добавьте пиццу. Или две!"
        label.font = UIFont(name: "SFProRounded-Regular", size: 15)
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "А мы  доставим заказ от 599 ₽"
        label.font = UIFont(name: "SFProRounded-Regular", size: 15)
        return label
    }()
    
    private var goToMenuButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Перейти в меню", for: .normal)
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
