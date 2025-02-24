//
//  AddressPanelView.swift
//  dodo
//
//  Created by Юлия Ястребова on 03.04.2024.
//

import UIKit
import SnapKit

final class AddressPanelView: UIView {
    var onAddressChanged: ((String) -> ())?
    var onAddressSaved: ((String) -> ())?
    var onAddressTap: (() -> ())?
    
    var timer: Timer?
    var delayValue : Double = 2.0
    
    var addressView = AddressView()
    var saveButton = CustomBigButton()
    let adressStorage = AddressStorage()
    
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
        setupSaveButton()
        observe()
        addressView.addressTextField.delegate = self
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
    
    func setupSaveButton() {
        saveButton.customBigtButton.setTitle("Сохранить", for: .normal)
        saveButton.customBigtButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        if let addressText = addressView.addressTextField.text {
            onAddressSaved?(addressText)
            adressStorage.add(addressText)
        }
    }
}

//MARK: - Layout
extension AddressPanelView {
    func setupViews() {
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

extension AddressPanelView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onAddressTap?()
        return false
    }
}
