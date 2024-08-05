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
    var productsService: ProductsServiceProtocol?
    var ordersService: OrdersServiceProtocol?
    
    func viewDidLoad() {
        
        //provider.fetchIngredients()
        //interactor.fetchIngredients()
        
        //presenter.fetchedIngredients(ingredients) VIPER
        //view.showIngredients() VIP (Clean Swift)
        
        fetchIngredients()
        fetchSizesAndDough()
    }
}

//MARK: - Event Handler
extension DetailPresenter {
    func addToCartButtonTapped(_ product: Product) {
        ordersService?.add(product)
    }
    
    func sizeControlTapped(_ size: String) {
        self.product?.size = size
        view?.showProduct(self.product)
        
    }
    
    func doughControlTapped(_ dough: String) {
        self.product?.dough = dough
        view?.showProduct(product)
    }
}

//MARK: - Business Logic
extension DetailPresenter {
    func fetchIngredients() {
        
//        productsService?.fetchIngredients { [weak self] ingredients in
//            
//            self?.view?.showIngredients(ingredients)
//        }
    }
    
    func fetchSizesAndDough() {
        
//        productsService?.fetchSizesAndDough { [weak self] sizes, dough in
//            if let sizes = sizes, let dough = dough {
//                self?.view?.showSizes(sizes)
//                self?.view?.showDough(dough)
//            }
//        }
    }
}


