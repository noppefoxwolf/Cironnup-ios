//
//  GroupInteractor.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

class GroupInteractor: GroupInteractorInput {
  
  weak var output: GroupInteractorOutput!
  
  func fetchJoinedGroups(credential: Credential) {
    Gab.default(with: credential)._getJoinedGroup(success: { [weak self] (groups) in
      self?.output.didReceived(groups.data)
    }) { [weak self] (error) in
      self?.output.didReceived(error)
    }
  }
}

