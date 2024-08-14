//
//  DetailCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 08.02.2024.
//

import UIKit
import SnapKit

final class ImageCell: UITableViewCell {
    
    var product: Product?
    
    static let reuseID = "DetailCell"
    
    private var verticalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: ScreenSize.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: ScreenSize.width).isActive = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProRounded-Bold", size: 15)
        return label
    }()
    
    private var weightLabel: UILabel = {
        var label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "SFProRounded-Regular", size: 15)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProRounded-Bold", size: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product?) {
        
        guard let product = product else { return }
        
        detailImageView.image = UIImage(named: product.image)
        nameLabel.text = product.name
        weightLabel.text = "\(product.weight) г."
        descriptionLabel.text = product.description
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(detailImageView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(weightLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
    }
}
