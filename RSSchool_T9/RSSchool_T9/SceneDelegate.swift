//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Uladzislau Volchyk
// On: 23.07.21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let tabBarController = createTabBarController()
        window.rootViewController = tabBarController
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

func createTabBarController() -> UITabBarController {
    let tabBarController = UITabBarController()
    
    let itemsVC = ItemsViewController()
    itemsVC.tabBarItem = UITabBarItem(title: "Items", image: UIImage(systemName:"square.grid.2x2"), tag: 0)
    tabBarController.viewControllers = [itemsVC]
    
    tabBarController.tabBar.tintColor = .red
    
    return tabBarController
}
