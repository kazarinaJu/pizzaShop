//
//  CloseViewButton.swift
//  dodo
//
//  Created by Юлия Ястребова on 29.10.2024.
//

import UIKit

final class CloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setImage(Images.xmark, for: .normal)
        tintColor = .darkGray
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 44).isActive = true
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
