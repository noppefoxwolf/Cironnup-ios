//
//  TimelineViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import CironnupKit

protocol TimelineViewInput: class {

    /**
        @author noppefoxwolf
        Setup initial state of the view
    */
  func setupUI(with account: Account)
  func setupInitialState(account: Account)
  func reloadData(_ postResponses: [PostResponse], noMore: Bool)
  func endRefreshing()
  func showSettingsActionSheet(otherAccounts: [Account])
  func addUpvotePatch(post id: Int)
  func addDownvotePatch(post id: Int)
  func removeUpvotePatch(post id: Int)
  func removeDownvotePatch(post id: Int)
  func showPostActionSheet(postResponse id: String)
  func addUserMutePatch(user id: Int)
  func addPostFilterPatch(postResponse id: String)
  func addRepostPatch(post id: Int)
  func removeRepostPatch(post id: Int)
}
