//
//  StartCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation

class StartCoordinator: Coordinator {
    
    var finishFlow: ((Bool)->())?
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showSplash()
    }
    
    private func showSplash() {
        let startScreen = screenFactory.makeStartScreen()
        
        startScreen.onTogglesPreloaded = {  isLoaded in
            //guard let self else { return }
            self.finishFlow?(true)
        }
        
        router.setRootModule(startScreen, hideBar: true)
    }
}
