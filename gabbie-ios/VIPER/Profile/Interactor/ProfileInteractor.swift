//
//  ProfileInteractor.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 23/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

class ProfileInteractor: ProfileInteractorInput {
  weak var output: ProfileInteractorOutput!
  
  func fetchMe(credential: Credential) {
    Gab.default(with: credential).getMe(success: { [weak self] (userDetail) in
      self?.output.didReceivedUser(userDetail)
    }) { [weak self] (error) in
      self?.output.didReceivedError(error)
    }
  }
  
  func fetchUser(username: String, credential: Credential) {
    Gab.default(with: credential).getUser(username: username, success: { [weak self] (userDetail) in
      self?.output.didReceivedUser(userDetail)
    }) { [weak self] (error) in
      self?.output.didReceivedError(error)
    }
  }
}

