//
//  CustomStepper.swift
//  dodo
//
//  Created by Юлия Ястребова on 04.03.2024.
//

import UIKit
import SnapKit

final class CustomStepper: UIControl {
    
    var currentValue = 1 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = Fonts.proRoundedRegular15
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var currentStepValueLabel: CustomLabel = {
        let label = CustomLabel()
        label.configure(
            text: "\(currentValue)"
        )
        return label
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = Fonts.proRoundedRegular15
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 20
        
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(decreaseButton)
        horizontalStackView.addArrangedSubview(currentStepValueLabel)
        horizontalStackView.addArrangedSubview(increaseButton)
    }
    
    private func setupContraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }
        sendActions(for: .valueChanged)
    }
}
