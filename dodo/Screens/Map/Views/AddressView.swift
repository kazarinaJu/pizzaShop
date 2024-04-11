//
//  AddressView.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.04.2024.
//

import UIKit
import SnapKit

final class AddressView: UIView {
    
    private var discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Город, улица и дом"
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        return label
    }()
    
    var addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш адрес"
        textField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        
        stack.layer.borderWidth = 2
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.cornerRadius = 16
        
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(discriptionLabel)
        stackView.addArrangedSubview(addressTextField)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
}
