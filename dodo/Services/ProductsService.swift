//
//  ProductsService.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.01.2024.
//
import Foundation

class ProductsService {
    
    func fetchProducts(completion: @escaping ([Product])->Void) {
        let session = URLSession.shared
        //guard let url = URL.init(string: "https://run.mocky.io/v3/89c2be83-c3ae-4251-838f-c00073dfa96f") else { return }
        guard let url = URL.init(string: "https://mocki.io/v1/aee8fb44-bbd7-432d-9941-91c79b546c2d") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            print("->", data.prettyPrintedJSONString ?? "error")
            
            let decoder = JSONDecoder.init()
            do {
                let productResponse = try decoder.decode(ProductResponse.self, from: data)
                let products = productResponse.products
                
                DispatchQueue.main.async {
                    completion(products)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        let session = URLSession.shared
        guard let url = URL.init(string: "https://mocki.io/v1/aee8fb44-bbd7-432d-9941-91c79b546c2d") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder.init()
            do {
                let categoryResponse = try decoder.decode(ProductResponse.self, from: data)
                let categories = categoryResponse.categories
                
                DispatchQueue.main.async {
                    completion(categories)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchIngredients(completion: @escaping ([Ingredient]) -> Void) {
        let session = URLSession.shared
        guard let url = URL.init(string: "https://mocki.io/v1/aee8fb44-bbd7-432d-9941-91c79b546c2d") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder.init()
            do {
                let ingredientResponse = try decoder.decode(ProductResponse.self, from: data)
                let ingredients = ingredientResponse.ingredients
                
                DispatchQueue.main.async {
                    completion(ingredients)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchSizesAndDough(completion: @escaping ([String]?, [String]?) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://mocki.io/v1/aee8fb44-bbd7-432d-9941-91c79b546c2d") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
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
        }
        task.resume()
    }
}
