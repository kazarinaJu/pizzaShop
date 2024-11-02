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
    //private let userService: UserServiceProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
//        if userService.isUserLoggedIn() {
//            showProfileVC()
//        } else {
//            showLoginVC()
//        }
        showLoginVC()
        
    }
    
    private func showLoginVC() {
        let loginScreen = screenFactory.makeLoginScreen()
        
        loginScreen.onPhoneButtonTapped = {
            self.showPhoneVC()
        }
        
        router.present(loginScreen, animated: true, onRoot: true)
    }
    
    func showPhoneVC() {
        let phoneScreen = screenFactory.makePhoneScreen()
        
        phoneScreen.onContinueButtonTapped = {
            print("onContinueButtonTapped triggered in PhoneVC")
            self.showCodeVC()
        }
        
        router.present(phoneScreen, animated: true, onRoot: false)
    }
    
    func showCodeVC() {
        let codeScreen = screenFactory.makeCodeScreen()
        print("Создан экземпляр CodeVC: \(codeScreen)")
        
        codeScreen.onUserLoggedIn = { [weak self] isLoaded in
            guard let self = self else { return }
            print("onUserLoggedIn closure triggered with:", isLoaded)
            self.finishAuth?(true)
        }
        
        router.present(codeScreen, animated: true, onRoot: false)
        print("onUserLoggedIn set for CodeVC")
    }
}
