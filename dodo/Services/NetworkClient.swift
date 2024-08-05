//
//  NetworkService.swift
//  dodo
//
//  Created by Юлия Ястребова on 19.04.2024.
//

import Foundation

enum NetworkError: Error {
    case statusCode
    case parsingModel
    case url
}

protocol NetworkClientProtocol {
    func fetch(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
    
    func fetch(url: URL) async -> Result<Data, Error>
}

struct NetworkClient: NetworkClientProtocol {
    
    
    func fetch(url: URL) async -> Result<Data, Error>  {
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return .success(data)
        } catch {
            print(error)
            return .failure(NetworkError.statusCode)
        }
    }
    
    func fetch(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                
                completion(.failure(NetworkError.statusCode))
                return
            }
            
            guard let data = data else { return }
            completion(.success(data))
        }
        task.resume()
    }
}
