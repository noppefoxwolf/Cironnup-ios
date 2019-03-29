//
//  ComposeViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import UIKit
import CironnupKit

protocol ComposeViewInput: class {
  
  /**
   @author noppefoxwolf
   Setup initial state of the view
   */
  
  func setupInitialState(account: Account)
  func configure(sendButton isEnabled: Bool)
  func presentMediaSourcePicker()
  func append(attachment: LocalAttachment)
  func update(attachment: LocalAttachment)
  func removeAttachment(at index: Int)
  func configure(body: String)
}

