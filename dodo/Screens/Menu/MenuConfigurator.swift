//
//  MenuConfigurator.swift
//  dodo
//
//  Created by Юлия Ястребова on 21.03.2024.
//

import UIKit

final class MenuConfigurator {
    func configure(_ di: DependencyContainer) -> MenuVC {
        let menuVC = MenuVC()
        let menuPresenter = MenuPresenter()
        
        //обвязка
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
        
        //di
        menuPresenter.productsService = di.productsService
        menuPresenter.storiesService = di.storiesService
        menuPresenter.ordersService = di.ordersService

        return menuVC
    }
}
