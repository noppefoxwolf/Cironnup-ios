//
//  TipJarInteractor.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//
import SwiftyStoreKit
import StoreKit

class TipJarInteractor: TipJarInteractorInput {
  
  weak var output: TipJarInteractorOutput!
  
  func fetchIAPProduct() {
    let ids = Set(IAPProductIdentifier.allCases.map({ $0.rawValue }))
    SwiftyStoreKit.retrieveProductsInfo(ids) { [weak self] result in
      if let error = result.error {
        self?.output.didReceivedError(error)
      } else {
        self?.output.didReceivedIAPProduct(result.retrievedProducts)
      }
    }
  }
  
  func purchaseProduct(_ id: String) {
    SwiftyStoreKit.purchaseProduct(id, quantity: 1, atomically: true) { [weak self] (result) in
      switch result {
      case .success(let purchaseDetails):
        self?.output.didSuccessPurchased(identifier: purchaseDetails.productId)
      case .error(let error):
        self?.output.didReceivedSKError(error)
      }
    }
  }
}

extension SKProduct: SKProductable {}
