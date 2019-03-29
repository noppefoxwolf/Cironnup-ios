//
//  MediaAttachmentNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/16.
//  Copyright © 2018年 Tomoya Hirano. All rights reserved.
//

import GabKit
import AsyncDisplayKit

final class MediaAttachmentNode: ASControlNode {
  private lazy var imageNode: ASNetworkImageNode = .init()
  
  init(media attachment: Attachment.Media) {
    super.init()
    automaticallyManagesSubnodes = true
    imageNode.setURL(URL(string: attachment.urlThumbnail), resetToDefault: false)
    imageNode.cornerRadius = 12.0
    imageNode.cornerRoundingType = .precomposited
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    return ASRatioLayoutSpec(ratio: 0.5, child: imageNode)
  }
}
