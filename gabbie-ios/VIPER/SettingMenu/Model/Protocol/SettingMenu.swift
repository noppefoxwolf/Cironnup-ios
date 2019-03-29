//
//  SettingMenu.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/29.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

protocol SettingMenu {
  associatedtype Value: Equatable
  var key: String { get }
  var title: String { get }
  var dataStore: AnySettingDataStore<Value> { get }
  var items: [AnySettingMenuItem<Value>] { get }
  var defaultItem: AnySettingMenuItem<Value> { get }
}

extension SettingMenu {
  var dataStore: AnySettingDataStore<Value> {
    return AnySettingDataStore<Value>(UserDefaultDataStore(key: key))
  }
}

class AnySettingMenu<Value: Equatable> : SettingMenu {
  init<X: SettingMenu>(_ base: X) where X.Value == Value {
    _key = { base.key }
    _title = { base.title }
    _items = { base.items }
    _dataStore = { base.dataStore }
    _defaultItem = { base.defaultItem }
  }
  var key: String {
    return _key()
  }
  var title: String {
    return _title()
  }
  var items: [AnySettingMenuItem<Value>] {
    return _items()
  }
  var dataStore: AnySettingDataStore<Value> {
    return _dataStore()
  }
  var defaultItem: AnySettingMenuItem<Value> {
    return _defaultItem()
  }
  private let _key: () -> String
  private let _dataStore: () -> AnySettingDataStore<Value>
  private let _items: () -> [AnySettingMenuItem<Value>]
  private let _title: () -> String
  private let _defaultItem: () -> AnySettingMenuItem<Value>
}
