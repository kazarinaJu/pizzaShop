//
//  MenuPresenter.swift
//  dodo
//
//  Created by Юлия Ястребова on 21.03.2024.
//

import UIKit

protocol MenuPresenterProtocol: AnyObject {
    var view: MenuVCProtocol? { get set }
    
    //User Event & View Event
    func viewDidLoad()
    func bannerPriceButtonTapped(_ product: Product)
    func productPriceButtonTapped(_ product: Product)
    func productCellSelected(_ selectedProduct: Product)
    
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
    var ordersService: OrdersServiceProtocol?
  
    func viewDidLoad() {
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
}

//MARK: - Business Logic
extension MenuPresenter {
    func fetchProducts() {
        Task {
            do {
                if let products = try await productsService?.fetchProducts() {
                    await MainActor.run {
                        view?.showProducts(products)
                    }
                }
            } catch {
                print(error)
            }
        }
    }

    func fetchStories() {
//        Task {
//            do {
//                if let stories = try await productsService?.f() {
//                    await MainActor.run {
//                        view?.showStories(stories)
//                    }
//                }
//            } catch {
//                print(error)
//            }
//        }
        
//        storiesService?.fetchStories { [self] stories in
//            view?.showStories(stories)
//        }
    }

    func fetchCategories() {
        Task {
            do {
                if let categories = try await productsService?.fetchCategories() {
                    await MainActor.run {
                        view?.showCategories(categories)
                    }
                }
            } catch {
                print(error)
            }
        }
//        productsService?.fetchCategories { [self] categories in
//            view?.showCategories(categories)
//        }
    }
}
