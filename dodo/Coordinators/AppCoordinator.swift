//
//  AppCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation

class AppCoordinator: Coordinator {
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runStartFlow()
    }
    
    func runStartFlow() {
        let coordinator = coordinatorFactory.makeStartCoordinator(router: router)
       
        coordinator.finishFlow = { isLoaded in
            self.runMenuFlow()
            self.removeDependency(coordinator)
        }
        
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    func runMenuFlow() {
        let coordinator = coordinatorFactory.makeMenuCoordinator(router: router)
        self.addDependency(coordinator)
        coordinator.start()
    }
}
