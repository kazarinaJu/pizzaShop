//
//  StoriesServiceTests.swift
//  dodoTests
//
//  Created by Юлия Ястребова on 01.05.2024.
//

import XCTest
@testable import dodo
import Foundation

final class StoriesServiceTests: XCTestCase {
    
    class StoriesServiceSpy: StoriesServiceProtocol {
        var fetchStoriesCalled = false
        
        func fetchStories(completion: @escaping ([dodo.Storie]) -> Void) {
            fetchStoriesCalled = true
        }
    }
    
    func testServiceFetchStoriesCalled() {
        let menuPresenter = MenuPresenter()
        let storiesService = StoriesServiceSpy()
        
        menuPresenter.storiesService = storiesService
        
        //when
        menuPresenter.fetchStories()
        
        //then
        XCTAssertTrue(storiesService.fetchStoriesCalled)
    }
}
