//
//  SettingsViewOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

protocol SettingsViewOutput {
  
  /**
   @author noppefoxwolf
   Notify presenter that view is ready
   */
  
  func viewIsReady()
  func tappedDoneButton()
  func tappedGeneralSettingMenu(_ settingMenu: AnySettingMenu<String>)
  func tappedReviewButton()
  func tappedTipButton()
  func tappedContactUsButton()
}

