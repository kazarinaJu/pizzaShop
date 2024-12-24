//
//  LoginVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 10.09.2024.
//

import Foundation
import UIKit
import SnapKit

protocol LoginVCProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
}

final class LoginVC: UIViewController, LoginVCProtocol {
    var presenter: AuthPresenterProtocol?
    
    var onPhoneButtonTapped: (()->())?
    
    private var titleLabel = CustomLabel.centerRoundedBold22
    private var descriptionLabel = CustomLabel.centerRegular15
    
    private var loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.login
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 0.6 * ScreenSize.width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.6 * ScreenSize.width).isActive = true
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var loginButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.backgroundColor = Colors.orange
        button.setTitle("Указать телефон", for: .normal)
        button.titleLabel?.font = Fonts.proRoundedRegular15
        button.setTitleColor(Colors.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
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
        setupUI()
    }
    
    private func setupViews() {
        view.backgroundColor = Colors.white
        
        view.addSubview(closeButton)
        view.addSubview(loginImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        loginImageView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(50)
            make.centerX.equalTo(view)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(loginImageView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(50)
            make.left.right.equalTo(view).inset(50)
            make.centerX.equalTo(view)
        }
    }
    
    private func setupUI() {
        titleLabel.text = Texts.Login.loginTitle
        descriptionLabel.text = Texts.Login.loginDescription
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    @objc private func phoneButtonTapped() {
        onPhoneButtonTapped?()
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
