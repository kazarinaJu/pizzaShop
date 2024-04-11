//
//  StoriesService.swift
//  dodo
//
//  Created by Юлия Ястребова on 20.02.2024.
//

import Foundation

class StoriesService {
    func fetchStories(completion: @escaping ([Storie]) -> Void) {
        let session = URLSession.shared
        //guard let url = URL.init(string: "https://run.mocky.io/v3/efdcbce2-da10-4595-a8df-43033a069fb7") else { return }
        guard let url = URL.init(string: "https://mocki.io/v1/a7946a78-0178-4eb0-b3ce-3ee0612cc6f0") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder.init()
            
            do {
                let storieResponse = try decoder.decode(StorieResponse.self, from: data)
                let stories = storieResponse.stories
                
                DispatchQueue.main.async {
                    completion(stories)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
     



