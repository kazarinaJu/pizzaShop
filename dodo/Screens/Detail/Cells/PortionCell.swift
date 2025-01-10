//
//  PorcionCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 08.02.2024.
//

import UIKit
import SnapKit
import DodoNetworkLayer

final class PortionCell: UITableViewCell {
    
    var product: Product? {
        didSet {
            update(product)
        }
    }
    
    static let reuseID = "PortionCell"
    private var portionLabel = CustomLabel.centerRegular15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(portionLabel)
        
        portionLabel.backgroundColor = Colors.lightGray
        portionLabel.layer.cornerRadius = 8
        portionLabel.clipsToBounds = true
        portionLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupConstraints() {
        portionLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView).inset(16)
        }
    }
}

extension PortionCell {
    func update(_ product: Product?) {
        guard let product = product else { return }
        portionLabel.text = "\(product.portion ?? 0) шт."
    }
}
