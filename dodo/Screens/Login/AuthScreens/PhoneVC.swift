//
//  Untitled.swift
//  dodo
//
//  Created by Юлия Ястребова on 06.10.2024.
//

import Foundation
import UIKit
import SnapKit
import PhoneNumberKit

protocol PhoneVCProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
    var phoneTextField: UITextField { get }
    
    func navigateToCodeScreen()
}

final class PhoneVC: UIViewController, PhoneVCProtocol {
    
    var presenter: AuthPresenterProtocol?
    
    var onContinueButtonTapped: (()->())?
    
    private var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.configure(
            text: Texts.Login.phoneTitle,
            font: Fonts.proRoundedBold22
        )
        return label
    }()
    
     var phoneTextField: UITextField = {
        var textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = UIColor.label
        textField.backgroundColor = UIColor.secondarySystemBackground
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()
    
    private var continueButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = Fonts.proRoundedRegular15
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private var closeButton: CloseButton = {
        let button = CloseButton()
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        observeTF()
    }
    
    private func observeTF() {
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        let phoneNumberUtility = PhoneNumberUtility()
        
        guard let text = phoneTextField.text else { return }
        
        do {
            let phoneNumber = try phoneNumberUtility.parse(text, withRegion: "RU", ignoreType: true)
            continueButton.isEnabled = true
            continueButton.alpha = 1.0
        } catch {
            continueButton.isEnabled = false
            continueButton.alpha = 0.5
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc internal func continueButtonTapped() {
        presenter?.getCodeButtonTapped()
    }
    
    func navigateToCodeScreen() {
        //dismiss(animated: true) { [weak self] in
            self.onContinueButtonTapped?()
        //}
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(phoneTextField)
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
            make.left.right.equalTo(view).inset(20)
            make.centerX.equalTo(view)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.centerX.equalTo(view)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(50)
            make.left.right.equalTo(view).inset(50)
            make.centerX.equalTo(view)
        }
    }
}
