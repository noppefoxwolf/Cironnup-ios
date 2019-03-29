//
//  CookieCleaner.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/11/07.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation
import WebKit

enum CookieCleaner {
  static func clean() {
    URLSession.shared.reset {}
    UserDefaults.standard.synchronize()
    let dataStore = WKWebsiteDataStore.default()
    dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
      dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: records, completionHandler: {})
    }
    WKProcessPool.shared.reset()
  }
}

private extension WKProcessPool {
  static var shared = WKProcessPool()
  
  func reset(){
    WKProcessPool.shared = WKProcessPool()
  }
}
