//
//  PostCellNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import SwiftyAttributes
import AsyncDisplayKit
import GabKit

final class PostCellNode: ASCellNode {
  private var repostedByNode: RepostedByNode? = nil
  
  private let userImageNode: ASNetworkImageNode = .init()
  private let nameNode: ASTextNode = .init()
  private let usernameNode: ASTextNode = .init()
  private let relativeTimeNode: ASTextNode = .init()
  private let otherButtonNode: ActionButtonNode = .init()
  
  private var replyToNode: ReplyToNode? = nil
  
  private let bodyNode: ASTextNode = .init()
  private let shareButtonNode: ASButtonNode = .init()
  private var attachmentNodes: [ASDisplayNode] = []
  
  private let upvoteButtonNode: ActionToggleButtonNode = .init()
  private let downvoteButtonNode: ActionToggleButtonNode = .init()
  private let commentButtonNode: ActionButtonNode = .init()
  private let repostButtonNode: ActionToggleButtonNode = .init()
  private let quoteButtonNode: ActionButtonNode = .init()
  
  private lazy var censoredTextNode: ASTextNode = .init()
  
  private var isShowContent: Bool = true
  
  override init() {
    super.init()
    selectionStyle = .none
    backgroundColor = ColorName.contentBackgroundColor.color
    automaticallyManagesSubnodes = true
    bodyNode.maximumNumberOfLines = 0
    userImageNode.imageModificationBlock = ASImageNodeRoundBorderModificationBlock(0, backgroundColor)
    otherButtonNode.configure(image: Asset.Icons.Actions.more.image)
    commentButtonNode.configure(image: Asset.Icons.Actions.comment.image)
    quoteButtonNode.configure(image: Asset.Icons.Actions.quote.image)
  }
  
  func configure(userImageURL urlString: String) {
    userImageNode.setURL(URL(string: urlString), resetToDefault: false)
  }
  
  func configure(name: String) {
    nameNode.attributedText = name.withFont(.boldSystemFont(ofSize: 14)).withTextColor(.white)
  }
  
  func configure(username: String) {
    usernameNode.attributedText = username.withFont(.systemFont(ofSize: 14)).withTextColor(.lightGray)
  }
  
  func configure(relativeTime: String?) {
    if let text = relativeTime {
      relativeTimeNode.attributedText = "･\(text)".withFont(.systemFont(ofSize: 14)).withTextColor(.lightGray)
    } else {
      relativeTimeNode.attributedText = nil
    }
  }
  
  func configure(body: String) {
    bodyNode.attributedText = body.withFont(.systemFont(ofSize: 14)).withTextColor(.white)
  }
  
  func appendAttachment(media attachment: Attachment.Media, didTap action: @escaping ASControlNode.DidTapAction) {
    let node = MediaAttachmentNode(media: attachment)
    node.setDidTapBlock(action)
    attachmentNodes.append(node)
  }
  
  func appendAttachment(medias attachments: [Attachment.Media], didTap action: @escaping ((Attachment.Media) -> Void)) {
    let node = MediasAttachmentNode(medias: attachments)
    node.didTapPreview = { (attachment) in
      action(attachment)
    }
    attachmentNodes.append(node)
  }
  
  func appendAttachment(url attachment: Attachment.URL, didTap action: @escaping ASControlNode.DidTapAction) {
    let node = URLAttachmentNode(url: attachment)
    node.setDidTapBlock(action)
    attachmentNodes.append(node)
  }
  
  func appendAttachment(giphy attachment: Attachment.Giphy, didTap action: @escaping ASControlNode.DidTapAction) {
    let node = GiphyAttachmentNode(giphy: attachment)
    node.setDidTapBlock(action)
    attachmentNodes.append(node)
  }
  
  func appendAttachment(youtube attachment: Attachment.Youtube, didTap action: @escaping ASControlNode.DidTapAction) {
    let node = YoutubeAttachmentNode(youtube: attachment)
    node.setDidTapBlock(action)
    attachmentNodes.append(node)
  }
  
  func configure(upvote count: Int) {
    upvoteButtonNode.configure(text: "\(count)")
  }
  
  func configure(isUpvote: Bool) {
    let color: UIColor = isUpvote ? ColorName.upvoteColor.color : .white
    upvoteButtonNode.configure(image: Asset.Icons.Actions.up.image, tintColor: color)
  }
  
  func configure(downvote count: Int) {
    downvoteButtonNode.configure(text: "\(count)")
  }
  
  func configure(isDownvote: Bool) {
    let color: UIColor = isDownvote ? ColorName.downvoteColor.color : .white
    downvoteButtonNode.configure(image: Asset.Icons.Actions.down.image, tintColor: color)
  }
  
  func configure(didTapUpvote action: @escaping (() -> Void)) {
    upvoteButtonNode.didTapAction = action
  }
  
  func configure(didTapDownvote action: @escaping (() -> Void)) {
    downvoteButtonNode.didTapAction = action
  }
  
