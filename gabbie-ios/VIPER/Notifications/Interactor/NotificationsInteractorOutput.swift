//
//  NotificationsInteractorOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit

protocol NotificationsInteractorOutput: class {
  func didReceivedResponse(_ response: NotificationsResponse)
  func didMakedNotificationContens(_ contents: [NotificationContentable])
  func didReceivedFaild(error: Error)
}
