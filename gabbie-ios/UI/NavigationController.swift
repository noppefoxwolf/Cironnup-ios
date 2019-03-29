//
//  NavigationController.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.barTintColor = ColorName.navigationTintColor.color
    navigationBar.isTranslucent = false
    navigationBar.isOpaque = true
    navigationBar.tintColor = .white
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
