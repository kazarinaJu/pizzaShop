//
//  ProductsService.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.01.2024.
//
import Foundation

protocol ProductsServiceProtocol: AnyObject {
    func fetchProducts(completion: @escaping ([Product]) -> Void)
    func fetchCategories() -> [String]
    func fetchIngredients(completion: @escaping ([Ingredient]) -> Void)
    func fetchSizesAndDough(completion: @escaping ([String]?, [String]?) -> Void)
}

class ProductsService: ProductsServiceProtocol {
    
    private let networkClient: NetworkClientProtocol
    private let decoder: JSONDecoder
    
    init(networkClient: NetworkClientProtocol, decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    
    private var productsUrl: URL {
        guard let url = URL(string: "http://localhost:3001/products") else {
            preconditionFailure("Unable to construct url")
        }
        return url
    }
    
    func fetchProducts(completion: @escaping ([Product]) -> Void) {
        
        networkClient.fetch(url: productsUrl) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                do {
                    let productResponse = try decoder.decode(ProductResponse.self, from: data)
                    let products = productResponse.products
                    
                    DispatchQueue.main.async {
                        completion(products)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCategories() -> [String] {
        return ProductSection.allCases.map { $0.description }
    }
    
    func fetchIngredients(completion: @escaping ([Ingredient]) -> Void) {
        
        networkClient.fetch(url: productsUrl) { [self] result in
            switch result {
            case .success(let data):
                do {
                    let ingredientResponse = try decoder.decode(ProductResponse.self, from: data)
                    let ingredients = ingredientResponse.ingredients
                    
                    DispatchQueue.main.async {
                        completion(ingredients)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchSizesAndDough(completion: @escaping ([String]?, [String]?) -> Void) {
        networkClient.fetch(url: productsUrl) { [self] result in
            switch result {
            case .success(let data):
                do {
                    let productResponse = try decoder.decode(ProductResponse.self, from: data)
                    let sizes = productResponse.sizes
                    let dough = productResponse.dough
                    DispatchQueue.main.async {
                        completion(sizes, dough)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
