//
//  AddressCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 17.02.2025.
//

import UIKit
import SnapKit

class AddressCell: UITableViewCell{
    
    static let reuseId = "AddressCell"
    
    private let addressName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        backgroundColor = .white
        contentView.backgroundColor = .white
        contentView.addSubview(addressName)
    }
    
    private func setupConstraints() {
        addressName.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    func update(_ address: String) {
        addressName.text = address
    }
}
