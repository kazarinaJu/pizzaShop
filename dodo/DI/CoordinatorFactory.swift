//
//  CoordinatorFactory.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(router: Router) -> AppCoordinator
    func makeStartCoordinator(router: Router) -> StartCoordinator
    func makeLoginCoordinator(router: Router) -> LoginCoordinator
    func makeMenuCoordinator(router: Router) -> MenuCoordinator
    func makeProfileCoordinator(router: Router) -> ProfileCoordinator
    func makeStorieCoordinator(router: Router) -> StorieCoordinator
    func makeMapCoordinator(router: Router) -> MapCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    private let screenFactory: ScreenFactoryProtocol
    
    init(screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> AppCoordinator {
        return AppCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeStartCoordinator(router: Router) -> StartCoordinator {
        return StartCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeLoginCoordinator(router: Router) -> LoginCoordinator {
        return LoginCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeMenuCoordinator(router: Router) -> MenuCoordinator {
        return MenuCoordinator(router: router, screenFactory: screenFactory, coordinatorFactory: self)
    }
    
    func makeProfileCoordinator(router: Router) -> ProfileCoordinator {
        return ProfileCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeStorieCoordinator(router: Router) -> StorieCoordinator {
        return StorieCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeMapCoordinator(router: Router) -> MapCoordinator {
        return MapCoordinator(router: router, screenFactory: screenFactory)
    }
}
