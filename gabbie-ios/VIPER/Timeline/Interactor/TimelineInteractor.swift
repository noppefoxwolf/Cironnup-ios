//
//  TimelineInteractor.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import CironnupKit

class TimelineInteractor: TimelineInteractable {
  weak var output: TimelineInteractorOutput!
  
  func fetchTimeline(account: Account) {
    Gab.default(with: account.clientSource.credential).getMainFeed(success: { (feedResponse) in
      self.output.didReceivedFeed(feed: feedResponse)
      self.cache(feed: feedResponse, account: account.id)
    }) { (error) in
      self.output.didReceivedFaild(error: error)
    }
  }
}
