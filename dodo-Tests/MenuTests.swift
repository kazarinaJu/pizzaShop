//
//  MenuTests.swift
//  dodo-Tests
//
//  Created by Юлия Ястребова on 18.04.2024.
//


import XCTest
@testable import dodo

class MenuPresenterSpy: MenuPresenterProtocol {
    var view: MenuVCProtocol?
    
    var viewDidLoadCalled = false
    var bannerPriceButtonTappedCalled = false
    var productPriceButtonTappedCalled = false
    var productCellSelectedCalled = false
    var fetchProductsCalled = false
    var fetchStoriesCalled = false
    var fetchCategoriesCalled = false
    
    func viewDidLoad() {
        
        viewDidLoadCalled = true
    }
    
    func bannerPriceButtonTapped(_ product: Product) {
        bannerPriceButtonTappedCalled = true
    }
    
    func productPriceButtonTapped(_ product: Product) {
        productPriceButtonTappedCalled = true
    }
    
    func productCellSelected(_ selectedProduct: Product) {
        productCellSelectedCalled = true
    }
    
    func fetchProducts() {
        fetchProductsCalled = true
    }
    
    func fetchStories() {
        fetchStoriesCalled = true
    }
    
    func fetchCategories() {
        fetchCategoriesCalled = true
    }

}

class MenuViewControllerSpy: MenuVCProtocol {
    
    var presenter: MenuPresenterProtocol?
    
    var showCategoriesCalled = false
    var showStoriesCalled = false
    var showProductsCalled = false
    var navigateToDetailScreenCalled = false
    
    func showCategories(_ categories: [dodo.Category]) {
        showCategoriesCalled = true
    }
    
    func showStories(_ stories: [Storie]) {
        showStoriesCalled = true
    }
    
    func showProducts(_ products: [Product]) {
        showProductsCalled = true
    }
    
    func navigateToDetailScreen(_ selectedProduct: Product) {
        navigateToDetailScreenCalled = true
    }
}

class ProductServiceSpy: ProductServiceProtocol {
    
    var fetchProductsCalled = false
    var fetchCategoriesCalled = false
    var fetchIngredientsCalled = false
    var fetchSizesAndDoughCalled = false
    
    func fetchProducts(completion: @escaping ([dodo.Product]) -> Void) {
        fetchProductsCalled = true
    }
    
    func fetchCategories(completion: @escaping ([dodo.Category]) -> Void) {
        fetchCategoriesCalled = true
    }
    
    func fetchIngredients(completion: @escaping ([dodo.Ingredient]) -> Void) {
        fetchIngredientsCalled = true
    }
    
    func fetchSizesAndDough(completion: @escaping ([String]?, [String]?) -> Void) {
        fetchSizesAndDoughCalled = true
    }
}

final class MenuTests: XCTestCase {
    
    func testViewControllerCallsViewDidLoad() {
        
        //given
        let menuVC = MenuVC()
        let menuPresenter = MenuPresenterSpy()
        
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
        
        //when
        let _ = menuVC.view
        
        //then
        XCTAssertTrue(menuPresenter.viewDidLoadCalled)
    }
    
    func testViewControllerCalssBannerPriceButtonTapped() {
        let menuVC = MenuVC()
        let menuPresenter = MenuPresenterSpy()
        
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
        let product = Product.empty
        
        //when
        let _ = menuVC.bannerCellPriceButtonTapped(product)
        //then
        XCTAssertTrue(menuPresenter.bannerPriceButtonTappedCalled)
    }
    
    func testPresenterProductCellSelectedCalled() {
        let menuPresenter = MenuPresenter()
        let menuVC = MenuViewControllerSpy()
        
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
    
        let _ = menuPresenter.productCellSelected(Product.empty)
        
        //then
        XCTAssertTrue(menuVC.navigateToDetailScreenCalled)
    }
    
    func testServiceFetchProductsCalled() {
        let menuPresenter = MenuPresenter()
        let productService = ProductServiceSpy()
        
        menuPresenter.productsService = productService
        
        //when
        menuPresenter.fetchProducts()
        
        //then
        XCTAssertTrue(productService.fetchProductsCalled)
    }
}
