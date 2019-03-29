//
//  BrowserViewOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation

protocol BrowserViewOutput {
  
  /**
   @author noppefoxwolf
   Notify presenter that view is ready
   */
  
  func viewIsReady()
  func tappedSharedButton(with items: [Any])
  func tappedSafariButton(url: URL)
  func tappedDoneButton()
}


