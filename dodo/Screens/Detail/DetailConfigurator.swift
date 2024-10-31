//
//  DetailConfigurator.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.03.2024.
//

import UIKit

final class DetailConfigurator {
    func configure(_ product: Product, _ di: DependencyContainer) -> DetailVC {
        
        let detailVC = DetailVC()
        let detailPresenter = DetailPresenter()
        
        detailVC.presenter = detailPresenter
        detailPresenter.view = detailVC
        
        detailPresenter.productsService = di.productsService
        detailPresenter.ordersService = di.ordersService
        
        detailPresenter.product = product
        
        return detailVC
    }
}
