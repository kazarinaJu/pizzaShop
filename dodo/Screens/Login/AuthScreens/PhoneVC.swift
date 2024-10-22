//
//  Untitled.swift
//  dodo
//
//  Created by Юлия Ястребова on 06.10.2024.
//

import Foundation
import UIKit
import SnapKit

protocol PhoneVCProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
    var phoneTextField: UITextField { get }
    
    func navigateToCodeScreen()
}

final class PhoneVC: UIViewController, PhoneVCProtocol {
    var presenter: AuthPresenterProtocol?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Укажите телефон, чтобы войти в профиль"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProRounded-Bold", size: 22)
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
        button.titleLabel?.font = UIFont(name: "SFProRounded-Regular", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(codeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    @objc private func codeButtonTapped() {
        presenter?.getCodeButtonTapped()
    }
    
    func navigateToCodeScreen() {
        let codeVC = AuthConfigurator().configureCode()
        present(codeVC, animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(phoneTextField)
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
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
