//
//  NetworkClientStub.swift
//  dodoTests
//
//  Created by Юлия Ястребова on 25.04.2024.
//

//import Foundation
//@testable import dodo
//
//final class NetworkClientStub: NetworkClientProtocol {
//    
//    enum DomainType {
//        case products
//        case categories
//        case stories
//        case order
//    }
//
//    enum StubError: Error {
//        case testError
//    }
//    
//    var emulateError: Bool
//    var domainType: DomainType
//    
//    init(domainType: DomainType, emulateError: Bool) {
//        self.domainType = domainType
//        self.emulateError = emulateError
//    }
//    
//    func fetch(url: URL, completion: @escaping (Result<Data, any Error>) -> Void) {
//        
//        if emulateError {
//            completion(.failure(StubError.testError))
//        } else {
//            completion(.success(response))
//        }
//    }
//    
//    private var response: Data {
//        
//        switch domainType {
//        case .products:
//            let fileURL = URL(fileURLWithPath: "/Users/ju_yastrebova/Desktop/project-base/dodo/Resources/Products.json")
//            do {
//                let data = try Data(contentsOf: fileURL)
//                return data
//            } catch {
//                print("Ошибка при чтении данных из файла:", error)
//            }
//        case .categories:
//            let fileURL = URL(fileURLWithPath: "/Users/ju_yastrebova/Desktop/project-base/dodo/Resources/Products.json")
//            do {
//                let data = try Data(contentsOf: fileURL)
//                return data
//            } catch {
//                print("Ошибка при чтении данных из файла:", error)
//            }
//        case .stories:
//            let fileURL = URL(fileURLWithPath: "/Users/ju_yastrebova/Desktop/project-base/dodo/Resources/Stories.json")
//            do {
//                let data = try Data(contentsOf: fileURL)
//                return data
//            } catch {
//                print("Ошибка при чтении данных из файла:", error)
//            }
//        case .order:
//            let data = UserDefaults.standard.data(forKey: "Products")
//        }
//        return Data()
//    }
//}
//
