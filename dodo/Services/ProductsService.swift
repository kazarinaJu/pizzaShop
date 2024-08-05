//
//  ProductsService.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.01.2024.
//
import Foundation

protocol ProductsServiceProtocol: AnyObject {
    
    func fetchProducts() async throws -> [Product]
    func fetchCategories() async throws -> [Category]
    func fetchIngredients() async throws -> [Ingredient]
    func fetchSizesAndDough() async throws -> ([String]?, [String]?)
    
    //func fetchProducts(completion: @escaping ([Product]) -> Void)
    //func fetchCategories(completion: @escaping ([Category]) -> Void)
    //func fetchIngredients(completion: @escaping ([Ingredient]) -> Void)
    //func fetchSizesAndDough(completion: @escaping ([String]?, [String]?) -> Void)
}

class ProductsService: ProductsServiceProtocol {

    private let networkClient: NetworkClientProtocol
    private let decoder: JSONDecoder
    
    init(networkClient: NetworkClientProtocol, decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    
    private var productsUrl: URL {
        
        get async throws {
            guard let url = URL(string: "http://localhost:3001/products") else {
                throw NetworkError.url
            }
            return url
        }
    }
    
    func fetchProducts() async throws -> [Product] {
        
        let url = try await productsUrl
        let result = await networkClient.fetch(url:  url)
        
        switch result {
        case .success(let data):
            do {
                let productResponse = try decoder.decode(ProductResponse.self, from: data)
                let products = productResponse.products
                return products
            } catch {
                print(error)
                throw NetworkError.parsingModel
            }
        case .failure(_):
            throw NetworkError.statusCode
        }
    }
    
    func fetchCategories() async throws -> [Category] {
        
        let url = try await productsUrl
        let result = await networkClient.fetch(url:  url)
        
        switch result {
        case .success(let data):
            do {
                let categoryResponse = try decoder.decode(ProductResponse.self, from: data)
                let categories = categoryResponse.categories
                return categories
            } catch {
                print(error)
                throw NetworkError.parsingModel
            }
        case .failure(_):
            throw NetworkError.statusCode
        }
    }
    
    func fetchIngredients() async throws -> [Ingredient] {
        
        let url = try await productsUrl
        let result = await networkClient.fetch(url:  url)
        
        switch result {
        case .success(let data):
            do {
                let ingredientResponse = try decoder.decode(ProductResponse.self, from: data)
                let ingredients = ingredientResponse.ingredients
                return ingredients
            } catch {
                print(error)
                throw NetworkError.parsingModel
            }
        case .failure(_):
            throw NetworkError.statusCode
        }
    }
    
    func fetchSizesAndDough() async throws -> ([String]?, [String]?) {
        
        let url = try await productsUrl
        let result = await networkClient.fetch(url:  url)
        
        switch result {
        case .success(let data):
            do {
                let productResponse = try decoder.decode(ProductResponse.self, from: data)
                let sizes = productResponse.sizes
                let dough = productResponse.dough
                return (sizes, dough)
            } catch {
                print(error)
                throw NetworkError.parsingModel
            }
        case .failure(_):
            throw NetworkError.statusCode
        }
    }
        
        

    
   
    
//    func fetchProducts(completion: @escaping ([Product]) -> Void) {
//        
//        networkClient.fetch(url: productsUrl) { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let data):
//                do {
//                    print(data.prettyPrintedJSONString)
//                    let productResponse = try decoder.decode(ProductResponse.self, from: data)
//                    let products = productResponse.products
//                    
//                    DispatchQueue.main.async {
//                        completion(products)
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
//    func fetchCategories(completion: @escaping ([Category]) -> Void) {
//        networkClient.fetch(url: productsUrl) { [self] result in
//            switch result {
//            case .success(let data):
//                do {
//                    let categoryResponse = try decoder.decode(ProductResponse.self, from: data)
//                    let categories = categoryResponse.categories
//                    
//                    DispatchQueue.main.async {
//                        completion(categories)
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func fetchIngredients(completion: @escaping ([Ingredient]) -> Void) {
//        
//        networkClient.fetch(url: productsUrl) { [self] result in
//            switch result {
//            case .success(let data):
//                do {
//                    let ingredientResponse = try decoder.decode(ProductResponse.self, from: data)
//                    let ingredients = ingredientResponse.ingredients
//                    
//                    DispatchQueue.main.async {
//                        completion(ingredients)
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
//    func fetchSizesAndDough(completion: @escaping ([String]?, [String]?) -> Void) {
//        networkClient.fetch(url: productsUrl) { [self] result in
//            switch result {
//            case .success(let data):
//                do {
//                    let productResponse = try decoder.decode(ProductResponse.self, from: data)
//                    let sizes = productResponse.sizes
//                    let dough = productResponse.dough
//                    DispatchQueue.main.async {
//                        completion(sizes, dough)
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
