//
//  UIView+Extensions.swift
//  CironnupUI
//
//  Created by Tomoya Hirano on 2018/10/27.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

extension UIView {
  var heightConstraint: NSLayoutConstraint? {
    return constraints.filter{ $0.firstAttribute == .height }.first
  }
}
