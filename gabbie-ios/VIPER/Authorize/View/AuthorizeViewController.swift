//
//  AuthorizeViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class AuthorizeViewController: UIViewController, AuthorizeViewInput {
  var output: AuthorizeViewOutput!
  
  @IBOutlet private weak var signInButton: UIButton!
  @IBOutlet private weak var termsOfUseButton: UIButton!
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    view.backgroundColor = ColorName.backgroundColor.color
    signInButton.layer.cornerRadius = 6.0
    signInButton.layer.masksToBounds = true
    signInButton.backgroundColor = ColorName.buttonTintColor.color
    signInButton.setTitleColor(.white, for: .normal)
    termsOfUseButton.setTitleColor(.white, for: .normal)
  }
  
  // MARK: AuthorizeViewInput
  func setupInitialState() {
  }
  
  @IBAction func tappedAuthorizeButton(_ sender: Any) {
    output.tappedAuthorizeButton()
  }
  
  @IBAction func tappedTermsOfUseButton(_ sender: Any) {
    output.tappedTermsOfUseButton()
  }
}

