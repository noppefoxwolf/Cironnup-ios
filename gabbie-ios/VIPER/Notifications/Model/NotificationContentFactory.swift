//
//  NotificationContentFactory.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit
import SwiftDate

enum NotificationContentKey: Hashable {
  case like(postID: Int, date: Date)
  case repost(postID: Int, date: Date)
  case follow(date: Date)
  case mention(notificationID: String, date: Date)
}

extension NotificationContentable {
  var newestDate: Date {
    return notifications.compactMap({ $0.createdAt }).max() ?? Date()
  }
}

final class NotificationContentFactory {
  private(set) var notificationContents: [NotificationContentKey : NotificationContentable] = [:]
  
  func append(notification: GabKit.Notification) {
    switch notification.type {
    case .like:
      appendOrCreateContentForLike(notification)
    case .follow:
      appendOrCreateContentForFollow(notification)
    case .repost:
      appendOrCreateContentForRepost(notification)
    case .mention:
      appendOrCreateContentForMention(notification)
    case .unknown(let type):
      debugPrint("Unkonwn Notification Type: \(type)")
    }
  }
  
  private func appendOrCreateContentForLike(_ notification: GabKit.Notification) {
    guard let post = notification.post else { return }
    let key = NotificationContentKey.like(postID: post.id, date: notification.createdAt.dateAtStartOf(.day))
    if let content = notificationContents[key] as? LikeNotificationContent {
      content.notifications.append(notification)
    } else {
      let content = LikeNotificationContent()
      content.notifications.append(notification)
      notificationContents[key] = content
    }
  }
  
  private func appendOrCreateContentForFollow(_ notification: GabKit.Notification) {
    let key = NotificationContentKey.follow(date: notification.createdAt.dateAtStartOf(.day))
    if let content = notificationContents[key] as? FollowNotificationContent {
      content.notifications.append(notification)
    } else {
      let content = FollowNotificationContent()
      content.notifications.append(notification)
      notificationContents[key] = content
    }
  }
  
  private func appendOrCreateContentForRepost(_ notification: GabKit.Notification) {
    guard let post = notification.post else { return }
    let key = NotificationContentKey.repost(postID: post.id, date: notification.createdAt.dateAtStartOf(.day))
    if let content = notificationContents[key] as? RepostNotificationContent {
      content.notifications.append(notification)
    } else {
      let content = RepostNotificationContent()
      content.notifications.append(notification)
      notificationContents[key] = content
    }
  }
  
  private func appendOrCreateContentForMention(_ notification: GabKit.Notification) {
    let key = NotificationContentKey.mention(notificationID: notification.id, date: notification.createdAt)
    let content = MentionNotificationContent()
    content.notifications.append(notification)
    notificationContents[key] = content
  }
  
}

