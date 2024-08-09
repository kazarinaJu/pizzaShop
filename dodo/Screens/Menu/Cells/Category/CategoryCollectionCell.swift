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
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
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
    
    func update(with productSection: String) {
        categoryLabel.text = productSection.description
    }
    
    private func setupViews() {
        contentView.addSubview(categoryLabel)
        contentView.backgroundColor = .white
        contentView.applyShadow(cornerRadius: 20)
    }
    
    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(8)
        }
    }
}
