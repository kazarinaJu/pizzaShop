//
//  DetailCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 08.02.2024.
//

import UIKit
import SnapKit
import DodoNetworkLayer

protocol ImageCellDelegate: AnyObject {
    func showPopover(from sourceView: UIView)
}

final class ImageCell: UITableViewCell {
    
    var product: Product?
    weak var delegate: ImageCellDelegate?
    
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
        imageView.widthAnchor.constraint(equalToConstant: Layout.Detail.imageWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Layout.Detail.imageHeight).isActive = true
        return imageView
    }()
    
    private var detailStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var nameLabel = CustomLabel.centerRoundedBold22
    
    private var detailButton: UIButton = {
        var button = UIButton(type: .system)
        let image = Images.infoCircle
        button.setImage(image, for: .normal)
        button.tintColor = Colors.black
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.addTarget(self, action: #selector(showPopover(_:)), for: .touchUpInside)
        return button
    }()
    
    private var weightLabel = CustomLabel.centerRegular15
    private var descriptionLabel = CustomLabel.leftRoundedBold15
    
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
        nameLabel.text = product.name
        weightLabel.text = "\(product.weight) г."
        descriptionLabel.text = product.description
        
        if let url = URL.init(string: product.image) {
            detailImageView.kf.setImage(with: url, placeholder: UIImage(named: "default"))
        } else {
            detailImageView.image = UIImage(named: "default")
        }
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(detailImageView)
        
        verticalStackView.addArrangedSubview(detailStackView)
        detailStackView.addArrangedSubview(nameLabel)
        detailStackView.addArrangedSubview(detailButton)
        
        verticalStackView.addArrangedSubview(weightLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        
        weightLabel.textColor = Colors.gray
        descriptionLabel.textColor = Colors.gray
    }
    
    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
    }
    
    @objc func showPopover(_ sender: UIButton) {
        delegate?.showPopover(from: sender)
    }
}
