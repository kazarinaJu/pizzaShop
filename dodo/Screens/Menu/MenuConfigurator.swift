//
//  MenuConfigurator.swift
//  dodo
//
//  Created by Юлия Ястребова on 21.03.2024.
//

import UIKit

final class MenuConfigurator {
    func configure() -> MenuVC {
        let menuVC = MenuVC()
        let menuPresenter = MenuPresenter()
        
        //обвязка
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
        
        //di
        let networkClient = NetworkClient()
        let productsService = ProductsService(networkClient: networkClient)
        let storiesService = StoriesService(networkClient: networkClient)
        let orderService = OrdersService(networkClient: networkClient)
        menuPresenter.productsService = productsService
        menuPresenter.storiesService = storiesService
        menuPresenter.ordersService = orderService
        
        
        
        
        return menuVC
    }
}
