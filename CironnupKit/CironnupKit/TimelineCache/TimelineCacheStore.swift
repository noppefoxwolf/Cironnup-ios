//
//  TimelineCacheStore.swift
//  CironnupKit
//
//  Created by Tomoya Hirano on 2018/11/07.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation
import GabKit
import Cache

public class TimelineCacheStore {
  private let storage: Storage<FeedResponse>
  
  public init?() {
    guard let storage = StorageFactory.timelineStorage else { return nil }
    self.storage = storage
  }
  
  public func save(feed: FeedResponse, accountID: Int) {
    _ = try? storage.setObject(feed, forKey: "\(accountID)")
  }
  
  public func retrieve(for accountID: Int) -> FeedResponse? {
    let objects = try? storage.object(forKey: "\(accountID)")
    return objects
  }
}
