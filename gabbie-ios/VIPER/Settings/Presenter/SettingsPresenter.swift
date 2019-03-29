//
//  SettingsPresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Router

class SettingsPresenter: SettingsModuleInput, SettingsViewOutput, SettingsInteractorOutput {
  
  weak var view: SettingsViewInput!
  var interactor: SettingsInteractorInput!
  var router: SettingsRouterInput!
  
  func viewIsReady() {
    view.setupInitialState()
    view.setupUI()
  }
  
  func tappedDoneButton() {
    view.dismiss(animated: true, completion: nil)
  }
  
  func tappedGeneralSettingMenu(_ settingMenu: AnySettingMenu<String>) {
    router.pushSettingMenu(settingMenu, view: view)
  }
  func tappedReviewButton() {
    router.openAppStore()
  }
  func tappedTipButton() {
    router.pushTipJar(view: view)
  }
  func tappedContactUsButton() {
    router.openContactUs()
  }
}

