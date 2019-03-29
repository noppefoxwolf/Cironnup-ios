//
//  InSessionViewOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

protocol InSessionViewOutput {
  
  /**
   @author noppefoxwolf
   Notify presenter that view is ready
   */
  
  func viewIsReady()
  func setupCredential(_ credential: Credential)
}

