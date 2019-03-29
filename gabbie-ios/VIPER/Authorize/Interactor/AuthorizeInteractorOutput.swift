//
//  AuthorizeInteractorOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit

protocol AuthorizeInteractorOutput: class {
  func didReceived(user: UserDetail, credential: Credential)
}
