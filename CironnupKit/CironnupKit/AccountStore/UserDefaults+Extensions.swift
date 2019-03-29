//
//  UserDefaults+Extensions.swift
//  CironnupKit
//
//  Created by Tomoya Hirano on 2018/10/20.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

extension UserDefaults {
  public static var appGroups: UserDefaults {
    return UserDefaults(suiteName: "group.com.noppelab.gabbie")!
  }
}

