//
//  dodoUITests.swift
//  dodoUITests
//
//  Created by Юлия Ястребова on 04.05.2024.
//

import XCTest

final class dodoUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testMenuAndDetail() throws {
        let tableMenu = app.tables
        let cell = tableMenu.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        
        sleep(2)
        
        let cellToDetail = tableMenu.children(matching: .cell).element(boundBy: 3)
        cellToDetail.tap()
        
        cellToDetail.waitForExistence(timeout: 5)
        
        
        //app.buttons["Button"].tap()
       
        //закрыть detail свайпом?
        
    }
    
    func testCart() throws {
        app.tabBars.buttons.element(boundBy: 2).tap()
        app.staticTexts["Пока тут пусто"].exists
        
        //нажать на эту ссылку - уйти в меню
        //нажать добавление на странице меню
        //уйти в корзину
    }
    
 
}
