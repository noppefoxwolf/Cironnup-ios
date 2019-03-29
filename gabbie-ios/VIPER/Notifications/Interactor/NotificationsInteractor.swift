//
//  NotificationsInteractor.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

class NotificationsInteractor: NotificationsInteractorInput {
  
  weak var output: NotificationsInteractorOutput!
 
  func fetchNotifications(credential: Credential) {
    Gab.default(with: credential).getNotifications(success: { [weak self] (response) in
      self?.output.didReceivedResponse(response)
    }) { [weak self] (error) in
      self?.output.didReceivedFaild(error: error)
    }
  }
  
  func makeNotificationContents(from response: NotificationsResponse) {
    let factory = NotificationContentFactory()
    response.data.sorted(by: { $0.createdAt > $1.createdAt }).forEach { (notification) in
      factory.append(notification: notification)
    }
    let contents = factory.notificationContents.sorted(by: { $0.value.newestDate > $1.value.newestDate }).map({ $0.value })
    output.didMakedNotificationContens(contents)
  }
}

