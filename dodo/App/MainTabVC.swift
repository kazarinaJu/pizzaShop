//
//  MainTabVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.02.2024.
//

import UIKit

class MainTabVC:UITabBarController {
    
    private var menuController: MenuVC = {
        let controller = MenuConfigurator().configure() //MenuVC()
        let tableItem = UITabBarItem(title: "Меню", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        controller.tabBarItem = tableItem
        return controller
    }()
    
    private var mapController: MapVC = {
        let controller = MapVC()
        let tableItem = UITabBarItem(title: "", image: UIImage(systemName: "location"), selectedImage: UIImage(systemName: "location"))
        controller.tabBarItem = tableItem
        return controller
    }()
    
    private var cartController: CartVC = {
        let controller = CartConfigurator().configure()
        let tableItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart"))
        controller.tabBarItem = tableItem
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
}

extension MainTabVC {
    private func setUpTabBar() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.black
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        viewControllers = [menuController, mapController, cartController]
    }
}
