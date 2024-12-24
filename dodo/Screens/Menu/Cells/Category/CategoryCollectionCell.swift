//
//  CategoryCollectionCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 21.02.2024.
//

import UIKit
import SnapKit

class CategoryCollectionCell: UICollectionViewCell {
    static let reuseId = "CategoryCollectionCell"
    
    private var categoryLabel = CustomLabel.centerRegular15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with productSection: String) {
        categoryLabel.text = productSection.description
    }
    
    private func setupViews() {
        contentView.addSubview(categoryLabel)
        contentView.backgroundColor = Colors.white
        contentView.applyShadow(cornerRadius: 20)
        
        categoryLabel.numberOfLines = 1
    }
    
    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(8)
        }
    }
}
