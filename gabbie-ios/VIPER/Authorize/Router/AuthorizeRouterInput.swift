//
//  AuthorizeRouterInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit
import CironnupKit

protocol AuthorizeRouterInput {
  func presentSignIn(view: AuthorizeViewInput, success: @escaping AuthSuccess, failure: @escaping Failure)
  func flipInSession(account: Account)
  func presentTermsOfUse(view: AuthorizeViewInput)
}
