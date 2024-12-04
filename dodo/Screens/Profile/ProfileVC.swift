//
//  ProfileVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 06.10.2024.
//

import Foundation
import UIKit
import SnapKit

final class ProfileVC: UIViewController {
    
    var onUserLogsOut: ((Bool)->())?
    
    private var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.configure(
            text: Texts.Login.profileText,
            font: Fonts.proRoundedBold22
        )
        return label
    }()
    
    private var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = Fonts.proRoundedRegular15
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
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
    }
    
    @objc private func logoutButtonTapped() {
        onUserLogsOut?(true)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(logoutButton)
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
        
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
}
