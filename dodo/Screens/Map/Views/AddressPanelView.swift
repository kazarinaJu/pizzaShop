//
//  AddressPanelView.swift
//  dodo
//
//  Created by Юлия Ястребова on 03.04.2024.
//

import UIKit
import SnapKit

final class AddressPanelView: UIView {
    var onAddressChanged: ((String) -> Void)?
    
    var timer: Timer?
    var delayValue : Double = 2.0
    
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
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ addressText: String) {
        addressView.addressTextField.text = addressText
    }
    
    func observe() {
        addressView.addressTextField.addTarget(nil, action: #selector(addressTextFieldChanged(_:)), for: .editingChanged)
    }
}

//MARK: - Event Handler
extension AddressPanelView {
    
    @objc func addressTextFieldChanged(_ sender: UITextField) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction() {
        if let addressText = addressView.addressTextField.text {
            onAddressChanged?(addressText)
        }
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
