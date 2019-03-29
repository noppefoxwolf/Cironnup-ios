//
//  ClosureActionButtonNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/21.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit

open class ControlNode: ASControlNode {
  open var didTapAction: (() -> Void)? = nil
  
  override public init() {
    super.init()
    addTarget(self, action: #selector(tapped), forControlEvents: .touchUpInside)
  }
  
  @objc private func tapped(_ sender: ControlNode) {
    didTapAction?()
  }
}
