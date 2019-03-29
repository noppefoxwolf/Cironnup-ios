//
//  StubTipJarInteractor.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/30.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

class StubTipJarInteractor: TipJarInteractorInput {
  weak var output: TipJarInteractorOutput!
  
  func fetchIAPProduct() {
    let ids = IAPProductIdentifier.allCases
    let products = ids.compactMap({ StubSKProduct.init(localizedTitle: $0.rawValue,
                                                       localizedPrice: "0yen",
                                                       price: 0,
                                                       productIdentifier: $0.rawValue) })
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
      self?.output.didReceivedIAPProduct(Set(products))
    }
  }
  
  func purchaseProduct(_ id: String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
      self?.output.didSuccessPurchased(identifier: id)
    }
  }
}

struct StubSKProduct: SKProductable {
  let localizedTitle: String
  let localizedPrice: String?
  let price: NSDecimalNumber
  let productIdentifier: String
}
