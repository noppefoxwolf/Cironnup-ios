//
//  InSessionViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import GabKit

final class InSessionViewController: TabBarController, InSessionViewInput {
  
  var output: InSessionViewOutput!
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    output.viewIsReady()
  }
  
  private func setup() {
  }
  
  // MARK: InSessionViewInput
  func setupInitialState(credential: Credential) {
    self.output.setupCredential(credential)
  }
}

