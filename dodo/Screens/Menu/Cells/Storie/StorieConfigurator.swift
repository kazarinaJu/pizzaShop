//
//  StorieConfigurator.swift
//  dodo
//
//  Created by Юлия Ястребова on 23.12.2024.
//

import UIKit
import DodoNetworkLayer

final class StorieConfigurator {
    func configure(_ stories: [Storie], _ di: DependencyContainer, _ currentIndex: Int) -> StorieVC {
        
        let storieVC = StorieVC()
        let storiePresenter = StoriePresenter(stories: stories, currentIndex: currentIndex)
        
        storieVC.presenter = storiePresenter
        storiePresenter.view = storieVC
        
        storiePresenter.storiesService = di.storiesService
        storiePresenter.stories = stories
        
        return storieVC
    }
}
