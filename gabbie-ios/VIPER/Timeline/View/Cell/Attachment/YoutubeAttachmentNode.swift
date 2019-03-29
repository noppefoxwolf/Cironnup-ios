//
//  YoutubeAttachmentNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/25.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit
import AsyncDisplayKit

final class YoutubeAttachmentNode: ASControlNode {
  private lazy var imageNode: ASNetworkImageNode = .init()
  
  init(youtube attachment: Attachment.Youtube) {
    super.init()
    automaticallyManagesSubnodes = true
    imageNode.setURL(URL(string: attachment.thumbnailURL), resetToDefault: false)
    imageNode.cornerRadius = 12.0
    imageNode.cornerRoundingType = .precomposited
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    return ASRatioLayoutSpec(ratio: 0.5, child: imageNode)
  }
}
