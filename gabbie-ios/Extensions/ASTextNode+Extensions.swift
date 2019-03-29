//
//  ASTextNode+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/11/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit

enum Link {
  case uncensored
  
  var url: URL {
    switch self {
    case .uncensored: return URL(string: "uncensored://")!
    }
  }
}

private var StoredPropertyKey: UInt8 = 0

class ASTextNodeDelegator: NSObject, ASTextNodeDelegate {
  typealias TappedLinkAction = ((ASTextNode, String, Any, CGPoint, NSRange) -> Void)
  
  let closure: TappedLinkAction
  
  init (_ closure: @escaping TappedLinkAction) {
    self.closure = closure
  }
  
  func textNode(_ textNode: ASTextNode!,
                tappedLinkAttribute attribute: String!,
                value: Any!,
                at point: CGPoint,
                textRange: NSRange) {
    closure(textNode, attribute, value, point, textRange)
  }
}

extension ASTextNode {
  private var delegator: ASTextNodeDelegator? {
    get {
      guard let object = objc_getAssociatedObject(self, &StoredPropertyKey) as? ASTextNodeDelegator else {
        return nil
      }
      return object
    }
    set {
      delegate = newValue
      objc_setAssociatedObject(self, &StoredPropertyKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }
  
  func setDidTappedLinkBlock(_ action: @escaping ASTextNodeDelegator.TappedLinkAction) {
    self.delegator = ASTextNodeDelegator(action)
  }
}
