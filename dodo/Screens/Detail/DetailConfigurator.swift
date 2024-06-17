//
//  DetailConfigurator.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.03.2024.
//

import UIKit

final class DetailConfigurator {
    func configure(_ product: Product) -> DetailVC {
        
        let detailVC = DetailVC()
        let detailPresenter = DetailPresenter()
        
        detailVC.presenter = detailPresenter
        detailPresenter.view = detailVC
        
        let networkClient = NetworkClient()
        let productService = ProductsService(networkClient: networkClient)
        let orderService = OrdersService(networkClient: networkClient)
        detailPresenter.productsService = productService
        detailPresenter.ordersService = orderService
       
        detailPresenter.product = product
        
        return detailVC
    }
}
