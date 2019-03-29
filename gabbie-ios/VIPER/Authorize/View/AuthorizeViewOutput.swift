//
//  AuthorizeViewOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

protocol AuthorizeViewOutput {
  
  /**
   @author noppefoxwolf
   Notify presenter that view is ready
   */
  
  func viewIsReady()
  func tappedAuthorizeButton()
  func tappedTermsOfUseButton()
}

