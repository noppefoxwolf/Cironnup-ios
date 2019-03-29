//
//  AuthorizeInteractorInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit
import CironnupKit

protocol AuthorizeInteractorInput {
  func fetchMe(credential: Credential)
  func save(_ account: Account)
}
