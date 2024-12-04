//
//  CustomLabel.swift
//  dodo
//
//  Created by Юлия Ястребова on 02.12.2024.
//

import UIKit

final class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupDefaultStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDefaultStyle() {
        self.font = Fonts.proRoundedRegular15
        self.textColor = .black
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
    func configure(
        text: String? = nil,
        font: UIFont? = nil,
        textColor: UIColor? = nil,
        textAlignment: NSTextAlignment? = nil,
        numberOfLines: Int? = nil
    ) {
        if let text = text {
            self.text = text
        }
        if let font = font {
            self.font = font
        }
        if let textColor = textColor {
            self.textColor = textColor
        }
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
        if let numberOfLines = numberOfLines {
            self.numberOfLines = numberOfLines
        }
    }
}

