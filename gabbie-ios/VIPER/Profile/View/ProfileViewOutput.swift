//
//  ProfileViewOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 23/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

protocol ProfileViewOutput {
  
  /**
   @author noppefoxwolf
   Notify presenter that view is ready
   */
  
  func viewIsReady()
  func setup(target: ProfileTarget, credential: Credential)
}

