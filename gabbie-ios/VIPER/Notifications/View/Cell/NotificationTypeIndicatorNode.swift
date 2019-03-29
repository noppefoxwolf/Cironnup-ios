//
//  NotificationTypeIndicatorNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/27.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit


final class NotificationTypeIndicatorNode: ASDisplayNode {
  private let vertialLine: ASDisplayNode = .init()
  private let indicator: ASDisplayNode = .init()
  var isTop: Bool = true
  
  override init() {
    super.init()
    automaticallyManagesSubnodes = true
    indicator.cornerRadius = 10
    indicator.cornerRoundingType = .defaultSlowCALayer
    indicator.borderWidth = 2.0
    vertialLine.backgroundColor = .white
  }
  
  func configure(tintColor: UIColor) {
    indicator.borderColor = tintColor.cgColor
  }
  
  func configure(fillColor: UIColor) {
    indicator.backgroundColor = fillColor
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    indicator.style.preferredSize = .init(width: 20, height: 20)
    vertialLine.style.width = ASDimensionMake(1)
    vertialLine.style.height = ASDimensionMake("100%")
    let vertialBackground = ASCenterLayoutSpec()
    vertialBackground.horizontalPosition = .center
    vertialBackground.verticalPosition = .start
    vertialBackground.child = vertialLine
    let vertialInset = ASInsetLayoutSpec()
    vertialInset.insets = .init(top: isTop ? 30 : 0, left: 0, bottom: 0, right: 0)
    vertialInset.child = vertialBackground
    
    let indicatorOverlay = ASCenterLayoutSpec()
    indicatorOverlay.horizontalPosition = .center
    indicatorOverlay.verticalPosition = .start
    indicatorOverlay.child = indicator
    let indicatorInset = ASInsetLayoutSpec()
    indicatorInset.child = indicatorOverlay
    indicatorInset.insets = .init(top: 20, left: 0, bottom: 0, right: 0)
    
    return ASOverlayLayoutSpec(child: vertialInset, overlay: indicatorInset)
  }
}

import GabKit

extension NotificationType {
  var color: UIColor {
    switch self {
    case .follow: return ColorName.notificationColorFollow.color
    case .like: return ColorName.notificationColorLike.color
    case .mention: return ColorName.notificationColorComment.color
    case .repost: return ColorName.notificationColorRepost.color
    case .unknown(_): return .white
    }
  }
}
