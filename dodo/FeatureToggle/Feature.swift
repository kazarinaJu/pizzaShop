//
//  FeatureToggle.swift
//  dodo
//
//  Created by Юлия Ястребова on 24.08.2024.
//

import Foundation

public struct FeatureResponse: Codable {
    let features: [Feature]
}

public struct Feature: Codable {
    let name: String
    var enabled: Bool
}
