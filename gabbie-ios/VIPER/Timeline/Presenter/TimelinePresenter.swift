//
//  TimelinePresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import CironnupKit

class TimelinePresenter: TimelineModuleInput, TimelineViewOutput, TimelineInteractorOutput {
  weak var view: TimelineViewInput!
  var interactor: TimelineInteractorInput!
  var router: TimelineRouterInput!
  
  lazy var account: Account = { preconditionFailure() }()
  
  func viewIsReady() {
    view.setupUI(with: account)
    interactor.retrieveCache(for: account.id)
    interactor.fetchTimeline(account: account)
  }
  
  func setupAccount(_ account: Account) {
    self.account = account
  }
  
  func pullToRefreshed() {
    interactor.fetchTimeline(account: account)
  }
  
  func tappedComposeButton() {
    router.presentCompose(account: account, replyMode: .normal, view: view)
  }
  
  func tappedSettingsButton() {
    router.presentSettings(view: view)
  }
  
  func tappedAvaterButton() {
    let accounts = AccountStore()?.accounts ?? []
    let otherAccounts = accounts.filter({ account.id != $0.id })
    view.showSettingsActionSheet(otherAccounts: otherAccounts)
  }
  
  func tappedAccountButton(_ account: Account) {
    router.switchAccount(account)
  }
  
  func tappedNegativePost(_ url: String) {
    guard let url = URL(string: url) else { return }
    router.openURL(url: url)
  }
  
  func tappedSignoutButton() {
    guard let store = AccountStore() else { return }
    store.remove(with: account.id)
    if let otherAccount = store.accounts.first {
      router.flipOtherSession(account: otherAccount)
    } else {
      router.flipAuthorize()
    }
  }
  
  func didReceivedFeed(feed: FeedResponse) {
    view.reloadData(feed.data, noMore: feed.noMore)
    view.endRefreshing()
  }
  
  func didReceivedFaild(error: Error) {
    InAppNotification.error(error)
    view.endRefreshing()
  }
  
  func tappedURLAttachment(_ attachment: Attachment.URL) {
    guard let url = URL(string: attachment.url) else { return }
    router.presentBrowser(url: url, view: view)
  }
  
  func tappedImageAttachment(_ attachment: Attachment.Media) {
    guard let url = URL(string: attachment.urlFull) else { return }
    router.presentImageViewer(url: url, urls: [url], view: view)
  }
  
  func tappedImageAttachment(_ attachment: Attachment.Media, others: [Attachment.Media]) {
    guard let url = URL(string: attachment.urlFull) else { return }
    let urls = others.map({ $0.urlFull }).compactMap({ URL(string: $0) })
    router.presentImageViewer(url: url, urls: urls, view: view)
  }
  
  func tappedGiphyAttachment(_ attachment: Attachment.Giphy) {
    guard let url = URL(string: attachment.url) else { return }
    router.presentImageViewer(url: url, urls: [url], view: view)
  }
  
  func tappedYoutubeAttachment(_ attachment: Attachment.Youtube) {
    guard let url = URL(string: attachment.url) else { return }
    router.presentBrowser(url: url, view: view)
  }
  
  func tappedUpvoteButton(postID: Int) {
    view.addUpvotePatch(post: postID)
    interactor.upvote(post: postID, credential: account.clientSource.credential)
  }
  
  func tappedDownvoteButton(postID: Int) {
    view.addDownvotePatch(post: postID)
    interactor.downvote(post: postID, credential: account.clientSource.credential)
  }
  
  func tappedUpvoteButtonAgain(postID: Int) {
    view.removeUpvotePatch(post: postID)
    interactor.removeUpvote(post: postID, credential: account.clientSource.credential)
  }
  
  func tappedDownvoteButtonAgain(postID: Int) {
    view.removeDownvotePatch(post: postID)
    interactor.removeDownvote(post: postID, credential: account.clientSource.credential)
  }
  
  func tappedMoreButton(postResponseID: String) {
    view.showPostActionSheet(postResponse: postResponseID)
  }
  
  func tappedMuteUserButton(userID: Int) {
    view.addUserMutePatch(user: userID)
  }
  
  func tappedFilterPostButton(postResponseID: String) {
    view.addPostFilterPatch(postResponse: postResponseID)
  }
  
  func tappedReplyButton(to postID: Int, username: String, body: String) {
    let mode = ReplyMode.reply(postID: postID, username: username, body: body)
    router.presentCompose(account: account, replyMode: mode, view: view)
  }
  
  func tappedQuoteButton(to postID: Int, body: String) {
    let mode = ReplyMode.quote(postID: postID, body: body)
    router.presentCompose(account: account, replyMode: mode, view: view)
  }
  
  func tappedRepostButton(postID: Int) {
    view.addRepostPatch(post: postID)
    interactor.repost(post: postID, credential: account.clientSource.credential)
  }
  
  func tappedRepostButtonAgain(postID: Int) {
    view.removeRepostPatch(post: postID)
    interactor.removeRepost(post: postID, credential: account.clientSource.credential)
  }
  
  func tappedNewAuthorizeButton() {
    router.presentSignIn(view: view, success: { [weak self] (credential) in
      self?.interactor.fetchMe(credential: credential)
    }) { (error) in
      InAppNotification.error(error)
    }
  }
}
