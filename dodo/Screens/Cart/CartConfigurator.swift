//
//  CartConfigurator.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.03.2024.
//

import UIKit

final class CartConfigurator {
    func configure(_ di: DependencyContainer) -> CartVC {
        let cartVC = CartVC()
        let cartPresenter = CartPresenter()
        
        cartVC.presenter = cartPresenter
        cartPresenter.view = cartVC
        
        cartPresenter.ordersService = di.ordersService
        cartPresenter.productsService = di.productsService
        
        return cartVC
    }
}
