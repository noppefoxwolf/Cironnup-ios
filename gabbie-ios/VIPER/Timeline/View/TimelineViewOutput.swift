//
//  TimelineViewOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import CironnupKit

protocol TimelineViewOutput: class {
  
  /**
   @author noppefoxwolf
   Notify presenter that view is ready
   */
  
  func viewIsReady()
  func setupAccount(_ account: Account)
  func pullToRefreshed()
  func tappedComposeButton()
  func tappedAvaterButton()
  func tappedAccountButton(_ account: Account)
  func tappedSettingsButton()
  func tappedSignoutButton()
  func tappedImageAttachment(_ attachment: Attachment.Media)
  func tappedImageAttachment(_ attachment: Attachment.Media, others: [Attachment.Media])
  func tappedURLAttachment(_ attachment: Attachment.URL)
  func tappedGiphyAttachment(_ attachment: Attachment.Giphy)
  func tappedYoutubeAttachment(_ attachment: Attachment.Youtube)
  func tappedUpvoteButton(postID: Int)
  func tappedUpvoteButtonAgain(postID: Int)
  func tappedDownvoteButton(postID: Int)
  func tappedDownvoteButtonAgain(postID: Int)
  func tappedMoreButton(postResponseID: String)
  func tappedMuteUserButton(userID: Int)
  func tappedFilterPostButton(postResponseID: String)
  func tappedReplyButton(to postID: Int, username: String, body: String)
  func tappedQuoteButton(to postID: Int, body: String)
  func tappedRepostButton(postID: Int)
  func tappedRepostButtonAgain(postID: Int)
  func tappedNewAuthorizeButton()
  func tappedNegativePost(_ url: String)
}

