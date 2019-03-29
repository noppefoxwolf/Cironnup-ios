//
//  IAPProductIdentifier.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/30.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

#if DEBUG
enum IAPProductIdentifier: String, CaseIterable {
  case snack = "com.noppelab.cironnup.debug.iap.snack"
  case coffee = "com.noppelab.cironnup.debug.iap.coffee"
  case lunch = "com.noppelab.cironnup.debug.iap.lunch"
}
#else
enum IAPProductIdentifier: String, CaseIterable {
  case snack = "com.noppelab.cironnup.iap.snack"
  case coffee = "com.noppelab.cironnup.iap.coffee"
  case lunch = "com.noppelab.cironnup.iap.lunch"
}
#endif

import UIKit

extension IAPProductIdentifier {
  var image: UIImage? {
    switch self {
    case .snack: return Asset.Icons.Tip.candy.image
    case .coffee: return Asset.Icons.Tip.coffee.image
    case .lunch: return Asset.Icons.Tip.lunch.image
    }
  }
}

