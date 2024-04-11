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
    
    private var leftVerticalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var countLabel: UILabel = {
        var label = UILabel()
        label.text = "1 товар"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private var coinLabel: UILabel = {
        var label = UILabel()
        label.text = "Начислим додокоинов"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private var deliveryLabel: UILabel = {
        var label = UILabel()
        label.text = "Доставка"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private var rightVerticalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .trailing
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private var orderPriceLabel: UILabel = {
        var label = UILabel()
        label.text = "990 ₽"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private var coinCountLabel: UILabel = {
        var label = UILabel()
        label.text = "+50"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private var deliveryDetailLabel: UILabel = {
        var label = UILabel()
        label.text = "Бесплатно"
        label.font = UIFont.systemFont(ofSize: 15)
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
    
    func update(_ count: Int, _ price: Int) {
        selectionStyle = .none
        orderPriceLabel.text = "\(price)"
        countLabel.text = "\(count) товаров"
    }
    
    private func setupViews() {
        contentView.addSubview(leftVerticalStackView)
        leftVerticalStackView.addArrangedSubview(countLabel)
        leftVerticalStackView.addArrangedSubview(coinLabel)
        leftVerticalStackView.addArrangedSubview(deliveryLabel)
        
        contentView.addSubview(rightVerticalStackView)
        rightVerticalStackView.addArrangedSubview(orderPriceLabel)
        rightVerticalStackView.addArrangedSubview(coinCountLabel)
        rightVerticalStackView.addArrangedSubview(deliveryDetailLabel)
    }
    private func setupConstraints() {
        leftVerticalStackView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(contentView).inset(8)
        }
        
        rightVerticalStackView.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(contentView).inset(8)
        }
    }
}
