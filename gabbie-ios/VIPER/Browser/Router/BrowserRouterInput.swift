//
//  BrowserRouterInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

protocol BrowserRouterInput {
  func presentAcitivy(items: [Any],
                      view: BrowserViewInput,
                      completion: UIActivityViewController.CompletionWithItemsHandler?)
  func openSafari(url: URL)
}
