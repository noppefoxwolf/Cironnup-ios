//
//  TimelineInteractable.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/11/12.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import CironnupKit
import GabKit

protocol TimelineInteractable: TimelineInteractorInput {
  var output: TimelineInteractorOutput! { get set }
}

extension TimelineInteractable {  
  func upvote(post id: Int, credential: Credential) {
    Gab.default(with: credential).upvote(postID: id, success: { (response) in
      
    }) { (error) in
      self.output.didReceivedFaild(error: error)
    }
  }
  
  func downvote(post id: Int, credential: Credential) {
    Gab.default(with: credential).downvote(postID: id, success: { (response) in
      
    }) { (error) in
      self.output.didReceivedFaild(error: error)
    }
  }
  
  func removeUpvote(post id: Int, credential: Credential) {
    Gab.default(with: credential).removeUpvote(postID: id, success: { (response) in
      
    }) { (error) in
      self.output.didReceivedFaild(error: error)
    }
  }
  
  func removeDownvote(post id: Int, credential: Credential) {
    Gab.default(with: credential).removeDownvote(postID: id, success: { (response) in
      
    }) { (error) in
      self.output.didReceivedFaild(error: error)
    }
  }
  
  func repost(post id: Int, credential: Credential) {
    Gab.default(with: credential).repost(postID: id, success: { (response) in
      
    }) { (error) in
      self.output.didReceivedFaild(error: error)
    }
  }
  
  func removeRepost(post id: Int, credential: Credential) {
    Gab.default(with: credential).removeRepost(postID: id, success: { (response) in
      
    }) { (error) in
      self.output.didReceivedFaild(error: error)
    }
  }
  
  func fetchMe(credential: Credential) {
    Gab.default(with: credential).getMe(success: { (user) in
      let source = ClientSource(id: Environment.current.clientID,
                                secret: Environment.current.clientSecret,
                                credential: credential,
                                scopes: [.read, .writePost, .engagePost, .engageUser, .notifications])
      let account = Account(user: user, clientSource: source)
      AccountStore()?.save(account)
    }) { (error) in
      InAppNotification.error(error)
    }
  }
  
  func cache(feed: FeedResponse, account id: Int) {
    TimelineCacheStore()?.save(feed: feed, accountID: id)
  }
  
  func retrieveCache(for accountID: Int) {
    guard let feed = TimelineCacheStore()?.retrieve(for: accountID) else { return }
    output.didReceivedFeed(feed: feed)
  }
}
