//
//  ActionToggleButtonNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/20.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit

class ActionToggleButtonNode: ControlNode {
  private let imageNode: ASImageNode = .init()
  private let labelNode: ASTextNode = .init()
  
  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(.white)
    imageNode.style.preferredSize = .init(width: 20, height: 20)
  }
  
  func configure(image: UIImage, tintColor: UIColor = .white) {
    imageNode.imageModificationBlock = ASImageNodeTintColorModificationBlock(tintColor)
    imageNode.image = nil // force update image
    imageNode.image = image
  }
  
  func configure(text: String) {
    labelNode.attributedText = text.withFont(.systemFont(ofSize: 14)).withTextColor(.white)
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let content = ASStackLayoutSpec(direction: .horizontal,
                                    spacing: 2,
                                    justifyContent: .start,
                                    alignItems: .center,
                                    children: [imageNode, labelNode])
    
    return ASInsetLayoutSpec(insets: .init(top: 2, left: 2, bottom: 2, right: 2), child: content)
  }
}
