//
//  SettingsRouter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import Router

class SettingsRouter: SettingsRouterInput {
  func pushSettingMenu(_ settingMenu: AnySettingMenu<String>, view: SettingsViewInput) {
    guard let from = view as? UIViewController else { return }
    Router.default.navigate(GabNavigation.settingMenu(settingMenu), from: from)
  }
  func openAppStore() {
    let url = URL(string: "https://itunes.apple.com/us/app/id1439010121?mt=8&action=write-review")!
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
  func openContactUs() {
    let url = URL(string: "https://gab.com/noppe")!
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
  func pushTipJar(view: SettingsViewInput) {
    guard let from = view as? UIViewController else { return }
    Router.default.navigate(GabNavigation.tipjar, from: from)
  }
}