  func configure(didTapMore action: @escaping (() -> Void)) {
    otherButtonNode.didTapAction = action
  }
  
  func configure(didTapReply action: @escaping (() -> Void)) {
    commentButtonNode.didTapAction = action
  }
  
  func configure(didTapQuote action: @escaping (() -> Void)) {
    quoteButtonNode.didTapAction = action
  }
  
  func configure(reposted: Bool) {
    let color: UIColor = reposted ? ColorName.repostedColor.color : .white
    repostButtonNode.configure(image: Asset.Icons.Actions.repost.image, tintColor: color)
  }
  
  func configure(didTapRepost action: @escaping (() -> Void)) {
    repostButtonNode.didTapAction = action
  }
  
  func configure(replyTo username: String) {
    replyToNode = ReplyToNode(replyTo: username)
  }
  
  func configure(repostedBy name: String) {
    repostedByNode = RepostedByNode(repostedBy: name)
  }
  
  func configure(isShowContent: Bool, didTapShow action: @escaping (() -> Void)) {
    self.isShowContent = isShowContent
    if !isShowContent {
      let text = "Sensitive content: you should agree you are above 18 years old. ".withTextColor(.white)
      let link = "Show".withLink(Link.uncensored.url)
        .withTextColor(ColorName.brandColor.color)
        .withUnderlineColor(.clear)
      text.append(link)
      censoredTextNode.isUserInteractionEnabled = true
      censoredTextNode.attributedText = text.withFont(.boldSystemFont(ofSize: 14))
      censoredTextNode.setDidTappedLinkBlock { (node, attribute, value, _, _) in
        action()
      }
    }
  }
  
  func configure(isNegativeContent: Bool, didTapShow action: @escaping (() -> Void)) {
    self.isShowContent = !isNegativeContent
    if isNegativeContent {
      let text = "This post cannot be displayed in the cironnup. ".withTextColor(.white)
      let link = "Show".withLink(Link.uncensored.url)
        .withTextColor(ColorName.brandColor.color)
        .withUnderlineColor(.clear)
      text.append(link)
      censoredTextNode.isUserInteractionEnabled = true
      censoredTextNode.attributedText = text.withFont(.boldSystemFont(ofSize: 14))
      censoredTextNode.setDidTappedLinkBlock { (node, attribute, value, _, _) in
        action()
      }
    }
  }
  
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    let userImage = ASWrapperLayoutSpec(layoutElement: userImageNode)
    let screenName = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 6,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [nameNode, usernameNode])
    let nameAndTime = ASStackLayoutSpec(direction: .horizontal,
                                        spacing: 0,
                                        justifyContent: .start,
                                        alignItems: .start,
                                        children: [screenName, relativeTimeNode])
    
    let nameAndOther = ASStackLayoutSpec(direction: .horizontal,
                                         spacing: 0,
                                         justifyContent: .spaceBetween,
                                         alignItems: .center,
                                         children: [nameAndTime, otherButtonNode])
    nameAndOther.style.alignSelf = .stretch
    nameAndOther.style.flexGrow = 1.0
    nameAndOther.style.flexShrink = 1.0
    
    let actionButtons = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 6,
                                          justifyContent: .spaceBetween,
                                          alignItems: .center,
                                          children: [upvoteButtonNode, downvoteButtonNode, commentButtonNode, repostButtonNode, quoteButtonNode])
    let actionButtonsInset = ASInsetLayoutSpec()
    actionButtonsInset.child = actionButtons
    actionButtonsInset.insets = .init(top: 0, left: 0, bottom: 0, right: 20)
    actionButtonsInset.style.alignSelf = .stretch
    actionButtonsInset.style.flexGrow = 1.0
    actionButtonsInset.style.flexShrink = 1.0
    
    //moreボタンを右上に置くために限界までwidthを伸ばす
    let fillNode = ASDisplayNode()
    fillNode.style.preferredLayoutSize.width = ASDimensionMake(constrainedSize.max.width)
    
    var children: [ASLayoutElement] = [nameAndOther, replyToNode].compactMap({ $0 })
    if isShowContent {
      children.append(bodyNode)
    } else {
      children.append(censoredTextNode)
    }
    children.append(fillNode)
    if isShowContent {
      children.append(contentsOf: attachmentNodes)
    }
    children.append(actionButtonsInset)
    let bodyContent = ASStackLayoutSpec(direction: .vertical,
                                        spacing: 6,
                                        justifyContent: .start,
                                        alignItems: .start,
                                        children: children)
    
    userImageNode.style.preferredSize = .init(width: 52, height: 52)
    bodyContent.style.layoutPosition = .init(x: 58, y: 0)
    
    let content = ASAbsoluteLayoutSpec(children: [userImage, bodyContent])
    let headerAndContent = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 6.0,
                                             justifyContent: .start,
                                             alignItems: .start,
                                             children: [repostedByNode, content].compactMap({ $0 }))
    let root = ASInsetLayoutSpec(insets: .init(top: 12, left: 16, bottom: 12, right: 16), child: headerAndContent)
    return root
  }
}
