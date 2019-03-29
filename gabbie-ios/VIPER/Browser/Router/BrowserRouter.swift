//
//  BrowserRouter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import UIKit

class BrowserRouter: BrowserRouterInput {
  func presentAcitivy(items: [Any],
                      view: BrowserViewInput,
                      completion: UIActivityViewController.CompletionWithItemsHandler?) {
    guard let from = view as? UIViewController else { return }
    let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
    vc.completionWithItemsHandler = completion
    from.present(vc, animated: true, completion: nil)
  }
  
  func openSafari(url: URL) {
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
