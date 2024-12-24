//
//  MenuCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation
import FirebaseAuth
import UIKit

class MenuCoordinator: Coordinator {
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        
        let menuScreen = screenFactory.makeMenuScreen()
        
        menuScreen.onDetailCellTapped = { product in
            self.showDetail(product)
        }
        
        menuScreen.onCartButtonTapped = {
            self.showCart()
        }
        
        menuScreen.onMapButtonTapped = {
            self.showMap()
        }
        
        menuScreen.onLoginButtonTapped = {
            self.runLoginFlow()
        }
        
        menuScreen.onStorieSelected = { stories, index in
            self.runStorieFlow(stories, index)
        }
        
        router.setRootModule(menuScreen, hideBar: true)
    }
    
    func showDetail(_ product: Product) {
        let detailScreen = screenFactory.makeDetailScreen(with: product)
        router.present(detailScreen, animated: true, onRoot: true )
    }
    
    func showCart() {
        let cartScreen = screenFactory.makeCartScreen()
        router.present(cartScreen, animated: true, onRoot: true)
    }
    
    func showMap() {
        let mapScreen = screenFactory.makeMapScreen()
        
        mapScreen.addressPanelView.onAddressSaved = { address in
           
            let navVC = mapScreen.presentingViewController as! UINavigationController
            
            print(navVC.viewControllers.first)
           if let menuVC = navVC.viewControllers.first as? MenuVC {
                print(menuVC)
               menuVC.updateAddress(address)
               mapScreen.dismiss(animated: true)
            }
            
            
            print(mapScreen.presentingViewController)
            print(mapScreen.presentationController)
        }
        
        router.present(mapScreen, animated: true, onRoot: true)
    }
    
    func runLoginFlow() {
        
        let isFirstAuth = UserDefaults.standard.bool(forKey: "isFirstAuthCompleted")
        
        if Auth.auth().currentUser != nil && isFirstAuth {
            print("Пользователь авторизован")
            runProfileFlow()
        } else {
            print("Первая авторизация")
            let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
            
            self.addDependency(coordinator)
            coordinator.start()
            
            coordinator.finishAuth = { isLoaded in
                
                self.runProfileFlow()
                
                self.removeDependency(coordinator)
            }
        }
    }
    
    func runProfileFlow() {
        let coordinator = coordinatorFactory.makeProfileCoordinator(router: router)
        self.addDependency(coordinator)
        coordinator.start()
        
        coordinator.logsOut = { isLoaded in
            
            self.runLoginFlow()
        }
    }
    
    func runStorieFlow(_ stories: [Storie], _ currentIndex: Int ) {
        let coordinator = coordinatorFactory.makeStorieCoordinator(router: router)
        self.addDependency(coordinator)
        coordinator.start(stories, currentIndex)
    }
}
