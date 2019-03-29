//
//  NotificationCellNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/18.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit

final class NotificationCellNode: ASCellNode {
  private let notificationIconNode: ASImageNode = .init()
  private let titleNode: ASTextNode = .init()
  private let descriptionNode: ASTextNode = .init()
  private var avaterNodes: [ASDisplayNode] = []
  private let notificationTypeIndicator: NotificationTypeIndicatorNode = .init()
  
  init(content: NotificationContentable) {
    super.init()
    backgroundColor = ColorName.contentBackgroundColor.color
    automaticallyManagesSubnodes = true
    titleNode.attributedText = content.title
    descriptionNode.attributedText = content.body
    descriptionNode.maximumNumberOfLines = 2
    content.notifications.forEach { (notification) in
      guard let user = notification.actuser else { return }
      let node = ASNetworkImageNode()
      node.style.preferredSize = .init(width: 36, height: 36)
      node.cornerRadius = 18
      node.cornerRoundingType = .clipping
      node.backgroundColor = ColorName.contentBackgroundColor.color
      node.setURL(URL(string: user.pictureUrl), resetToDefault: false)
      avaterNodes.append(node)
    }
    notificationTypeIndicator.configure(tintColor: content.notificationType.color)
    notificationTypeIndicator.configure(fillColor: ColorName.contentBackgroundColor.color)
  }
  
  func configure(isTop: Bool) {
    notificationTypeIndicator.isTop = isTop
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let avaters = ASStackLayoutSpec.horizontal()
    avaters.spacing = 4
    avaters.children = avaterNodes
    avaters.flexWrap = .wrap
    avaters.lineSpacing = 4
    
    let content = ASStackLayoutSpec.vertical()
    content.spacing = 8.0
    content.children = [titleNode, descriptionNode, avaters]
    
    let contentInset = ASInsetLayoutSpec()
    contentInset.child = content
    contentInset.insets = .init(top: 12, left: 36 + 8, bottom: 12, right: 0)
    
    notificationTypeIndicator.style.width = ASDimensionMake(36)
    notificationTypeIndicator.style.layoutPosition = .zero
    let indicator = ASAbsoluteLayoutSpec(children: [notificationTypeIndicator])
    
    let notificationContent = ASOverlayLayoutSpec()
    notificationContent.child = contentInset
    notificationContent.overlay = indicator
    
    let insetContent = ASInsetLayoutSpec(insets: .init(top: 0, left: 18, bottom: 0, right: 18), child: notificationContent)
    return insetContent
  }
}
