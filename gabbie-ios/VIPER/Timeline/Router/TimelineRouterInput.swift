//
//  TimelineRouterInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit
import CironnupKit

protocol TimelineRouterInput {
  func presentCompose(account: Account, replyMode: ReplyMode, view: TimelineViewInput)
  func flipAuthorize()
  func flipOtherSession(account: Account)
  func presentImageViewer(url: URL, urls: [URL], view: TimelineViewInput)
  func presentBrowser(url: URL, view: TimelineViewInput)
  func presentSettings(view: TimelineViewInput)
  func switchAccount(_ account: Account)
  func presentSignIn(view: TimelineViewInput, success: @escaping AuthSuccess, failure: @escaping Failure)
  func openURL(url: URL)
}
