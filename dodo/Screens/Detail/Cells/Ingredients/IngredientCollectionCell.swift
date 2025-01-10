//
//  IngredientsCollectionCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 12.02.2024.
//

import UIKit
import SnapKit
import DodoNetworkLayer

final class IngredientCollectionCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCollectionCell"
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Colors.white
        containerView.applyShadow(cornerRadius: 20)
        return containerView
    }()
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = Colors.white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var nameLabel = CustomLabel.centerRegular15
    private var priceLabel = CustomLabel.centerRoundedBold15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ ingredient: Ingredient) {
        photoImageView.image = UIImage(named: ingredient.image)
        nameLabel.text = ingredient.name
        priceLabel.text = "\(ingredient.price)"
    }
    
   private  func setupViews() {
        contentView.backgroundColor = .clear
        self.backgroundView?.backgroundColor = .clear
        self.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(photoImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
       
       nameLabel.numberOfLines = 2
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(containerView).inset(4)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.left.right.equalTo(containerView)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(containerView)
        }
    }
}
