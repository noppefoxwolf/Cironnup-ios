//
//  AppDelegate.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import GabKit
import Router
import CironnupKit
import Lightbox
import PINRemoteImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    _ = try? Migrater.migrate()
    
    setupLightBox()
    
    Router.default.setupAppNavigation(appNavigation: GabAppNavigation())
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = RootViewController()
    window?.makeKeyAndVisible()
    
    if let account = AccountStore()?.accounts.first {
      Router.default.flip(.inSessin(account))
    } else {
      Router.default.flip(.authorize)
    }
    
    return true
  }
  
  func application(_ app: UIApplication,
                   open url: URL,
                   options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    Gab.handleURL(url)
    return true
  }
  
  private func setupLightBox() {
    LightboxConfig.loadImage = { (imageView, url, completion) -> Void in
      imageView.pin_setImage(from: url, completion: { (result) in
        if let _ = result.error {
          completion?(nil)
        } else if let image = result.image {
          completion?(image)
        }
      })
    }
  }
}
