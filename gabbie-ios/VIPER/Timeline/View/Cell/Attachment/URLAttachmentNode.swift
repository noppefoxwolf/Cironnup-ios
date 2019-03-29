//
//  URLAttachmentNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit
import AsyncDisplayKit

final class URLAttachmentNode: ASControlNode {
  private lazy var thumbnailNode: ASNetworkImageNode = .init()
  private lazy var titleNode: ASTextNode = .init()
  private lazy var domainNode: ASTextNode = .init()
  private lazy var borderNode: ASDisplayNode = .init()
  
  init(url attachment: Attachment.URL) {
    super.init()
    automaticallyManagesSubnodes = true
    thumbnailNode.setURL(URL(string: attachment.image), resetToDefault: false)
    
    titleNode.maximumNumberOfLines = 2
    titleNode.attributedText = attachment.title.withFont(.systemFont(ofSize: 14)).withTextColor(.white)
    
    domainNode.attributedText = URL(string: attachment.url)?.host?.withFont(.systemFont(ofSize: 12)).withTextColor(.lightGray)
    
    cornerRadius = 12.0
    cornerRoundingType = .clipping
    backgroundColor = ColorName.contentBackgroundColor.color
    borderNode.cornerRadius = 12.0
    borderNode.borderWidth = 1.0
    borderNode.borderColor = ColorName.separatorColor.color.cgColor
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let image = ASRatioLayoutSpec(ratio: 0.4, child: thumbnailNode)
    let body = ASStackLayoutSpec(direction: .vertical,
                                     spacing: 6.0,
                                     justifyContent: .start,
                                     alignItems: .start,
                                     children: [titleNode, domainNode])
    let insetbody = ASInsetLayoutSpec(insets: .init(top: 8, left: 12, bottom: 8, right: 12), child: body)
    let content = ASStackLayoutSpec(direction: .vertical,
                                        spacing: 0,
                                        justifyContent: .start,
                                        alignItems: .start,
                                        children: [image, insetbody])
    return ASOverlayLayoutSpec(child: content, overlay: borderNode)
  }
}

