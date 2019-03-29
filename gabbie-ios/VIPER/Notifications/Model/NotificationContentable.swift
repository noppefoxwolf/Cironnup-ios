//
//  LikeNotificationGroup.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit

protocol NotificationContentable {
  var notificationType: NotificationType { get }
  var title: NSAttributedString { get }
  var body: NSAttributedString? { get }
  var notifications: [GabKit.Notification] { get set }
}

