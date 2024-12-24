//
//  OrdersService.swift
//  dodo
//
//  Created by Юлия Ястребова on 26.02.2024.
//

import Foundation

protocol OrdersStorageProtocol: AnyObject {
    func save(_ products: [Product])
    func fetch() -> [Product]
    func add(_ product: Product) -> [Product]
    func delete(_ product: Product) -> [Product]
    func calculateTotalPrice() -> Int
    func calculateTotalCount() -> Int
}

class OrdersStorage: OrdersStorageProtocol {
    private let networkClient: NetworkClientProtocol
    private let decoder: JSONDecoder
    
    init(networkClient: NetworkClientProtocol, decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    
    private let encoder = JSONEncoder()
   // private let decoder = JSONDecoder()
    
    private let key = "Products"
    
    func save(_ products: [Product]) {
        do {
            let data = try encoder.encode(products)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func fetch() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode(Array<Product>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
    @discardableResult
    func add(_ product: Product) -> [Product] {
        var products = fetch()
        
        if let index = products.firstIndex(where: { $0.id == product.id } ) {
            products[index].count += 1
        } else {
            products.append(product)
        }
        
        save(products)
        return products
    }
    
    func delete(_ product: Product) -> [Product] {
        var products = fetch()
        products.removeAll(where: { $0.id == product.id })
        if let index = products.firstIndex(where: { $0.id == product.id } ) {
            products[index].count -= 1
            
            if products.count <= 0 {
                products.remove(at: index)
            }
        }
        save(products)
        return products
    }
    
    func calculateTotalPrice() -> Int {
        let products = fetch()
        var totalPrice = 0
        
        for product in products {
            totalPrice += product.count * product.price
        }
        return totalPrice
    }
    
    func calculateTotalCount() -> Int {
        let products = fetch()
        var totalCount = 0
        
        for product in products {
            totalCount += product.count
        }
        return totalCount
    }
}
