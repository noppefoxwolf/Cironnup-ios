//
//  RepostNotificationContent.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit

class RepostNotificationContent: NotificationContentable {
  let notificationType: NotificationType = .repost
  var title: NSAttributedString {
    let user = notifications.last!.actuser!
    let title = NSMutableAttributedString()
    title.append(user.name.withFont(.boldSystemFont(ofSize: 14)))
    if notifications.count > 1 {
      title.append(" and \(notifications.count - 1) others".withFont(.systemFont(ofSize: 14)))
    }
    title.append(" reposted ".withFont(.systemFont(ofSize: 14)))
    title.append("your post.".withFont(.boldSystemFont(ofSize: 14)))
    return title.withTextColor(.white)
  }
  var body: NSAttributedString? {
    return notifications.last!.post!.body.withFont(.systemFont(ofSize: 14)).withTextColor(.lightGray)
  }
  var notifications: [GabKit.Notification] = []
}

