//
//  LocalTogglesService.swift
//  dodo
//
//  Created by Юлия Ястребова on 29.08.2024.
//

import Foundation

class LocalTogglesService {
    
    static let shared = LocalTogglesService()
    
    private var featuresStore: [String: Feature] = [:]
    
    var isMapAvailable: Bool {
        
        guard let feature = featuresStore[FeatureType.map.rawValue] else { return false }
        return feature.enabled
    }
    
    private init() {
        fetchLocalFeatureToggles { features in
            for feature in features {
                self.featuresStore[feature.name] = feature
            }
        }
    }
    
    private func fetchLocalFeatureToggles(completion: @escaping ([Feature]) -> Void) {
        if let path = Bundle.main.path(forResource: "localFeatureToggles", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(FeatureResponse.self, from: data)
                let features = response.features
                DispatchQueue.main.async {
                    completion(features)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func update(feature: Feature) {
        var toggledFeature = feature
        toggledFeature.enabled.toggle()
        
        featuresStore[feature.name] = toggledFeature
    }
    
    func getLocalFeatures() -> [Feature] {
        let array = featuresStore.values.sorted { $0.name < $1.name }
        return array
    }
}
