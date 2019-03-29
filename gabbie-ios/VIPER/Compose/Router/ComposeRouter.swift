//
//  ComposeRouter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class ComposeRouter: ComposeRouterInput {
  func dismiss(view: ComposeViewInput) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    vc.dismiss(animated: true, completion: nil)
  }
}
