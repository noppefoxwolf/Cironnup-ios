//
//  UITabBarItem+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

extension UITabBarItem {
  static func make(image: UIImage) -> UITabBarItem {
    let image = image.resize(to: .init(width: 24, height: 24))!
    let item = UITabBarItem(title: nil, image: image, selectedImage: image)
    item.imageInsets = .init(top: 0, left: 0, bottom: -18, right: 0)
    return item
  }
}

