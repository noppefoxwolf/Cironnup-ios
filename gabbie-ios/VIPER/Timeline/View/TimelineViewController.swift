//
//  TimelineViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import GabKit
import AsyncDisplayKit
import SnapKit
import CironnupKit
import DifferenceKit

class TimelineViewController: UIViewController, TimelineViewInput {
  var output: TimelineViewOutput!
  private var tableNode: ASTableNode = ASTableNode(style: .plain)
  private lazy var dataSource: TimelineDataSource = .init(with: tableNode)
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  // MARK: TimelineViewInput
  func setupInitialState(account: Account) {
    title = "Home"
    output.setupAccount(account)
  }
  
  func reloadData(_ postResponses: [PostResponse], noMore: Bool) {
    DispatchQueue.main.async { [weak self] in
      self?.dataSource.update(posts: postResponses)
    }
  }
  
  func endRefreshing() {
    DispatchQueue.main.async { [weak self] in
      self?.tableNode.view.refreshControl?.endRefreshing()
    }
  }
  
  func showSettingsActionSheet(otherAccounts: [Account]) {
    let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    sheet.addAction(.init(title: "Sign out", style: .destructive, handler: { [weak self] (_) in
      self?.output.tappedSignoutButton()
    }))
    if PurchaseLog.shared.isPurchased {
      if otherAccounts.count > 0 {
        for account in otherAccounts {
          sheet.addAction(.init(title: account.username, style: .default, handler: { [weak self] (_) in
            self?.output.tappedAccountButton(account)
          }))
        }
      }
      sheet.addAction(.init(title: "Add new account", style: .default, handler: { [weak self] (_) in
        self?.output.tappedNewAuthorizeButton()
      }))
    }
    sheet.addAction(.init(title: "Settings", style: .default, handler: { [weak self] (_) in
      self?.output.tappedSettingsButton()
    }))
    sheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
    present(sheet, animated: true, completion: nil)
  }
  
  // これ以下はreloadDataではなくセル個別に更新した方がちらつかない
  func addUpvotePatch(post id: Int) {
    dataSource.addUpvotePatch(post: id)
    reloadData(dataSource.posts, noMore: false)
  }
  
  func addDownvotePatch(post id: Int) {
    dataSource.addDownvotePatch(post: id)
    reloadData(dataSource.posts, noMore: false)
  }
  
  func removeUpvotePatch(post id: Int) {
    dataSource.removeUpvotePatch(post: id)
    reloadData(dataSource.posts, noMore: false)
  }
  
  func removeDownvotePatch(post id: Int) {
    dataSource.removeDownvotePatch(post: id)
    reloadData(dataSource.posts, noMore: false)
  }
  
  func addUserMutePatch(user id: Int) {
    dataSource.addUserMutePatch(user: id)
    reloadData(dataSource.posts, noMore: false)
  }
  
  func addPostFilterPatch(postResponse id: String) {
    dataSource.addPostFilterPatch(postResponse: id)
    reloadData(dataSource.posts, noMore: false)
  }
  
  func addRepostPatch(post id: Int) {
    dataSource.addRepostPatch(post: id)
    reloadData(dataSource.posts, noMore: false)
  }
  
  func removeRepostPatch(post id: Int) {
    dataSource.removeRepostPatch(post: id)
    reloadData(dataSource.posts, noMore: false)
  }
  
  func showPostActionSheet(postResponse id: String) {
    let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    sheet.addAction(.init(title: "Filter this post.", style: .destructive, handler: { [weak self] (_) in
      self?.output.tappedFilterPostButton(postResponseID: id)
    }))
    sheet.addAction(.init(title: "Mute this user.", style: .destructive, handler: { [weak self] (_) in
      guard let userID = self?.dataSource.userId(forPostResponseId: id) else { return }
      self?.output.tappedMuteUserButton(userID: userID)
    }))
    sheet.addAction(.init(title: "Report this post.", style: .destructive, handler: { _ in }))
    sheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
    present(sheet, animated: true, completion: nil)
  }
}

extension TimelineViewController {
  func setupUI(with account: Account) {
    title: do {
      let label = UILabel()
      label.attributedText = title?.withFont(.boldSystemFont(ofSize: 16)).withTextColor(.white)
      navigationItem.titleView = label
    }
    
    tableNode: do {
      tableNode.delegate = self
      tableNode.dataSource = self
      tableNode.view.tableFooterView = UIView()
      tableNode.backgroundColor = ColorName.backgroundColor.color
      tableNode.view.separatorColor = ColorName.separatorColor.color
      view.addSubnode(tableNode)
      tableNode.view.snp.makeConstraints {
        $0.left.right.top.bottom.equalTo(0)
      }
      let refreshControl = UIRefreshControl()
      refreshControl.addTarget(self, action: #selector(pullToRefreshed), for: .valueChanged)
      tableNode.view.refreshControl = refreshControl
    }
    
    toolbarItems: do {
      let compose = UIBarButtonItem.make(image: Asset.Icons.compose.image, target: self, action: #selector(tappedComposeButton))
      compose.tintColor = ColorName.buttonTintColor.color
      navigationItem.rightBarButtonItem = compose
      
      // ncの先頭の時だけアカウントボタンを出す
      if let nc = navigationController, nc.viewControllers.count == 1 {
        let accountImage = UIButton()
        accountImage.pin_setImage(from: URL(string: account.pictureUrl))
        accountImage.layer.cornerRadius = 15
        accountImage.layer.masksToBounds = true
        accountImage.addTarget(self, action: #selector(tappedAvaterButton), for: .touchUpInside)
        let settings = UIBarButtonItem(customView: accountImage)
        navigationItem.leftBarButtonItem = settings
        
        NSLayoutConstraint.activate([
          accountImage.heightAnchor.constraint(equalToConstant: 30),
          accountImage.widthAnchor.constraint(equalToConstant: 30)
        ])
      }
    }
  }
  
  @objc private func pullToRefreshed() {
    output.pullToRefreshed()
  }
  
  @objc private func tappedComposeButton(_ sender: UIBarButtonItem) {
    output.tappedComposeButton()
  }
  
  @objc private func tappedAvaterButton(_ sender: UIBarButtonItem) {
    output.tappedAvaterButton()
  }
}

extension TimelineViewController: ASTableDelegate, ASTableDataSource {
  func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
    return dataSource.posts.count
  }
  
  func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
    return { [weak self] in
      guard let self = self else { return ASCellNode() }
      let response = self.dataSource.posts[indexPath.row]
      return self.makeCellNode(response: response)
    }
  }
  
  func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
    tableNode.deselectRow(at: indexPath, animated: true)
  }
  
