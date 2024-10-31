//
//  MenuCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation

class MenuCoordinator: Coordinator {
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        
        let menuScreen = screenFactory.makeMenuScreen()
        
        menuScreen.onDetailCellTapped = { product in
            self.showDetail(product)
        }
        
        menuScreen.onCartButtonTapped = {
            self.showCart()
        }
        
        menuScreen.onMapButtonTapped = {
            self.showMap()
        }
        
        menuScreen.onLoginButtonTapped = {
            self.runLoginFlow()
        }
        
        router.setRootModule(menuScreen, hideBar: true)
    }
    
    func showDetail(_ product: Product) {
        let detailScreen = screenFactory.makeDetailScreen(with: product)
        //router.present(detailScreen, animated: true)
        router.present(detailScreen, animated: true, onRoot: true )
    }
    
    func showCart() {
        let cartScreen = screenFactory.makeCartScreen()
        router.present(cartScreen, animated: true, onRoot: true)
    }
    
    func showMap() {
        let mapScreen = screenFactory.makeMapScreen()
        router.present(mapScreen, animated: true, onRoot: true)
    }
    
    func runLoginFlow() {
        let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
        
        coordinator.finishAuth = { isLoaded in
            self.runProfileFlow()
            self.removeDependency(coordinator)
        }
        
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    func runProfileFlow() {
        let coordinator = coordinatorFactory.makeProfileCoordinator(router: router)
        self.addDependency(coordinator)
        coordinator.start()
    }
}
