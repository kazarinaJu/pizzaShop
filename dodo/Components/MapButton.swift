//
//  MapButton.swift
//  dodo
//
//  Created by Юлия Ястребова on 13.08.2024.
//

import UIKit
import SnapKit

class MapButton {
    private weak var window: UIWindow?
    private var mapButton: UIButton?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func addMapButton() {
        guard let window = window else { return }

        mapButton = UIButton(type: .system)
        
        let image = UIImage(systemName: "location.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        mapButton?.setImage(image, for: .normal)
        mapButton?.backgroundColor = .clear
        mapButton?.addTarget(self, action: #selector(openMapVC), for: .touchUpInside)
        mapButton?.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(mapButton!)
        
        mapButton?.snp.makeConstraints { make in
            make.left.equalTo(window.snp.left).inset(20)
            make.top.equalTo(window.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
    }
    
    @objc private func openMapVC() {
        guard let window = window else { return }
        let mapVC = MapVC()
        
        window.rootViewController?.present(mapVC, animated: true, completion: nil)
    }
}
