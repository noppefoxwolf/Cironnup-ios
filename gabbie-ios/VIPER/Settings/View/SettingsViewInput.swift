//
//  SettingsViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

protocol SettingsViewInput: class {
  
  /**
   @author noppefoxwolf
   Setup initial state of the view
   */
  
  func setupInitialState()
  func setupUI()
  func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

