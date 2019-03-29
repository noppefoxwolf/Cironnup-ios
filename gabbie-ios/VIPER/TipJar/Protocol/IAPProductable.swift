//
//  IAPProductable.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/29.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import StoreKit

protocol IAPProductable {
//  var localizedDescription: String { get }
  var localizedTitle: String { get }
  var localizedPrice: String? { get }
  var price: NSDecimalNumber { get }
//  var priceLocale: Locale { get }
  var productIdentifier: String { get }
//  var isDownloadable: Bool { get }
//  var downloadContentLengths: [NSNumber] { get }
//  var downloadContentVersion: String { get }
//  var subscriptionPeriod: SKProductSubscriptionPeriod? { get }
//  var introductoryPrice: SKProductDiscount? { get }
//  var subscriptionGroupIdentifier: String? { get }
}

extension IAPProductable {
  var identifier: IAPProductIdentifier? {
    return IAPProductIdentifier(rawValue: productIdentifier)
  }
}
protocol SKProductable: IAPProductable & Hashable {}
