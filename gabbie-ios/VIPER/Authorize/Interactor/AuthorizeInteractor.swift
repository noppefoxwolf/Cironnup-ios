//
//  AuthorizeInteractor.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import Router
import CironnupKit

class AuthorizeInteractor: AuthorizeInteractorInput {
  weak var output: AuthorizeInteractorOutput!
  
  func fetchMe(credential: Credential) {
    Gab.default(with: credential).getMe(success: { [weak self] (user) in
      self?.output.didReceived(user: user, credential: credential)
    }) { (error) in
      InAppNotification.error(error)
    }
  }
  
  func save(_ account: Account) {
    AccountStore()?.save(account)
  }
}

