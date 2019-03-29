//
//  ActionButtonNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/20.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit

class ActionButtonNode: ControlNode {
  private let imageNode: ASImageNode = .init()
  
  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(.white)
    imageNode.style.preferredSize = .init(width: 20, height: 20)
  }
  
  func configure(image: UIImage) {
    imageNode.image = image
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    return ASInsetLayoutSpec(insets: .init(top: 2, left: 2, bottom: 2, right: 2), child: imageNode)
  }
}
