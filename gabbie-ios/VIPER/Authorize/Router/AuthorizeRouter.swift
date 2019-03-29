//
//  AuthorizeRouter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import Router
import CironnupKit

class AuthorizeRouter: AuthorizeRouterInput {
  func presentSignIn(view: AuthorizeViewInput, success: @escaping AuthSuccess, failure: @escaping Failure) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    let gab = Gab.default
    gab.observeAuthorize(handled: {
      vc.presentedViewController?.dismiss(animated: true, completion: nil)
    }, success: success, failure: failure)
    Router.default.navigate(GabNavigation.browser(gab.authorizeURL()), from: vc)
  }
  
  func flipInSession(account: Account) {
    Router.default.flip(.inSessin(account))
  }
  
  func presentTermsOfUse(view: AuthorizeViewInput) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    let url = URL(string: "https://noppelab.com/gabbie-pages/terms")!
    Router.default.navigate(GabNavigation.browser(url), from: vc)
  }
}


