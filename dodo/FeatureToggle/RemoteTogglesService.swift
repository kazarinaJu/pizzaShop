//
//  RemoteTogglesService.swift
//  dodo
//
//  Created by Юлия Ястребова on 29.08.2024.
//

import Foundation

enum FeatureType: String {
    case map = "X-101: Map"
    case cart = "X-109: Cart"
}

class RemoteTogglesService {
    
    //var features: [Feature] = []
    private var featuresStore: [String: Feature] = [:]
    
    
    static let shared = RemoteTogglesService()
    
    var isMapAvailable: Bool {
        //        for feature in features {
        //            if feature.name == FeatureType.map.rawValue {
        //                return feature.enabled
        //            }
        //        }
        
        guard let feature = featuresStore[FeatureType.map.rawValue] else { return false }
        return feature.enabled
    }
    
    private init() {
        fetchToggles { features in
            for feature in features {
                self.featuresStore[feature.name] = feature
            }
            //self.features = features
        }
    }
    
    func fetchToggles(completion: @escaping ([Feature]) -> Void) {
        guard let url = URL(string: "http://localhost:3001/featureToggles") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let remoteFeatureResponse = try JSONDecoder().decode(FeatureResponse.self, from: data)
                let features = remoteFeatureResponse.features
                DispatchQueue.main.async {
                    completion(features)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getRemotefeatures() -> [Feature] {
        return featuresStore.values.sorted { $0.name < $1.name }
    }
}
