//
//  Storie.swift
//  dodo
//
//  Created by Юлия Ястребова on 20.02.2024.
//

struct StorieResponse: Decodable {
    let stories: [Storie]
}

struct Storie: Decodable {
    let id: UInt
    let image: String
    let readability: Bool
}
