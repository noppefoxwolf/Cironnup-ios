//
//  RepostedByNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/24.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit

final class RepostedByNode: ASDisplayNode {
  private let textNode = ASTextNode()
  
  init(repostedBy name: String) {
    super.init()
    
    automaticallyManagesSubnodes = true
    // It's workaround for UIKit bug.
    let attachment = " ".append(Asset.TextAttachment.reload.image.withRenderingMode(.alwaysTemplate),
                                bounds: .init(x: 0, y: -2, width: 12, height: 12))
                        .withFont(.systemFont(ofSize: 0))
                        .withTextColor(.lightGray)
    let text = "\(name) Reposted".withFont(.systemFont(ofSize: 12)).withTextColor(.lightGray)
    textNode.attributedText = attachment + .init(space: 4) + text
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    return ASInsetLayoutSpec(insets: .init(top: 0, left: 40, bottom: 0, right: 0), child: textNode)
  }
}

