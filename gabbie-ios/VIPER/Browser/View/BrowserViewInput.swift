//
//  BrowserViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//
import Foundation

protocol BrowserViewInput: class {
  
  /**
   @author noppefoxwolf
   Setup initial state of the view
   */
  
  func setupInitialState()
  func setupUI()
  func fillReturnedItems(_ items: [Any])
  func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

