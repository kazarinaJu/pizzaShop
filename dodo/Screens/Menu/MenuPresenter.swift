//
//  MenuPresenter.swift
//  dodo
//
//  Created by Юлия Ястребова on 21.03.2024.
//

import UIKit
import DodoNetworkLayer

protocol MenuPresenterProtocol: AnyObject {
    var view: MenuVCProtocol? { get set }
    
    //User Event & View Event
    func viewWillAppear()
    func bannerPriceButtonTapped(_ product: Product)
    func productPriceButtonTapped(_ product: Product)
    func productCellSelected(_ selectedProduct: Product)
    func flagButtonTapped()
    func loginButtonTapped()
    func cartButtonTapped()
    func mapButtonTapped()
    
    //Business Logic
    func fetchProducts()
    func fetchStories()
    func fetchCategories()
}

final class MenuPresenter: MenuPresenterProtocol {
    
    weak var view: MenuVCProtocol?
    
    //MARK: Services
    var storiesService: StoriesServiceProtocol?
    var productsService: ProductsServiceProtocol?
    var ordersService: OrdersStorageProtocol?
    
    func viewWillAppear() {
        fetchProducts()
        fetchStories()
        fetchCategories()
    }
}

//MARK: - Event Handler
extension MenuPresenter {
    func bannerPriceButtonTapped(_ product: Product) {
        ordersService?.add(product)
    }
    
    func productPriceButtonTapped(_ product: Product) {
        ordersService?.add(product)
    }
    
    func productCellSelected(_ selectedProduct: Product) {
        view?.navigateToDetailScreen(selectedProduct)
    }
    
    func flagButtonTapped() {
        view?.navigateToFeatureTogglesScreen()
    }
    
    func loginButtonTapped() {
        view?.navigateToLoginScreen()
    }
    
    func cartButtonTapped() {
        view?.navigateToCartScreen()
    }
    
    func mapButtonTapped() {
        view?.navigateToMapScreen()
    }
    
    func addressSelected(_ address: String) {
        view?.updateAddress(address)
    }
}

//MARK: - Business Logic
extension MenuPresenter {
    func fetchProducts() {
        productsService?.fetchProducts { [weak self] products in
            guard let self else { return }
            view?.showProducts(products)
        }
    }
    
    func fetchStories() {
        storiesService?.fetchStories { [self] stories in
            view?.showStories(stories)
        }
    }
    
    func fetchCategories() {
        guard let categories = productsService?.fetchCategories() else { return }
        view?.showCategories(categories)
    }
}
