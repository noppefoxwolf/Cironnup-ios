//
//  SettingsRouterInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation

protocol SettingsRouterInput {
  func pushSettingMenu(_ settingMenu: AnySettingMenu<String>, view: SettingsViewInput)
  func openAppStore()
  func openContactUs()
  func pushTipJar(view: SettingsViewInput)
}
