//
//  ProductsServiceTests.swift
//  dodoTests
//
//  Created by Юлия Ястребова on 01.05.2024.
//

import XCTest
@testable import dodo
import Foundation

final class ProductsServiceTests: XCTestCase {
    
    class ProductServiceSpy: ProductsServiceProtocol {
        
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
    
    func testServiceFetchProductsCalled() {
        let menuPresenter = MenuPresenter()
        let productService = ProductServiceSpy()
        
        menuPresenter.productsService = productService
        
        //when
        menuPresenter.fetchProducts()
        
        //then
        XCTAssertTrue(productService.fetchProductsCalled)
    }
    
    func testServiceFetchCategoriesCalled() {
        let menuPresenter = MenuPresenter()
        let productService = ProductServiceSpy()
        menuPresenter.productsService = productService
        
        //when
        menuPresenter.fetchCategories()
        
        //then
        XCTAssertTrue(productService.fetchCategoriesCalled)
    }
    
    func testServiceFetchIngredientsCalled() {
        let detailPresenter = DetailPresenter()
        let productService = ProductServiceSpy()
        detailPresenter.productsService = productService
        
        //when
        detailPresenter.fetchIngredients()
        
        //then
        XCTAssertTrue(productService.fetchIngredientsCalled)
    }
    
    func testServiceFetchSizesAndDoughCalled() {
        let detailPresenter = DetailPresenter()
        let productService = ProductServiceSpy()
        detailPresenter.productsService = productService
        
        //when
        detailPresenter.fetchSizesAndDough()
        
        //then
        XCTAssertTrue(productService.fetchSizesAndDoughCalled)
    }
}
