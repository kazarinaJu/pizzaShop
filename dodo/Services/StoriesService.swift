//
//  StoriesService.swift
//  dodo
//
//  Created by Юлия Ястребова on 20.02.2024.
//

import Foundation

protocol StoriesServiceProtocol: AnyObject {
    func fetchStories(completion: @escaping ([Storie]) -> Void)
}

class StoriesService: StoriesServiceProtocol {
    private let networkClient: NetworkClientProtocol
    private let decoder: JSONDecoder
    
    init(networkClient: NetworkClientProtocol, decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    
    private var storiesUrl: URL {
        guard let url = URL(string: "https://mocki.io/v1/a7946a78-0178-4eb0-b3ce-3ee0612cc6f0") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    
    func fetchStories(completion: @escaping ([Storie]) -> Void) {
        networkClient.fetch(url: storiesUrl) { [self] result in
            switch result {
            case .success(let data):
                do {
                    let storieResponse = try decoder.decode(StorieResponse.self, from: data)
                    let stories = storieResponse.stories
                    
                    DispatchQueue.main.async {
                        completion(stories)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
     



