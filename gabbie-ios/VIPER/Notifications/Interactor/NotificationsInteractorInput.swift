//
//  NotificationsInteractorInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit

protocol NotificationsInteractorInput {
  func fetchNotifications(credential: Credential)
  func makeNotificationContents(from response: NotificationsResponse)
}
