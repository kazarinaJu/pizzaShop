//
//  Storie.swift
//  dodo
//
//  Created by Юлия Ястребова on 20.02.2024.
//

struct StorieResponse: Codable {
    let stories: [Storie]
}

struct Storie: Codable {
    let id: UInt
    let image: String
    var readability: Bool
}
