//
//  AddressStorage.swift
//  dodo
//
//  Created by Юлия Ястребова on 12.12.2024.
//

import Foundation

protocol AddressStorageProtocol: AnyObject {
    func save(_ adresses: [String])
    func fetch() -> [String]
    func add(_ address: String) -> [String]
    func fetchLastAddress() -> String
}

class AddressStorage: AddressStorageProtocol {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let key = "Address"
    
    func save(_ adresses: [String]) {
        do {
            let data = try encoder.encode(adresses)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func fetch() -> [String] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode(Array<String>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
    func add(_ address: String) -> [String] {
        var addresses = fetch()
        
        if let index = addresses.firstIndex(where: { $0 == address }) {
            addresses.remove(at: index)
        }
        
        addresses.append(address)
        save(addresses)

        return addresses
    }
    
    func fetchLastAddress() -> String {
        let address = fetch().last ?? ""
        return address
    }
}
