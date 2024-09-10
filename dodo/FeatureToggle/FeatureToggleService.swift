//
//  FeatureToggleService.swift
//  dodo
//
//  Created by Юлия Ястребова on 24.08.2024.
//

import Foundation

class FeatureToggleService {
    
    static let shared = FeatureToggleService()
    
    private var localFeatureResponse: FeatureResponse?
    private var remoteFeatureResponse: FeatureResponse?
    
    //чтение локального json
    func fetchLocalFeatureToggles(completion: @escaping ([Feature]?) -> Void) {
        if let path = Bundle.main.path(forResource: "localFeatureToggles", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                self.localFeatureResponse = try JSONDecoder().decode(FeatureResponse.self, from: data)
                let features = localFeatureResponse?.features
                DispatchQueue.main.async {
                    completion(features)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //загрузка json файла с сервера
    
    func fetchRemoteFeatureToggles(completion: @escaping ([Feature]?) -> Void) {
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
    
    //надо сравнить файлы?
    func compareToggles() -> Bool {
        guard let localFeatures = localFeatureResponse?.features,
              let remoteFeatures = remoteFeatureResponse?.features else {
            return false
        }
        return localFeatures.elementsEqual(remoteFeatures, by: {
            $0.name == $1.name && $0.enabled == $1.enabled
        })
    }
    
    //обновить локальный файл
    func updateLocalFeatureToggles(with featureToggles: [Feature]) {
        let featureResponse = FeatureResponse(features: featureToggles)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(featureResponse)
            if let path = Bundle.main.path(forResource: "localFeatureToggles", ofType: "json") {
                let url = URL(fileURLWithPath: path)
                try data.write(to: url)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
