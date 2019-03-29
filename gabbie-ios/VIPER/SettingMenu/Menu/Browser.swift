//
//  Browser.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/29.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

struct BrowserSetting: SettingMenu {
  let key: String = "com.noppelab.cironnup.browser"
  let title = "Browser"
  let items = BrowserSettingMenuItem.allCases.map(AnySettingMenuItem.init)
  var defaultItem: AnySettingMenuItem<String> { return items[0] }
}

enum BrowserSettingMenuItem: String, SettingMenuItem, CaseIterable {
  case cironnup = "com.noppelab.cironnup.browser.cironnup"
  case chrome = "com.noppelab.cironnup.browser.chrome"
  case safari = "com.noppelab.cironnup.browser.safari"
  
  var title: String {
    switch self {
    case .cironnup: return "Cironnup"
    case .chrome: return "Google Chrome"
    case .safari: return "Mobile Safari"
    }
  }
  var value: String { return rawValue }
}
