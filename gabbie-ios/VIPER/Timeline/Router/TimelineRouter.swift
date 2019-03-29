//
//  TimelineRouter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import Router
import CironnupKit

class TimelineRouter: TimelineRouterInput {
  func presentCompose(account: Account, replyMode: ReplyMode, view: TimelineViewInput) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    Router.default.navigate(.compose(account, replyMode), from: vc)
  }
  
  func flipAuthorize() {
    Router.default.flip(.authorize)
  }
  
  func flipOtherSession(account: Account) {
    Router.default.flip(.inSessin(account))
  }
  
  func presentBrowser(url: URL, view: TimelineViewInput) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    #warning("ここいけてない。型で取りたい")
    let setting = BrowserSetting()
    let current = setting.dataStore.load() ?? setting.defaultItem.value
    let browser = BrowserSettingMenuItem(rawValue: current)!
    switch browser {
    case .cironnup:
      Router.default.navigate(.browser(url), from: vc)
    case .chrome:
      var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
      components.scheme = "googlechrome"
      UIApplication.shared.open(components.url!, options: [:], completionHandler: nil)
    case .safari:
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
  func presentImageViewer(url: URL, urls: [URL], view: TimelineViewInput) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    Router.default.navigate(.imageViewer(url, urls), from: vc)
  }
  
  func presentSettings(view: TimelineViewInput) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    Router.default.navigate(GabNavigation.settings, from: vc)
  }
  
  func switchAccount(_ account: Account) {
    Router.default.flip(GabNavigation.inSessin(account))
  }
  
  func presentSignIn(view: TimelineViewInput, success: @escaping AuthSuccess, failure: @escaping Failure) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    let gab = Gab.default
    gab.observeAuthorize(handled: {
      vc.presentedViewController?.dismiss(animated: true, completion: nil)
    }, success: success, failure: failure)
    Router.default.navigate(GabNavigation.browser(gab.authorizeURL()), from: vc)
  }
  
  func openURL(url: URL) {
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
