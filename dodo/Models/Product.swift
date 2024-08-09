//
//  Product.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.01.2024.
//

struct ProductResponse: Codable {
    let ingredients: [Ingredient]
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
    let category: ProductSection
    let isPromo: Bool?
    
    func sizeIndex(_ size: String) -> Int {
        switch size {
        case "Большая": return 2
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
    
    static var empty: Product {
        return Product(id: 0, name: "", detail: "", description: "", weight: 0, price: 0, image: "", portion: 0, isOnSale: false, category: .pizza, isPromo: false)
    }
}

struct Ingredient: Codable {
    let id: UInt
    let image, name: String
    let price: Int
}

enum ProductSection: String, Codable, CaseIterable {
    case pizza
    case combo
    case snack
    case drink
    case desert
    case souce
    
    var description: String {
        switch self {
        case .pizza: return "Пицца"
        case .combo: return "Комбо"
        case .snack: return "Закуски"
        case .drink: return "Напитки"
        case .desert: return "Десерты"
        case .souce: return "Соусы"
        }
    }
}

extension ProductSection {
    static func from(description: String) -> ProductSection? {
        return ProductSection.allCases.first { $0.description == description }
    }
}



