//
//  PopoverViewController.swift
//  dodo
//
//  Created by Юлия Ястребова on 20.11.2024.
//

import UIKit
import SnapKit

final class  PopoverVC: UIViewController {
    
    private lazy var label: CustomLabel = {
        let label = CustomLabel()
        label.configure(
            text: "Здесь будет текст"
        )
        return label
    }()

    override  func  viewDidLoad () {
        super .viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        view.addSubview(label)
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
        }
    }
}
