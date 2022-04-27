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
    items[0].setFor(nil, image: UIImage(named: "tab_first"), selectedImage: nil)
    items[1].setFor(nil, image: UIImage(named: "tab_return"), selectedImage: nil)
    items[2].setFor(nil, image: UIImage(named: "tab_mine"), selectedImage: nil)
    tabBarController.tabBar.tintColor = UIColor(red: 0.345, green: 0.373, blue: 0.867, alpha: 1)
    tabBarController.tabBar.barTintColor = UIColor.white
    
    items[0].imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -30, right: 0)
    items[1].imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -30, right: 0)
    items[2].imageInsets = UIEdgeInsets(top: 3, left: 3, bottom: -30, right: 0)
    
    return tabBarController
}
