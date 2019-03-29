//
//  ASControlNode+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/17.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit

private var StoredPropertyKey: UInt8 = 0

extension ASControlNode {
  typealias DidTapAction = (() -> Void)
  
  private var closure: DidTapAction? {
    get {
      guard let object = objc_getAssociatedObject(self, &StoredPropertyKey) as? DidTapAction else {
        return nil
      }
      return object
    }
    set {
      addTarget(self, action: #selector(didSelected), forControlEvents: .touchUpInside)
      objc_setAssociatedObject(self, &StoredPropertyKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }
  
  func setDidTapBlock(_ action: @escaping DidTapAction) {
    self.closure = action
  }
  
  @objc private func didSelected(_ sender: ASControlNode) {
    closure?()
  }
}
