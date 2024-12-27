//
//  LoginCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    
    var finishAuth: ((Bool)->())?
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showLoginVC()
    }
    
    func showLoginVC() {
        let loginScreen = screenFactory.makeLoginScreen()
        
        loginScreen.onPhoneButtonTapped = {
            self.showPhoneVC()
        }
        router.present(loginScreen, animated: true, onRoot: true, fullScreen: false)
    }
    
    func showPhoneVC() {
        let phoneScreen = screenFactory.makePhoneScreen()
        
        phoneScreen.onContinueButtonTapped = {
            self.showCodeVC()
        }
        router.present(phoneScreen, animated: true, onRoot: false, fullScreen: false)
    }
    
    func showCodeVC() {
        let codeScreen = screenFactory.makeCodeScreen()
        
        codeScreen.onUserLoggedIn = { isLoaded in
            self.router.dismissModule()
            self.finishAuth?(true)
        }
        router.present(codeScreen, animated: true, onRoot: false, fullScreen: false)
    }
}
