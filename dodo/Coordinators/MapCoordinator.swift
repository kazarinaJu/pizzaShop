//
//  MapCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation

class MapCoordinator: Coordinator {
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showMap()
    }
    
    private func showMap() {
        let mapScreen = screenFactory.makeMapScreen()
        router.setRootModule(mapScreen, hideBar: true)
    }
}
