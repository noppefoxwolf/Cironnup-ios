//
//  NotificationBanner.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import NotificationBanner

struct InAppNotification {
  static func success(_ title: String, subtitle: String? = nil) {
    show(title: title, subtitle: subtitle, style: .success)
  }
  
  static func error(_ error: Error) {
    debugPrint("####################")
    debugPrint(error)
    debugPrint("####################")
    show(title: String(describing: error), subtitle: nil, style: .danger)
  }
  
  static func show(title: String, subtitle: String? = nil, style: BannerStyle) {
    DispatchQueue.main.async {
      NotificationBanner(title: title, subtitle: subtitle, style: .danger).show()
    }
  }
}