  private func makeCellNode(response: PostResponse) -> PostCellNode {
    let node = PostCellNode()
    node.configure(body: response.post.body)
    node.configure(name: response.post.user.name)
    node.configure(username: "@\(response.post.user.username)")
    node.configure(relativeTime: self.dataSource.relativeTimeTexts[response.id])
    node.configure(userImageURL: response.post.user.pictureUrl)
    
    repostedBy: do {
      if response.type == .repost {
        node.configure(repostedBy: response.actuser.name)
      }
    }
    
    replyTo: do {
      if let parent = response.post.conversationParent {
        node.configure(replyTo: parent.user.username)
      }
    }
    
    vote: do {
      let patch = dataSource.upvotePatches[response.post.id]
      if let patch = patch {
        node.configure(isUpvote: patch == .upvote)
        node.configure(isDownvote: patch == .downvote)
        node.configure(upvote: response.post.likeCount)
        node.configure(downvote: response.post.dislikeCount)
      } else {
        node.configure(isUpvote: response.post.liked)
        node.configure(isDownvote: response.post.disliked)
        node.configure(upvote: response.post.likeCount)
        node.configure(downvote: response.post.dislikeCount)
      }
      node.configure(didTapUpvote: { [weak self] in
        let isLiked: Bool
        if let patch = patch {
          isLiked = patch == .upvote
        } else {
          isLiked = response.post.liked
        }
        if isLiked {
          self?.output.tappedUpvoteButtonAgain(postID: response.post.id)
        } else {
          self?.output.tappedUpvoteButton(postID: response.post.id)
        }
      })
      node.configure(didTapDownvote: { [weak self] in
        let isDisliked: Bool
        if let patch = patch {
          isDisliked = patch == .downvote
        } else {
          isDisliked = response.post.disliked
        }
        if isDisliked {
          self?.output.tappedDownvoteButtonAgain(postID: response.post.id)
        } else {
          self?.output.tappedDownvoteButton(postID: response.post.id)
        }
      })
    }
    
    repost: do {
      if let reported = dataSource.repostedPathces[response.post.id] {
        node.configure(reposted: reported)
      } else {
        node.configure(reposted: response.post.reported)
      }
      node.configure(didTapRepost: { [weak self] in
        let isReposted: Bool
        if let reported = self?.dataSource.repostedPathces[response.post.id] {
          isReposted = reported
        } else {
          isReposted = response.post.reported
        }
        if isReposted {
          self?.output.tappedRepostButtonAgain(postID: response.post.id)
        } else {
          self?.output.tappedRepostButton(postID: response.post.id)
        }
      })
    }
    
    attachment: do {
      switch response.post.attachment {
      case .media(let media):
        node.appendAttachment(media: media, didTap: { [weak self] in
          self?.output.tappedImageAttachment(media)
        })
      case .medias(let medias):
        node.appendAttachment(medias: medias) { [weak self] (media) in
          self?.output.tappedImageAttachment(media, others: medias)
        }
      case .url(let url):
        node.appendAttachment(url: url, didTap: { [weak self] in
          self?.output.tappedURLAttachment(url)
        })
      case .giphy(let giphy):
        node.appendAttachment(giphy: giphy, didTap: { [weak self] in
          self?.output.tappedGiphyAttachment(giphy)
        })
      case .youtube(let youtube):
        node.appendAttachment(youtube: youtube, didTap: { [weak self] in
          self?.output.tappedYoutubeAttachment(youtube)
        })
      default: break
      }
    }
    
    other: do {
      node.configure(didTapMore: { [weak self] in
        self?.output.tappedMoreButton(postResponseID: response.id)
      })
      node.configure(didTapReply: { [weak self] in
        self?.output.tappedReplyButton(to: response.post.id,
                                       username: response.post.user.username,
                                       body: response.post.body)
      })
      node.configure(didTapQuote: { [weak self] in
        self?.output.tappedQuoteButton(to: response.post.id, body: response.post.body)
      })
      let isVisibleContent = !response.post.nsfw || dataSource.uncensoredPatches.contains(response.post.id)
      node.configure(isShowContent: isVisibleContent) { [weak self] in
        self?.dataSource.configure(unsensoredPost: response.post.id)
        self?.reloadData(self?.dataSource.posts ?? [], noMore: false)
      }
      
      if isVisibleContent {
        let isNegativeContent = dataSource.sentimentData[response.post.id] == .negative
        node.configure(isNegativeContent: isNegativeContent) { [weak self] in
          let url = "https://gab.com/username/posts/\(response.post.id)"
          self?.output.tappedNegativePost(url)
        }
      }
    }
    
    return node
  }
}
