//
//  AddToCartButton.swift
//  dodo
//
//  Created by Юлия Ястребова on 15.02.2024.
//

import UIKit
import SnapKit

final class CustomBigButton: UIView {
    
    var onBigButtonTapped: (()->())?
    
    var customBigtButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.backgroundColor = .orange
        button.setTitle("В корзину за 300 ₽", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(bigButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubview(customBigtButton)
    }
    
    private func setupConstraints() {
        customBigtButton.snp.makeConstraints { make in
            make.top.equalTo(self).inset(16)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).inset(46)
        }
    }
    
    @objc func bigButtonTapped(_ sender: UIButton) {
        onBigButtonTapped?()
    }
}
