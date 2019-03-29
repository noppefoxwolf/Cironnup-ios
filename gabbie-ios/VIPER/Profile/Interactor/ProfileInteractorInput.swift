//
//  ProfileInteractorInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 23/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit

protocol ProfileInteractorInput {
  func fetchMe(credential: Credential)
  func fetchUser(username: String, credential: Credential)
}
