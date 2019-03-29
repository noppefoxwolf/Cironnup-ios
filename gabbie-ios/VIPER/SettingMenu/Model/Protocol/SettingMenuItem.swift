//
//  SettingMenuItem.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/29.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

protocol SettingMenuItem {
  associatedtype Value: Equatable
  var title: String { get }
  var value: Value { get }
}

class AnySettingMenuItem<Value: Equatable> : SettingMenuItem {
  init<X: SettingMenuItem>(_ base: X) where X.Value == Value {
    _value = { base.value }
    _title = { base.title }
  }
  var value: Value {
    return _value()
  }
  var title: String {
    return _title()
  }
  private let _value: () -> Value
  private let _title: () -> String
}
