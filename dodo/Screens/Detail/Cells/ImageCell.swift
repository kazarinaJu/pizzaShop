//
//  DetailCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 08.02.2024.
//

import UIKit
import SnapKit

final class ImageCell: UITableViewCell {
    
    var product: Product? {
            didSet {
                updateUI()
            }
        }
    
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
        imageView.image = UIImage(named: "default")
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: ScreenSize.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: ScreenSize.width).isActive = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Пепперони"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var weightLabel: UILabel = {
        var label = UILabel()
        label.text = "330 г."
        label.textColor = .gray
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Из печи, калорийно, вкусно, классно, в общем заебись"
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
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
