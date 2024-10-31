//
//  CartCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation

class CartCoordinator: Coordinator {
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showCart()
    }
    
    private func showCart() {
        let cartScreen = screenFactory.makeCartScreen()
        router.setRootModule(cartScreen, hideBar: true)
    }
}
