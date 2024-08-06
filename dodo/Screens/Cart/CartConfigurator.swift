//
//  CartConfigurator.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.03.2024.
//

import UIKit

final class CartConfigurator {
    func configure() -> CartVC {
        let cartVC = CartVC()
        let cartPresenter = CartPresenter()
        cartVC.presenter = cartPresenter
        cartPresenter.view = cartVC
        
        let networkClient = NetworkClient()
        let ordersService = OrdersService(networkClient: networkClient)
        let productsService = ProductsService(networkClient: networkClient)
        
        cartPresenter.ordersService = ordersService
        cartPresenter.productsService = productsService
        
        return cartVC
    }
}
