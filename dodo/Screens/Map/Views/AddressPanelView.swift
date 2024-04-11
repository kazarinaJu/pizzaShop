//
//  AddressPanelView.swift
//  dodo
//
//  Created by Юлия Ястребова on 03.04.2024.
//

import UIKit
import SnapKit

final class AddressPanelView: UIView {
    var addressView = AddressView()
    var saveButton = CustomBigButton()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ addressText: String) {
        addressView.addressTextField.text = addressText
    }
}

//MARK: - Layout
extension AddressPanelView {
    func setupViews() {
        saveButton.customBigtButton.setTitle("Сохранить", for: .normal)
        self.addSubview(stackView)
        stackView.addArrangedSubview(addressView)
        stackView.addArrangedSubview(saveButton)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
