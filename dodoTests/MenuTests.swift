//
//  MenuTests.swift
//  dodo-Tests
//
//  Created by Юлия Ястребова on 18.04.2024.
//

import XCTest
@testable import dodo
import Foundation

final class MenuTests: XCTestCase {
    
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

    //MARK: - Test Presenter
    func testPresenterCallsViewDidLoad() {
        
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
    
    func testPresenterCallsBannerPriceButtonTapped() {
        //given
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
    
    func testPresenterCallsProductPriceButtonTapped() {
        //given
        let menuVC = MenuVC()
        let menuPresenter = MenuPresenterSpy()
        
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
        let product = Product.empty
        
        //when
        let _ = menuVC.productCellPriceButtonTapped(product)
        
        //then
        XCTAssertTrue(menuPresenter.productPriceButtonTappedCalled)
    }
    
    func testPresenterCallsProductCellSelected() {
        //given
        let menuVC = MenuVC()
        let menuPresenter = MenuPresenterSpy()
        
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
        let product = Product.empty
        
        //when
        let _ = menuVC.productSelectedTapped(product)
        
        //then
        XCTAssertTrue(menuPresenter.productCellSelectedCalled)
    }
    
    //MARK: - Test ViewController
    func testViewControllerNavigateToDetailScreenCalled() {
        //given
        let menuPresenter = MenuPresenter()
        let menuVC = MenuViewControllerSpy()
        
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
        
        //when
        let _ = menuPresenter.productCellSelected(Product.empty)
        
        //then
        XCTAssertTrue(menuVC.navigateToDetailScreenCalled)
    }
    
    func testViewControllerShowProductsCalled() {
    
        let networkClientStub = NetworkClientStub(domainType: .products, emulateError: false)
        let productService = ProductsService(networkClient: networkClientStub)
        let menuVCSpy = MenuViewControllerSpy()
        let menuPresenter = MenuPresenter()
        
        menuVCSpy.presenter = menuPresenter
        menuPresenter.view = menuVCSpy
        menuPresenter.productsService = productService

        //when
        menuPresenter.fetchProducts()
        
        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //then
            XCTAssertTrue(menuVCSpy.showProductsCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testViewControllerShowCategoriesCalled() {
    
        let networkClientStub = NetworkClientStub(domainType: .categories, emulateError: false)
        let productService = ProductsService(networkClient: networkClientStub)
        let menuVCSpy = MenuViewControllerSpy()
        let menuPresenter = MenuPresenter()
        
        menuVCSpy.presenter = menuPresenter
        menuPresenter.view = menuVCSpy
        menuPresenter.productsService = productService

        //when
        menuPresenter.fetchCategories()
        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //then
            XCTAssertTrue(menuVCSpy.showCategoriesCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testViewControllerShowStoriesCalled() {
    
        let networkClientStub = NetworkClientStub(domainType: .stories, emulateError: false)
        let storiesService = StoriesService(networkClient: networkClientStub)
        let menuVCSpy = MenuViewControllerSpy()
        let menuPresenter = MenuPresenter()
        
        menuVCSpy.presenter = menuPresenter
        menuPresenter.view = menuVCSpy
        menuPresenter.storiesService = storiesService

        //when
        menuPresenter.fetchStories()
        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //then
            XCTAssertTrue(menuVCSpy.showStoriesCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
}
