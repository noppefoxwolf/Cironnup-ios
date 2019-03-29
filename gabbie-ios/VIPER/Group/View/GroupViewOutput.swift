//
//  GroupViewOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import CironnupKit

protocol GroupViewOutput {
  
  /**
   @author noppefoxwolf
   Notify presenter that view is ready
   */
  
  func viewIsReady()
  func didSelectGroup(id: String)
  func setupAccount(_ account: Account)
  func pullToRefreshed()
}

