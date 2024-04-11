//
//  DetailPresenter.swift
//  dodo
//
//  Created by Юлия Ястребова on 22.03.2024.
//

import UIKit

protocol DetailPresenterProtocol: AnyObject {
    var view: DetailVCProtocol? { get set }
    
    //View Event
    func viewDidLoad()
    func addToCartButtonTapped(_ product: Product)
    func sizeControlTapped(_ size: String)
    func doughControlTapped(_ dough: String)
    
    //Update View
    //func displayProduct(_ product: Product)
    
    //Business Logic
    func fetchIngredients()
    func fetchSizesAndDough()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailVCProtocol?
    var product: Product? {
        didSet {
            view?.showProduct(product)
        }
    }
    
//MARK: Services
    private let productsService = ProductsService.init()
    private let ordersService = OrdersService.init()
    
    func viewDidLoad() {
        fetchIngredients()
        fetchSizesAndDough()
        //тут надо displayProduct?
    }
}

//MARK: - Event Handler
extension DetailPresenter {
    func addToCartButtonTapped(_ product: Product) {
        ordersService.add(product)
    }
    
    func sizeControlTapped(_ size: String) {
        if let product = product {
            self.product?.size = size
            print("->", self.product?.size)
            view?.showProduct(self.product)
        }
    }
    
    func doughControlTapped(_ dough: String) {
        if let product = product {
            self.product?.dough = dough
            view?.showProduct(product)
        }
    }
}

//MARK: - Business Logic
extension DetailPresenter {
    func fetchIngredients() {
        productsService.fetchIngredients { [weak self] ingredients in
            self?.view?.showIngredients(ingredients)
        }
    }
    
    func fetchSizesAndDough() {
        productsService.fetchSizesAndDough { [weak self] sizes, dough in
            if let sizes = sizes, let dough = dough {
                self?.view?.showSizes(sizes)
                self?.view?.showDough(dough)
            }
        }
    }
//    func displayProduct(_ product: Product) {
//        self.product = product
//        view?.showProduct(product)
//    }
}


