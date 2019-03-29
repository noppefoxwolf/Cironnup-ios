//
//  TimelineInteractorInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit
import CironnupKit

protocol TimelineInteractorInput {
  func fetchTimeline(account: Account)
  func fetchMe(credential: Credential)
  func upvote(post id: Int, credential: Credential)
  func removeUpvote(post id: Int, credential: Credential)
  func downvote(post id: Int, credential: Credential)
  func removeDownvote(post id: Int, credential: Credential)
  func repost(post id: Int, credential: Credential)
  func removeRepost(post id: Int, credential: Credential)
  
  func cache(feed: FeedResponse, account id: Int)
  func retrieveCache(for accountID: Int)
}
