//
//  MapCoordinator.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.10.2024.
//

import Foundation
import UIKit

class MapCoordinator: Coordinator {
    
    private let router: Router
    private let screenFactory: ScreenFactoryProtocol
    
    init(router: Router, screenFactory: ScreenFactoryProtocol) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        showMap()
    }
    
    private func showMap() {
        let mapScreen = screenFactory.makeMapScreen()
        
        mapScreen.addressPanelView.onAddressSaved = { address in
            let navVC = mapScreen.presentingViewController as! UINavigationController
            
            if let menuVC = navVC.viewControllers.first as? MenuVC {
                menuVC.updateAddress(address)
                mapScreen.dismiss(animated: true)
            }
        }
        
        mapScreen.addressPanelView.onAddressTap = { [self] in
            let addressScreen = screenFactory.makeAddressScreen()
            addressScreen.onAddressSelected = { selectedAddress in
                mapScreen.addressPanelView.update(selectedAddress)
                mapScreen.showAddressOnMap(selectedAddress)
                addressScreen.dismiss(animated: true)
            }
            router.present(addressScreen, animated: true, onRoot: false, fullScreen: false)
        }
        router.present(mapScreen, animated: true, onRoot: true, fullScreen: false)
    }
}
