//
//  SceneDelegate.swift
//  dodo
//
//  Created by Юлия Ястребова on 26.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var cartButton: CartButton?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let mainVC = MenuConfigurator().configure()

        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
        cartButton = CartButton(window: window)
        cartButton?.addCartButton()
    }
}
