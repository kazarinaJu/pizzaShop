//
//  DetailTests.swift
//  dodoTests
//
//  Created by Юлия Ястребова on 30.04.2024.
//

import XCTest
@testable import dodo
import Foundation

final class DetailTests: XCTestCase {
    
    class DetalViewControllerSpy: DetailVCProtocol {
        
        var presenter: DetailPresenterProtocol?
        
        var showIngredientsCalled = false
        var showSizesCalled = false
        var showDoughCalled = false
        var showProductCalled = false
        
        func showIngredients(_ ingredients: [dodo.Ingredient]) {
            showIngredientsCalled = true
        }
        
        func showSizes(_ sizes: [String]) {
            showSizesCalled = true
        }
        
        func showDough(_ dough: [String]) {
            showDoughCalled = true
        }
        
        func showProduct(_ product: Product?) {
            showProductCalled = true
        }
    }
    
    class DetailPresenterSpy: DetailPresenterProtocol {
        
        var view: DetailVCProtocol?
        
        var viewDidLoadCalled = false
        var addToCartButtonTappedCalled = false
        var sizeControlTappedCalled = false
        var doughControlTappedCalled = false
        var fetchIngredientsCalled = false
        var fetchSizesAndDoughCalled = false
        
        func viewDidLoad() {
            viewDidLoadCalled = true
        }
        
        func addToCartButtonTapped(_ product: Product) {
            addToCartButtonTappedCalled = true
        }
        
        func sizeControlTapped(_ size: String) {
            sizeControlTappedCalled = true
        }
        
        func doughControlTapped(_ dough: String) {
            doughControlTappedCalled = true
        }
        
        func fetchIngredients() {
            fetchIngredientsCalled = true
        }
        
        func fetchSizesAndDough() {
            fetchSizesAndDoughCalled = true
        }
    }
    
    //MARK: - Test Presenter
    func testPresenterCallsViewDidLoad() {
        
        //given
        let detailVC = DetailVC()
        let detailPresenter = DetailPresenterSpy()
        
        detailVC.presenter = detailPresenter
        detailPresenter.view = detailVC
        
        //when
        let _ = detailVC.view
        
        //then
        XCTAssertTrue(detailPresenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsAddToCartButtonTapped() {
      
    }
    
    func testPresenterCallsSizeControlTapped() {
        //given
        let detailVC = DetailVC()
        let detailPresenter = DetailPresenterSpy()
        
        detailVC.presenter = detailPresenter
        detailPresenter.view = detailVC
        guard let size = Product.empty.size else { return }
        
        let _ = detailVC.sizeControlCellTapped(size)
        
        XCTAssertTrue(detailPresenter.sizeControlTappedCalled)
    }
    
    func testPresenterCallsDoughControlTapped() {
        //given
        let detailVC = DetailVC()
        let detailPresenter = DetailPresenterSpy()
        
        detailVC.presenter = detailPresenter
        detailPresenter.view = detailVC
        guard let dough = Product.empty.dough else { return }
        
        let _ = detailVC.doughControlCellTapped(dough)
        
        XCTAssertTrue(detailPresenter.doughControlTappedCalled)
    }
    
//    func testPresenetrCallsFetchIngredients() {
//        //given
//        
//        //when
//     
//        
//        XCTAssertTrue(detailPresenter.fetchIngredientsCalled)
//    }
//    
//    func testPresenterCallsFetchSizesAndDough() {
//        //given
//       
//        
//        //when
//       
//        
//        XCTAssertTrue(detailPresenter.fetchSizesAndDoughCalled)
//    }
    
    //MARK: - Test ViewController
    func testViewControllerShowIngredientsCalled() {
        //given
        let networkClientStub = NetworkClientStub(domainType: .products, emulateError: false)
        let productService = ProductsService(networkClient: networkClientStub)
        let detailVCSpy = DetalViewControllerSpy()
        let detailPresenter = DetailPresenter()
        
        detailVCSpy.presenter = detailPresenter
        detailPresenter.view = detailVCSpy
        detailPresenter.productsService = productService

        //when
        detailPresenter.fetchIngredients()
        
        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //then
            XCTAssertTrue(detailVCSpy.showIngredientsCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testViewControllerShowSizesCalled() {
        //given
        let networkClientStub = NetworkClientStub(domainType: .products, emulateError: false)
        let productService = ProductsService(networkClient: networkClientStub)
        let detailVCSpy = DetalViewControllerSpy()
        let detailPresenter = DetailPresenter()
        
        detailVCSpy.presenter = detailPresenter
        detailPresenter.view = detailVCSpy
        detailPresenter.productsService = productService

        //when
        detailPresenter.fetchSizesAndDough()
        
        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //then
            XCTAssertTrue(detailVCSpy.showSizesCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testViewControllerShowDoughCalled() {
        //given
        let networkClientStub = NetworkClientStub(domainType: .products, emulateError: false)
        let productService = ProductsService(networkClient: networkClientStub)
        let detailVCSpy = DetalViewControllerSpy()
        let detailPresenter = DetailPresenter()
        
        detailVCSpy.presenter = detailPresenter
        detailPresenter.view = detailVCSpy
        detailPresenter.productsService = productService
        
        //when
        detailPresenter.fetchSizesAndDough()
        
        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //then
            XCTAssertTrue(detailVCSpy.showDoughCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testViewControllerShowProductCalled() {
        let networkClientStub = NetworkClientStub(domainType: .products, emulateError: false)
        let productService = ProductsService(networkClient: networkClientStub)
        let detailVCSpy = DetalViewControllerSpy()
        let detailPresenter = DetailPresenter()
        
        detailVCSpy.presenter = detailPresenter
        detailPresenter.view = detailVCSpy
        detailPresenter.productsService = productService
        
        //when
        let product = Product.empty
        detailPresenter.product = product
        
        //then
        XCTAssertTrue(detailVCSpy.showProductCalled)
    }
}

