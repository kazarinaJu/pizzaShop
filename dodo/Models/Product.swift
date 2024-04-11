//
//  Product.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.01.2024.
//

struct ProductResponse: Codable {
    let ingredients: [Ingredient]
    let categories: [Category]
    let sizes, dough: [String]
    let products: [Product]
}

struct Product: Codable {
    let id: UInt
    let name: String
    let detail: String
    let description: String
    let weight: Int
    var price: Int
    let image: String
    let portion: Int?
    var size: String?
    var dough: String?
    let isOnSale: Bool
    var count: Int = 1
    
    func sizeIndex(_ size: String) -> Int {
        switch size {
        case "Большая": return 2
        //case "Средняя": return 1
        case "Маленькая": return 0
        default: return 1
        }
    }
    
    func doughIndex(_ dough: String) -> Int {
        switch dough {
        case "Тонкое": return 1
        default: return 0
        }
    }
}

struct Ingredient: Codable {
    let id: UInt
    let image, name: String
    let price: Int
}

struct Category: Codable {
    let id: UInt
    let name: String
    let indexPath: [Int]
}
