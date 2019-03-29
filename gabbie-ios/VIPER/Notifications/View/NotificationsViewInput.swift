//
//  NotificationsViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

protocol NotificationsViewInput: class {
  
  /**
   @author noppefoxwolf
   Setup initial state of the view
   */
  
  func setupInitialState(credential: Credential)
  func reloadData(_ contents: [NotificationContentable])
  func endRefresing()
}

