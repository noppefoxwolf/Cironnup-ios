//
//  TipJarPresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import StoreKit

class TipJarPresenter: TipJarModuleInput, TipJarViewOutput, TipJarInteractorOutput {
  weak var view: TipJarViewInput!
  var interactor: TipJarInteractorInput!
  var router: TipJarRouterInput!
  
  func viewIsReady() {
    view.setupUI()
    interactor.fetchIAPProduct()
  }
  
  func didSelect(product id: String) {
    view.disablePurchaseButtons()
    interactor.purchaseProduct(id)
  }
  
  func tappedCloseButton() {
    view.close()
  }
  
  func didReceivedIAPProduct<T>(_ products: Set<T>) where T : SKProductable {
    view.configure(products: Array(products).sorted(by: { $0.price.doubleValue < $1.price.doubleValue }))
  }
  
  func didSuccessPurchased(identifier: String) {
    try! PurchaseLog.shared.log(product: identifier)
    view.showPurchasedAlert(identifier: identifier)
  }
  
  func didReceivedError(_ error: Error) {
    view.enablePurchaseButtons()
    view.showAlert(title: "Unknown error", message: error.localizedDescription)
  }
  
  func didReceivedSKError(_ error: SKError) {
    view.enablePurchaseButtons()
    view.showAlert(title: "Purchase error", message: error.localizedDescription)
  }
}
