//
//  SceneDelegate.swift
//  dodo
//
//  Created by Юлия Ястребова on 26.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let appFactory: AppFactoryProtocol = DependencyContainer()
    //private var appCoordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow.init(windowScene: windowScene)
        
        let (window, coordinator) = appFactory.makeKeyWindowWithAppCoordinator(window)
        self.window = window
        
        coordinator.start()
        window?.makeKeyAndVisible()
        
    }
}
