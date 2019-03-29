//
//  UserDefaultDataStore.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/29.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

struct UserDefaultDataStore<T: Equatable>: SettingDataStore {
  typealias Value = T
  private let key: String
  private let userDefault: UserDefaults
  init(key: String) {
    self.key = key
    self.userDefault = UserDefaults.appGroups
  }
  
  func set(_ value: T) {
    userDefault.set(value, forKey: key)
    userDefault.synchronize()
  }
  
  func load() -> T? {
    return userDefault.object(forKey: key) as? T
  }
}
