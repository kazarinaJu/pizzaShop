//
//  OrderDetailCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 27.02.2024.
//

import UIKit
import SnapKit

final class OrderDetailCell: UITableViewCell {
    
    static let reuseId = "OrderDetailCell"
    
    private var orderStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var countLabel = CustomLabel.leftRegular15
    private var orderPriceLabel = CustomLabel.rightRegular15
    private var coinLabel = CustomLabel.leftRegular15
    private var coinCountLabel = CustomLabel.rightRegular15
    private var deliveryLabel = CustomLabel.leftRegular15
    private var deliveryDetailLabel = CustomLabel.rightRegular15
    
    private var coinStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var deliveryStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var infoButtonContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private var infoButton: UIButton = {
        var button = UIButton(type: .system)
        let image = Images.infoCircle
        button.setImage(image, for: .normal)
        button.tintColor = Colors.black
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        setupContextMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ count: Int, _ price: Int) {
        selectionStyle = .none
        orderPriceLabel.text = "\(price)"
        countLabel.text = "\(count) товаров"
    }
    
    private func setupViews() {
        
        contentView.addSubview(orderStackView)
        orderStackView.addArrangedSubview(countLabel)
        orderStackView.addArrangedSubview(orderPriceLabel)
        
        contentView.addSubview(coinStackView)
        coinStackView.addArrangedSubview(coinLabel)
        coinStackView.addArrangedSubview(coinCountLabel)
        
        contentView.addSubview(deliveryStackView)
        deliveryStackView.addArrangedSubview(deliveryLabel)
        deliveryStackView.addArrangedSubview(infoButtonContainer)
        deliveryStackView.addArrangedSubview(deliveryDetailLabel)
        
        infoButtonContainer.addSubview(infoButton)
        
        coinLabel.text = Texts.Coins.title
        coinCountLabel.text = Texts.Coins.description
        deliveryLabel.text = Texts.Coins.delivery
        deliveryDetailLabel.text = Texts.Coins.deliveryPrice
    }
    
    private func setupConstraints() {
        orderStackView.snp.makeConstraints { make in
            make.top.right.left.equalTo(contentView).inset(20)
        }
        
        coinStackView.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(20)
            make.top.equalTo(orderStackView.snp.bottom).offset(16)
        }
        
        deliveryStackView.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(20)
            make.top.equalTo(coinStackView.snp.bottom).offset(16)
            make.bottom.equalTo(contentView).inset(20)
        }
        
        infoButton.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.left.equalTo(deliveryLabel.snp.right).offset(8)
        }
    }
}

extension OrderDetailCell: UIContextMenuInteractionDelegate {
    private func setupContextMenu() {
        let interaction = UIContextMenuInteraction(delegate: self)
        infoButton.addInteraction(interaction)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        print("Context menu interaction triggered")
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let action = UIAction(title: "Сумма заказа от 2000 р.") { _ in
                print("Action triggered")
            }
            return UIMenu(title: "Информация", children: [action])
        }
    }
}
