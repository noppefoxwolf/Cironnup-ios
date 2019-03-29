//
//  AuthorizePresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import CironnupKit

class AuthorizePresenter: AuthorizeModuleInput, AuthorizeViewOutput, AuthorizeInteractorOutput {
  weak var view: AuthorizeViewInput!
  var interactor: AuthorizeInteractorInput!
  var router: AuthorizeRouterInput!
  
  func viewIsReady() {
    
  }
  
  func tappedAuthorizeButton() {
    router.presentSignIn(view: view, success: { [weak self] (credential) in
      self?.interactor.fetchMe(credential: credential)
    }) { (error) in
      InAppNotification.error(error)
    }
  }
  
  func didReceived(user: UserDetail, credential: Credential) {
    let source = ClientSource(id: Environment.current.clientID,
                              secret: Environment.current.clientSecret,
                              credential: credential,
                              scopes: [.read, .writePost, .engagePost, .engageUser, .notifications])
    let account = Account(user: user, clientSource: source)
    interactor.save(account)
    router.flipInSession(account: account)
  }
  
  func tappedTermsOfUseButton() {
    router.presentTermsOfUse(view: view)
  }
}

