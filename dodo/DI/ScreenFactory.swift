//
//  FactoryScreen.swift
//  dodo
//
//  Created by Юлия Ястребова on 30.09.2024.
//

import Foundation
import UIKit

protocol ScreenFactoryProtocol {
    func makeStartScreen() -> StartVC
    func makeLoginScreen() -> LoginVC
    func makePhoneScreen() -> PhoneVC
    func makeCodeScreen() -> CodeVC
    func makeProfileScreen() -> ProfileVC
    func makeMenuScreen() -> MenuVC
    func makeDetailScreen(with product: Product) -> DetailVC
    func makeCartScreen() -> CartVC
    func makeMapScreen() -> MapVC
    func makeStoriesScreen(_ stories: [Storie], _ currentIndex: Int) -> StorieVC
}

final class ScreenFactory: ScreenFactoryProtocol {
    
    weak var di: DependencyContainer!
    
    init(){}
    
    func makeStartScreen() -> StartVC {
        return StartVC()
    }
    
    func makeMenuScreen() -> MenuVC {
        return MenuConfigurator().configure(di)
    }
    
    func makeDetailScreen(with product: Product) -> DetailVC {
        return DetailConfigurator().configure(product, di)
    }
    
    func makeLoginScreen() -> LoginVC {
        return AuthConfigurator().configureLogin()
    }
    func makePhoneScreen() -> PhoneVC {
        return AuthConfigurator().configurePhone()
    }
    
    func makeCodeScreen() -> CodeVC {
        return AuthConfigurator().configureCode()
    }
    
    func makeProfileScreen() -> ProfileVC {
        return ProfileVC()
    }
    
    func makeCartScreen() -> CartVC {
        return CartConfigurator().configure(di)
    }
    
    func makeMapScreen() -> MapVC {
        return MapVC()
    }
    
    func makeStoriesScreen(_ stories: [Storie], _ currentIndex: Int) -> StorieVC {
        return StorieVC(stories: stories, currentIndex: currentIndex)
    }
}
