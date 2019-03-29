//
//  InSessionPresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

class InSessionPresenter: InSessionModuleInput, InSessionViewOutput, InSessionInteractorOutput {
  weak var view: InSessionViewInput!
  var interactor: InSessionInteractorInput!
  var router: InSessionRouterInput!
  
  lazy var credential: Credential = { preconditionFailure() }()
  
  func viewIsReady() {
  }
  
  func setupCredential(_ credential: Credential) {
    self.credential = credential
  }
}

