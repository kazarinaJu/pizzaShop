//
//  ProfileCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 31.10.2024.
//

import Foundation

class ProfileCoordinator: Coordinator {
    
    var finishFlow: ((Bool)->())?
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showProfileVC()
    }
    
    private func showProfileVC() {
        let profileScreen = screenFactory.makeProfileScreen()
        //router.setRootModule(profileScreen, hideBar: true)
        router.present(profileScreen, animated: true, onRoot: false)
    }
}