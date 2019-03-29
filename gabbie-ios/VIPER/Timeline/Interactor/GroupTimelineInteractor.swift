//
//  GroupTimelineInteractor.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/11/12.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit
import CironnupKit

class GroupTimelineInteractor: TimelineInteractable {
  weak var output: TimelineInteractorOutput!
  private let id: String
  init(group id: String) {
    self.id = id
  }
  
  func fetchTimeline(account: Account) {
    Gab.default(with: account.clientSource.credential)._getGroupFeed(groupID: id, success: { [weak self] (feedResponse) in
      self?.output.didReceivedFeed(feed: feedResponse)
      self?.cache(feed: feedResponse, account: account.id)
    }) { [weak self] (error) in
      self?.output.didReceivedFaild(error: error)
    }
  }
  
  func cache(feed: FeedResponse, account id: Int) {}
  func retrieveCache(for accountID: Int) {}
}
