//
//  MediasAttachmentNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/25.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit
import AsyncDisplayKit

final class MediasAttachmentNode: ASDisplayNode {
  private var imageNodes = [ASLayoutSpec]()
  var didTapPreview: ((Attachment.Media) -> Void)? = nil
  
  override func didLoad() {
    super.didLoad()
    automaticallyManagesSubnodes = true
    cornerRadius = 12.0
    contentMode = .scaleAspectFill
    clipsToBounds = true
  }
  
  init(medias attachments: [Attachment.Media]) {
    super.init()
    imageNodes = attachments.map({ [weak self] (attachment) -> ASLayoutSpec in
      let imageNode = ASNetworkImageNode()
      imageNode.url = URL(string: attachment.urlThumbnail)
      imageNode.setDidTapBlock { [weak self] in
        self?.didTapPreview?(attachment)
      }
      return ASWrapperLayoutSpec(layoutElement: imageNode)
    })
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let layoutSpec = { [weak self] () -> ASLayoutSpec in
      guard let self = self else { return ASLayoutSpec() }
      switch self.imageNodes.count {
      case 1: return self.layoutSpecThatFitsForOne(constrainedSize, imageNode: self.imageNodes[0])
      case 2: return self.layoutSpecThatFitsForTwo(constrainedSize, leftImageNode: self.imageNodes[0],
                                              rightImageNode: self.imageNodes[1])
      case 3: return self.layoutSpecThatFitsForThree(constrainedSize, leftImageNode: self.imageNodes[0],
                                                rightTopImageNode: self.imageNodes[1],
                                                rightBottomImageNode: self.imageNodes[2])
      case 4: return self.layoutSpecThatFitsForFour(constrainedSize, leftTopImageNode: self.imageNodes[0],
                                               leftBottomImageNode: self.imageNodes[1],
                                               rightTopImageNode: self.imageNodes[2],
                                               rightBottomImageNode: self.imageNodes[3])
      default: return ASLayoutSpec()
      }
    }
    return ASRatioLayoutSpec(ratio: 0.5, child: layoutSpec())
  }
  
  private func layoutSpecThatFitsForOne(_: ASSizeRange, imageNode: ASLayoutSpec) -> ASLayoutSpec {
    return ASWrapperLayoutSpec(layoutElement: imageNode)
  }
  
  private func layoutSpecThatFitsForTwo(_: ASSizeRange, leftImageNode: ASLayoutSpec, rightImageNode: ASLayoutSpec) -> ASLayoutSpec {
    let separator: CGFloat = 4.0
    leftImageNode.style.flexBasis = ASDimensionMake("50%")
    rightImageNode.style.flexBasis = ASDimensionMake("50%")
    return ASStackLayoutSpec(direction: .horizontal,
                             spacing: separator,
                             justifyContent: .start,
                             alignItems: .start,
                             children: [leftImageNode, rightImageNode])
  }
  
  private func layoutSpecThatFitsForThree(_ constrainedSize: ASSizeRange,
                                          leftImageNode: ASLayoutSpec,
                                          rightTopImageNode: ASLayoutSpec,
                                          rightBottomImageNode: ASLayoutSpec) -> ASLayoutSpec {
    let separator: CGFloat = 4.0
    
    rightTopImageNode.style.flexBasis = ASDimensionMake("50%")
    rightBottomImageNode.style.flexBasis = ASDimensionMake("50%")
    
    let rightStack = ASStackLayoutSpec.vertical()
    rightStack.spacing = separator
    rightStack.children = [rightTopImageNode, rightBottomImageNode]
    rightStack.style.height = ASDimensionMake("100%")
    
    leftImageNode.style.flexBasis = ASDimensionMake("50%")
    rightStack.style.flexBasis = ASDimensionMake("50%")
    
    return ASStackLayoutSpec(direction: .horizontal,
                             spacing: separator,
                             justifyContent: .start,
                             alignItems: .start,
                             children: [leftImageNode, rightStack])
  }
  
  private func layoutSpecThatFitsForFour(_ constrainedSize: ASSizeRange,
                                         leftTopImageNode: ASLayoutSpec,
                                         leftBottomImageNode: ASLayoutSpec,
                                         rightTopImageNode: ASLayoutSpec,
                                         rightBottomImageNode: ASLayoutSpec) -> ASLayoutSpec {
    let separator: CGFloat = 4.0
    
    leftTopImageNode.style.flexBasis = ASDimensionMake("50%")
    leftBottomImageNode.style.flexBasis = ASDimensionMake("50%")
    rightTopImageNode.style.flexBasis = ASDimensionMake("50%")
    rightBottomImageNode.style.flexBasis = ASDimensionMake("50%")
    
    let rightStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: separator,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [rightTopImageNode, rightBottomImageNode])
    rightStack.style.flexBasis = ASDimensionMake("50%")
    rightStack.style.width = ASDimensionMake("100%")
    
    
    let leftStack = ASStackLayoutSpec(direction: .horizontal,
                                      spacing: separator,
                                      justifyContent: .start,
                                      alignItems: .start,
                                      children: [leftTopImageNode, leftBottomImageNode])
    leftStack.style.flexBasis = ASDimensionMake("50%")
    leftStack.style.width = ASDimensionMake("100%")
    
    return ASStackLayoutSpec(direction: .vertical,
                             spacing: separator,
                             justifyContent: .start,
                             alignItems: .start,
                             children: [leftStack, rightStack])
  }
}

