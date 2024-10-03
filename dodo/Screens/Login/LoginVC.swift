//
//  LoginVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 10.09.2024.
//

import Foundation
import UIKit
import SnapKit

final class LoginVC: UIViewController {
    
    //var onLoginButtonTapped: (() -> ())?
    
    private var loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login")
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 0.6 * ScreenSize.width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.6 * ScreenSize.width).isActive = true
        imageView.layer.cornerRadius = 60
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Войдите в профиль"
        label.font = UIFont(name: "SFProRounded-Bold", size: 22)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Чтобы копить додокоины и получать персональные скидки"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProRounded-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return label
    }()
    
    private var loginButton: UIButton = {
        var button = UIButton.init(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Указать телефон", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Regular", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(loginImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        loginImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(100)
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
    
    @objc private func loginButtonTapped() {
        //onLoginButtonTapped?()
    }
}
