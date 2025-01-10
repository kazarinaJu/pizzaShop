//
//  StoriePresenter.swift
//  dodo
//
//  Created by Юлия Ястребова on 23.12.2024.
//

import UIKit
import DodoNetworkLayer

protocol StoriePresenterProtocol: AnyObject {
    var view: StorieVCProtocol? { get set }
    var stories: [Storie] { get }
    var currentIndex: Int { get set }
    
    func showCurrentImage()
    func goToNextStorie()
    func goToPreviousStorie()
    func dismissStorie()
    func startProgress(for index: Int)
    func stopCurrentProgress(for index: Int)
}

final class StoriePresenter: StoriePresenterProtocol {
    weak var view: StorieVCProtocol?
    var storiesService: StoriesServiceProtocol?
    
    var stories: [Storie] = []
    var currentIndex: Int
    var progressTimers: [Timer?] = []
    
    init(stories: [Storie], currentIndex: Int) {
        self.stories = stories
        self.currentIndex = currentIndex
        self.progressTimers = Array(repeating: nil, count: stories.count)
    }
    
    func viewDidLoad() {
        fetchStories()
    }
    
    func fetchStories() {
        storiesService?.fetchStories { [weak self] stories in
            guard let self = self else { return }
            self.stories = stories
        }
    }
    
    func markStorieAsRead(at index: Int) {
        let story = stories[index]
        if !story.readability {
            stories[index].readability = true
            storiesService?.markAsRead(storyID: story.id)
        }
        view?.onStorieReadable?()
    }
    
    func showCurrentImage() {
        let currentStorie = stories[currentIndex]
        if let image = UIImage(named: currentStorie.image) {
            view?.imageView.image = image
        }
    }
    
    func goToNextStorie() {
        stopCurrentProgress(for: currentIndex)
        markStorieAsRead(at: currentIndex)
        
        if currentIndex < stories.count - 1 {
            currentIndex += 1
            showCurrentImage()
            startProgress(for: currentIndex)
        } else {
            dismissStorie()
        }
    }
    
    func goToPreviousStorie() {
        stopCurrentProgress(for: currentIndex)
        if currentIndex > 0 {
            currentIndex -= 1
            showCurrentImage()
            startProgress(for: currentIndex)
        }
    }
    
    func dismissStorie() {
        markStorieAsRead(at: currentIndex)
        view?.onStorieWatched?()
    }
    
    func startProgress(for index: Int) {
        stopCurrentProgress(for: index)
        
        let duration: TimeInterval = 5.0
        view?.progressViews[index].progress = 0.0
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            let increment = Float(0.05 / duration)
            view?.progressViews[index].progress += increment
            
            if view?.isProgressComplete(for: index) == true {
                timer.invalidate()
                self.goToNextStorie()
            }
        }
        progressTimers[index] = timer
    }
    
    func stopCurrentProgress(for index: Int) {
        progressTimers[index]?.invalidate()
        progressTimers[index] = nil
        view?.resetProgress(for: index)
    }
}
