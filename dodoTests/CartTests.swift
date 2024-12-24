//
//  CartTests.swift
//  dodoTests
//
//  Created by Юлия Ястребова on 01.05.2024.
//

import XCTest
@testable import dodo
import Foundation

final class CartTests: XCTestCase {
    
    class CartViewControllerSpy: CartVCProtocol {
        var presenter: CartPresenterProtocol?
        
        var showProductsCalled = false
        var showCartCalled = false
        
        func showProducts(_ products: [dodo.Product]) {
            showProductsCalled = true
        }
        
        func showCart(_ totalPrice: Int, _ totalProducts: Int) {
            showCartCalled = true
        }
    }
    
    class CartPresenterSpy: CartPresenterProtocol {
        var view: CartVCProtocol?
        
        var totalPrice = 0
        var totalProducts = 0
        
        var viewWillAppearCalled = false
        var productCountChangedCalled = false
        var updateCartCalled = false
        
        func viewWillAppear() {
            viewWillAppearCalled = true
        }
        
        func productCountChanged(_ products: inout [dodo.Product], _ changedProduct: dodo.Product) {
            productCountChangedCalled = true
        }

        func updateCart() {
            updateCartCalled = true
        }
        
        func fetchOrderProducts() {
            
        }
        
        func fetchTotalCountAndPrice() {
            
        }
    }
    
    func testViewControllerShowProductsCalled() {
    
        let networkClientStub = NetworkClientStub(domainType: .order, emulateError: false)
        let orderService = OrdersStorage(networkClient: networkClientStub)
        let cartVCSpy = CartViewControllerSpy()
        let cartPresenter = CartPresenter()
        
        cartVCSpy.presenter = cartPresenter
        cartPresenter.view = cartVCSpy
        cartPresenter.ordersService = orderService

        //when
        cartPresenter.fetchOrderProducts()
        
        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //then
            XCTAssertTrue(cartVCSpy.showProductsCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testViewControllerShowCartCalled() {
    
        let networkClientStub = NetworkClientStub(domainType: .order, emulateError: false)
        let orderService = OrdersStorage(networkClient: networkClientStub)
        let cartVCSpy = CartViewControllerSpy()
        let cartPresenter = CartPresenter()
        
        cartVCSpy.presenter = cartPresenter
        cartPresenter.view = cartVCSpy
        cartPresenter.ordersService = orderService

        //when
        cartPresenter.updateCart()
        
        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            //then
            XCTAssertTrue(cartVCSpy.showCartCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
    
    func testViewPresenterCallsViewWillAppear() {
        //given
        let cartVC = CartVC()
        let presenter = CartPresenterSpy()
        
        cartVC.presenter = presenter
        presenter.view = cartVC
        
        //when
        cartVC.viewWillAppear(false)
        
        //then
        XCTAssertTrue(presenter.viewWillAppearCalled)
    }
    
    func testPresenterCallsProductCountChanged() {
        //given
        let cartVC = CartVC()
        let cartPresenter = CartPresenterSpy()
        
        cartVC.presenter = cartPresenter
        cartPresenter.view = cartVC
        
        let changedProduct = Product.empty
        
        //when
        let _ = cartVC.productCountChangedHappened(changedProduct)
        
        //then
        XCTAssertTrue(cartPresenter.productCountChangedCalled)
    }
    
    func testPresenterCallsUpdateCart() {
        //given
        let cartVC = CartVC()
        let cartPresenter = CartPresenterSpy()
        
        cartVC.presenter = cartPresenter
        cartPresenter.view = cartVC
        
        //when
        let _ = cartVC.cartUpdated()
        
        //then
        XCTAssertTrue(cartPresenter.updateCartCalled)
    }
}
