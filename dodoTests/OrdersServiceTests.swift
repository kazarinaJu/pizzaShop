//
//  OrdersServiceTests.swift
//  dodoTests
//
//  Created by Юлия Ястребова on 01.05.2024.
//

import XCTest
@testable import dodo
import Foundation

final class OrdersServiceTests: XCTestCase {
    
    class OrdersServiceSpy: OrdersServiceProtocol {
        
        func save(_ products: [dodo.Product]) {

        }
        
        func fetch() -> [dodo.Product] {
            return []
        }
        
        func add(_ product: dodo.Product) -> [dodo.Product] {
            return []
        }
        
        func delete(_ product: dodo.Product) -> [dodo.Product] {
            return []
        }
        
        func calculateTotalPrice() -> Int {
            return 0
        }
        
        func calculateTotalCount() -> Int {
            return 0
        }
        
    }
}
