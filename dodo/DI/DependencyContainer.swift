//
//  DependencyContainer.swift
//  dodo
//
//  Created by Юлия Ястребова on 30.09.2024.
//

import Foundation
import UIKit

final class DependencyContainer {
    fileprivate let coordinatorFactory: CoordinatorFactory
    fileprivate let screenFactory: ScreenFactory
    let networkClient: NetworkClient
    let productsService: ProductsService
    let storiesService: StoriesService
    let ordersService: OrdersService
    let phoneAuthService: PhoneAuthService
    
    init() {
        screenFactory = ScreenFactory()
        coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory)
        networkClient = NetworkClient()
        productsService = ProductsService(networkClient: networkClient)
        storiesService = StoriesService(networkClient: networkClient)
        ordersService = OrdersService(networkClient: networkClient)
        phoneAuthService = PhoneAuthService.shared
        
        screenFactory.di = self
    }
}

protocol AppFactoryProtocol {
    func makeKeyWindowWithAppCoordinator(_ window: UIWindow?) -> (UIWindow?, Coordinator)
}

extension DependencyContainer: AppFactoryProtocol {

    //Стартуем коодинатор - всего приложения
    func makeKeyWindowWithAppCoordinator(_ window: UIWindow?) -> (UIWindow?, Coordinator) {
        let rootVC = UINavigationController()
        let router = RouterImpl(rootController: rootVC)
        let coordinator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window?.rootViewController = rootVC
        return (window, coordinator)
    }
}
