//
//  BrowserPresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import OnePasswordExtension

class BrowserPresenter: BrowserModuleInput, BrowserViewOutput, BrowserInteractorOutput {
  
  weak var view: BrowserViewInput!
  var interactor: BrowserInteractorInput!
  var router: BrowserRouterInput!
  
  func viewIsReady() {
    view.setupUI()
  }
  
  func tappedSharedButton(with items: [Any]) {
    router.presentAcitivy(items: items, view: view, completion: { [weak self] (type, _, items, _) in
      guard let type = type?.rawValue else { return }
      guard OnePasswordExtension.shared().isOnePasswordExtensionActivityType(type) else { return }
      guard let items = items else { return }
      self?.view.fillReturnedItems(items)
    })
  }
  
  func tappedSafariButton(url: URL) {
    router.openSafari(url: url)
  }
  
  func tappedDoneButton() {
    view.dismiss(animated: true, completion: nil)
  }
}

