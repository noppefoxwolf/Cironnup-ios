//
//  ProfileInteractorOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 23/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit

protocol ProfileInteractorOutput: class {
  func didReceivedUser(_ user: UserDetail)
  func didReceivedError(_ error: Error)
}
