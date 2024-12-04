//
//  PriceHeaderView.swift
//  dodo
//
//  Created by Юлия Ястребова on 27.02.2024.
//

import UIKit

final class PriceHeaderView: UIView {
    
    private var products: [Product]?
    
    lazy var priceLabel: CustomLabel = {
        let label = CustomLabel()
        label.configure(
            font: Fonts.proRoundedBold15,
            textAlignment: .left
        )
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(40)
            make.left.right.bottom.equalTo(self).inset(20)
        }
    }
    
}
