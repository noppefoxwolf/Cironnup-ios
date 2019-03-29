//
//  FollowNotificationContent.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit

class FollowNotificationContent: NotificationContentable {
  let notificationType: NotificationType = .follow
  var title: NSAttributedString {
    let user = notifications.last!.actuser!
    let title = NSMutableAttributedString()
    title.append(user.name.withFont(.boldSystemFont(ofSize: 14)))
    if notifications.count > 1 {
      title.append(" and \(notifications.count - 1) others".withFont(.systemFont(ofSize: 14)))
    }
    title.append(" followed ".withFont(.systemFont(ofSize: 14)))
    title.append("your.".withFont(.boldSystemFont(ofSize: 14)))
    return title.withTextColor(.white)
  }
  var body: NSAttributedString? { return nil }
  var notifications: [GabKit.Notification] = []
}

