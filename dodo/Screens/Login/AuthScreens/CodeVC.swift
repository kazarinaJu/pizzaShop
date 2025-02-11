//
//  CodeVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 06.10.2024.
//

import Foundation
import UIKit
import SnapKit

protocol CodeVCProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
    var codeTextField: UITextField { get }
    var onUserLoggedIn: ((Bool)->())? { get }
}

final class CodeVC: UIViewController, CodeVCProtocol {
    var presenter: AuthPresenterProtocol?
    
    var onUserLoggedIn: ((Bool)->())?
    
    private var titleLabel = CustomLabel.centerRoundedBold22
    
    var codeTextField: UITextField = {
        var textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = UIColor.label
        textField.backgroundColor = Colors.gray
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()
    
    private var enterButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.backgroundColor = Colors.orange
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = Fonts.proRoundedRegular15
        button.setTitleColor(Colors.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(nil, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private var closeButton: CloseButton = {
        let button = CloseButton()
        button.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        observe()
    }
    
    private func observe() {
        codeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        guard let text = codeTextField.text else { return }
        let isSixDigits = text.range(of: "^[0-9]{6}$", options: .regularExpression) != nil
        
        if isSixDigits {
            enterButton.isEnabled = true
            enterButton.alpha = 1.0
        } else {
            enterButton.isEnabled = false
            enterButton.alpha = 0.5
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func enterButtonTapped() {
        presenter?.getEnterButtonTapped()
        UserDefaults.standard.set(true, forKey: "isFirstAuthCompleted")
        self.onUserLoggedIn?(true)
    }
    
    private func setupViews() {
        view.backgroundColor = Colors.white
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(codeTextField)
        view.addSubview(enterButton)
        
        titleLabel.text = Texts.Login.codeTitle
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
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.centerX.equalTo(view)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(50)
            make.left.right.equalTo(view).inset(50)
            make.centerX.equalTo(view)
        }
    }
}
