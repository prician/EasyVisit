//
//  UITabBarExtension.swift
//  Easyvisit
//
//  Created by WSH on 2022/4/21.
//

import Foundation
import UIKit

extension UITabBarItem {
    
    func setFor(_ title: String?, image: UIImage?, selectedImage: UIImage?) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
    }
}
