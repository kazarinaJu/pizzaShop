//
//  CartButton.swift
//  dodo
//
//  Created by Юлия Ястребова on 11.08.2024.
//

import UIKit
import SnapKit

class CartButton {
    private weak var window: UIWindow?
    private var cartButton: UIButton?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func addCartButton() {
        guard let window = window else { return }

        cartButton = UIButton(type: .system)
        
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "cart", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        cartButton?.setImage(image, for: .normal)
        cartButton?.backgroundColor = .orange
        cartButton?.layer.cornerRadius = 25
        cartButton?.addTarget(self, action: #selector(openCartVC), for: .touchUpInside)
        cartButton?.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(cartButton!)
        
        cartButton?.snp.makeConstraints { make in
            make.right.equalTo(window.snp.right).inset(20)
            make.bottom.equalTo(window.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
    }
    
    @objc private func openCartVC() {
        guard let window = window else { return }
        let cartVC = CartConfigurator().configure()
        
        window.rootViewController?.present(cartVC, animated: true, completion: nil)
    }
}

