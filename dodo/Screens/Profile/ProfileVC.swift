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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Скоро тут будет профиль"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProRounded-Bold", size: 22)
        return label
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
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        
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
    }
}
