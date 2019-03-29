//
//  Migrater.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/20.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import CironnupKit

final class Migrater {
  static func migrate() throws {
    accountListMoveToAppGroup()
    try accountFileMoveToAppGroup()
  }
}

extension Migrater {
  
  // 1.1から1.2へのアップデートの際に、ShareExtensionsでAppGroupsを利用する
  // そのためアカウントファイルをLibrary/AccountsからAppGroups/Accountsへ移動する
  static func accountFileMoveToAppGroup() throws {
    let fm = FileManager.default
    let accountDirectory: URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!).appendingPathComponent("Accounts")
    let appGroupDirectory = fm.appGroupURL.appendingPathComponent("Accounts")
    if !fm.fileExists(atPath: appGroupDirectory.path) {
      try fm.moveItem(at: accountDirectory, to: appGroupDirectory)
    }
  }
  
  static func accountListMoveToAppGroup() {
    let key = "com.noppelab.gabbie.accounts.key"
    let appUD = UserDefaults.standard
    let appGroupUD = UserDefaults.appGroups
    let ids = appUD.stringArray(forKey: key)
    if let ids = ids, ids.count > 0 {
      appGroupUD.set(ids, forKey: key)
      if appGroupUD.synchronize() {
        appUD.removeObject(forKey: key)
      }
    }
  }
}
