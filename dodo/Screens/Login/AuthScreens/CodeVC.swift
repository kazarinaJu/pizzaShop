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
    
    func navigateToProfile()
}

final class CodeVC: UIViewController, CodeVCProtocol {
    var presenter: AuthPresenterProtocol?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Введите код из смс"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProRounded-Bold", size: 22)
        return label
    }()
    
    var codeTextField: UITextField = {
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
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Regular", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    @objc private func enterButtonTapped() {
        presenter?.getEnterButtonTapped()
    }
    
    func navigateToProfile() {
        let profileVC = ProfileVC()
        present(profileVC, animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(codeTextField)
        view.addSubview(continueButton)
        
    }
    
    private func setupConstraints() {
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
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(50)
            make.left.right.equalTo(view).inset(50)
            make.centerX.equalTo(view)
        }
    }
}
