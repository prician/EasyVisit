//
//  TabBarController.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import Foundation
import UIKit

func tabBar() ->UITabBarController {
    let tabBarController = UITabBarController()
    
    let FirVC = FirstTabViewController()
    let ReturnVC = ReturnVisitViewController()
    let MineVC = MineViewController()

    let FirNavi = UINavigationController(rootViewController: FirVC)
    let ReturnNavi = UINavigationController(rootViewController: ReturnVC)
    let MineNavi = UINavigationController(rootViewController: MineVC)

    let viewControllers = [FirNavi, ReturnNavi, MineNavi]

    tabBarController.viewControllers = viewControllers
    guard let items = tabBarController.tabBar.items else{ return tabBarController }
    items[0].setFor("First", image: nil, selectedImage: nil)
    items[1].setFor("Return", image: nil, selectedImage: nil)
    items[2].setFor("Mine", image: nil, selectedImage: nil)
    tabBarController.tabBar.barTintColor = UIColor.white
    
    return tabBarController
}
