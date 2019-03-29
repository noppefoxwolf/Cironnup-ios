//
//  NotificationsPresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

class NotificationsPresenter: NotificationsModuleInput, NotificationsViewOutput, NotificationsInteractorOutput {
  
  weak var view: NotificationsViewInput!
  var interactor: NotificationsInteractorInput!
  var router: NotificationsRouterInput!
  
  private lazy var credential: Credential = { preconditionFailure() }()
  
  func viewIsReady() {
    interactor.fetchNotifications(credential: credential)
  }
  
  func setupCredential(_ credential: Credential) {
    self.credential = credential
  }
  
  func pullToRefreshed() {
    interactor.fetchNotifications(credential: credential)
  }
  
  func didReceivedResponse(_ response: NotificationsResponse) {
    interactor.makeNotificationContents(from: response)
  }
  
  func didMakedNotificationContens(_ contents: [NotificationContentable]) {
    view.reloadData(contents)
    view.endRefresing()
  }
  
  func didReceivedFaild(error: Error) {
    InAppNotification.error(error)
    view.endRefresing()
  }
}


