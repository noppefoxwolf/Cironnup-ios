//
//  GroupViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import CironnupKit
import GabKit

protocol GroupViewInput: class {
  
  /**
   @author noppefoxwolf
   Setup initial state of the view
   */
  
  func setupInitialState(account: Account)
  func setupUI()
  func reload(groups: [Group])
}

