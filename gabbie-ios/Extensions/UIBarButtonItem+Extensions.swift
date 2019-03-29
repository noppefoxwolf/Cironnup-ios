//
//  UIBarButtonItem+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
  static func make(image: UIImage?, target: Any?, action: Selector?) -> UIBarButtonItem {
    let resizedImage = image?.resize(to: .init(width: 24, height: 24))
    let item = UIBarButtonItem(image: resizedImage, style: .plain, target: target, action: action)
    return item
  }
}
