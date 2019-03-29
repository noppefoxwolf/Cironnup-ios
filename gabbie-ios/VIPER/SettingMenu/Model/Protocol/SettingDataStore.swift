//
//  SettingDataStore.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/29.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

protocol SettingDataStore {
  associatedtype Value: Equatable
  func set(_ value: Value)
  func load() -> Value?
}

class AnySettingDataStore<Value: Equatable> : SettingDataStore {
  init<X: SettingDataStore>(_ base: X) where X.Value == Value {
    _set = { (value: Value) in base.set(value) }
    _load = { () in base.load() }
  }
  func set(_ value: Value) {
    _set(value)
  }
  func load() -> Value? {
    return _load()
  }
  
  private let _set: (Value) -> Void
  private let _load: () -> Value?
}
