//
//  DadataService.swift
//  dodo
//
//  Created by Юлия Ястребова on 13.02.2025.
//

import Foundation

struct AddressSuggestions: Decodable {
    let suggestions: [Suggestion]
}

struct Suggestion: Decodable {
    let value: String
    let unrestrictedValue: String
    
    enum CodingKeys: String, CodingKey {
        case value
        case unrestrictedValue = "unrestricted_value"
    }
}

final class DadataService {
    private let token = "2e40db9aa1b4327880c064c18bb74c0d23264ffc"
    private var url: URL {
        guard let url = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address") else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    func fetchAddress(_ searchText: String, completion: @escaping ([String]) -> Void) {
        let jsonBody: [String: Any] = [
            "query": searchText
        ]
        
        let header: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Token " + token
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody) else { fatalError("Invalid JSON data") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.allHTTPHeaderFields = header
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else {
                print("Error: No data received")
                completion([])
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(AddressSuggestions.self, from: data)
                let addresses = decodedResponse.suggestions.map { $0.value }
                completion(addresses)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion([])
            }
        }
        task.resume()
    }
}
