//
//  MentionNotificationContent.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018年 Tomoya Hirano. All rights reserved.
//

import GabKit

class MentionNotificationContent: NotificationContentable {
  let notificationType: NotificationType = .mention
  var title: NSAttributedString {
    let user = notifications.last!.actuser!
    let title = NSMutableAttributedString()
    title.append(user.name.withFont(.boldSystemFont(ofSize: 14)))
    title.append(" commented on ".withFont(.systemFont(ofSize: 14)))
    title.append("your post.".withFont(.boldSystemFont(ofSize: 14)))
    return title.withTextColor(.white)
  }
  var body: NSAttributedString? {
    return notifications.last!.post!.body.withFont(.systemFont(ofSize: 14)).withTextColor(.lightGray)
  }
  var notifications: [GabKit.Notification] = []
}

