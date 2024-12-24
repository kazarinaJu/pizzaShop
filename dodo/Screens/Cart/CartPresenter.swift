//
//  CartPresenter.swift
//  dodo
//
//  Created by Юлия Ястребова on 22.03.2024.
//

import UIKit

protocol CartPresenterProtocol: AnyObject {
    var view: CartVCProtocol? { get set }
    
    var totalPrice: Int { get set }
    var totalProducts: Int { get set }
    
    func viewWillAppear()
    func productCountChanged(_ products: inout [Product], _ changedProduct: Product)
    func offerPriceButtonTapped(_ product: Product)
    
    func fetchOfferProducts()
    func fetchOrderProducts()
    func fetchTotalCountAndPrice()
    func updateCart()
}

final class CartPresenter: CartPresenterProtocol {
    
    weak var view: CartVCProtocol?
    var totalProducts: Int = 0
    var totalPrice: Int = 0
    
    //MARK: Services
    var ordersService: OrdersStorageProtocol?
    var productsService: ProductsServiceProtocol?
    
    func viewWillAppear() {
        fetchOrderProducts()
        fetchOfferProducts()
        fetchTotalCountAndPrice()
        updateCart()
    }
}

//MARK: - Event Handler
extension CartPresenter {
    func productCountChanged(_ products: inout [Product], _ changedProduct: Product) {
        if let index = products.firstIndex(where: { $0.id == changedProduct.id }) {
            products[index] = changedProduct
            
            if changedProduct.count <= 0 {
                products.remove(at: index)
            }
        }
        self.ordersService?.save(products)
        self.updateCart()
    }
    
    func offerPriceButtonTapped(_ product: Product) {
        ordersService?.add(product)
        updateCart()
        fetchOrderProducts()
        
    }
}

//MARK: - Business Logic
extension CartPresenter {
    func fetchOfferProducts() {
        productsService?.fetchProducts { [weak self] products in
            guard let self else { return }
            view?.show(products.filter { $0.isOnSale })
        }
    }

    func fetchOrderProducts() {
        guard let orderProducts = ordersService?.fetch() else { return }
        view?.showProducts(orderProducts)
    }
    
    func fetchTotalCountAndPrice() {
        totalPrice = ordersService?.calculateTotalPrice() ?? 0
        totalProducts = ordersService?.calculateTotalCount() ?? 0
    }
    
    func updateCart() {
        fetchTotalCountAndPrice()
        view?.showCart(totalPrice, totalProducts)
    }
}
