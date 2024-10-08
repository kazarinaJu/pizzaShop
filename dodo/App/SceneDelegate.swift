//
//  SceneDelegate.swift
//  dodo
//
//  Created by Юлия Ястребова on 26.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let remoteToggleService = RemoteTogglesService.shared
    let localToggleService = LocalTogglesService.shared

    var window: UIWindow?
    
    var mapButton: MapButton?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
   
        let mainVC = MenuConfigurator().configure()

        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if self.remoteToggleService.isMapAvailable && self.localToggleService.isMapAvailable {
                mapButton?.addMapButton()
            }
        }
    }
}
