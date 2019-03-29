//
//  TipJarInteractorOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import StoreKit

protocol TipJarInteractorOutput: class {
  func didReceivedIAPProduct<T: SKProductable>(_ products: Set<T>)
  func didReceivedError(_ error: Error)
  func didSuccessPurchased(identifier: String)
  func didReceivedSKError(_ error: SKError)
}
