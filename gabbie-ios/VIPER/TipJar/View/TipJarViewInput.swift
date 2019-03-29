//
//  TipJarViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

protocol TipJarViewInput: class {
  
  /**
   @author noppefoxwolf
   Setup initial state of the view
   */
  
  func setupInitialState()
  func setupUI()
  func configure(products: [IAPProductable])
  func showPurchasedAlert(identifier: String)
  func disablePurchaseButtons()
  func enablePurchaseButtons()
  func showAlert(title: String, message: String)
  func close()
}

