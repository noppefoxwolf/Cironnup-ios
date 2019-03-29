//
//  TabBarController.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.barTintColor = ColorName.navigationTintColor.color
    tabBar.isTranslucent = false
    tabBar.isOpaque = true
    tabBar.tintColor = ColorName.buttonTintColor.color
    tabBar.unselectedItemTintColor = .white
  }
}
