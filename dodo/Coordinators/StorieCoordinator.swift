//
//  StroieCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 19.12.2024.
//

import Foundation

class StorieCoordinator: Coordinator {
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    func start(_ stories: [Storie], _ currentIndex: Int) {
        showStorie(stories, currentIndex)
    }
    
    private func showStorie(_ stories: [Storie], _ currentIndex: Int) {
        let storieScreen = screenFactory.makeStoriesScreen(stories, currentIndex)
        router.push(storieScreen, animated: false)
        
        storieScreen.onStorieWatched = {
            self.router.popModule(animated: false)
        }
    }
}
