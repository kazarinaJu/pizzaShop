//
//  StoriesService.swift
//  dodo
//
//  Created by Юлия Ястребова on 20.02.2024.
//

import Foundation

protocol StoriesServiceProtocol: AnyObject {
    func fetchStories(completion: @escaping ([Storie]) -> Void)
    func markAsRead(storyID: UInt)
    func fetchReadStories() -> Set<UInt>
}

class StoriesService: StoriesServiceProtocol {
    private let networkClient: NetworkClientProtocol
    private let decoder: JSONDecoder
    
    init(networkClient: NetworkClientProtocol, decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    
    private var storiesUrl: URL {
        guard let url = URL(string: "http://localhost:3001/stories") else {
            preconditionFailure("Unable to construct url")
        }
        return url
    }
    
    private let readStoriesKey = "ReadStories"
    
    func fetchStories(completion: @escaping ([Storie]) -> Void) {
        networkClient.fetch(url: storiesUrl) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                
                do {
                    let storieResponse = try decoder.decode(StorieResponse.self, from: data)
                    var stories = storieResponse.stories
                    
                    let readStories = fetchReadStories()
                    
                    for index in stories.indices {
                        if readStories.contains(stories[index].id) {
                            stories[index].readability = true
                        }
                    }
                    
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
    
    func saveReadStories(_ readStories: Set<UInt>) {
        if let data = try? JSONEncoder().encode(readStories) {
            UserDefaults.standard.set(data, forKey: readStoriesKey)
        }
    }
    
    func markAsRead(storyID: UInt) {
        var readStories = fetchReadStories()
        readStories.insert(storyID)
        saveReadStories(readStories)
    }
    
    func fetchReadStories() -> Set<UInt> {
        guard let data = UserDefaults.standard.data(forKey: readStoriesKey),
              let readStories = try? JSONDecoder().decode(Set<UInt>.self, from: data) else {
            return []
        }
        return readStories
    }
}




