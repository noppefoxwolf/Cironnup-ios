//
//  NotificationsViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import GabKit
import AsyncDisplayKit

final class NotificationsViewController: UIViewController, NotificationsViewInput {
  var output: NotificationsViewOutput!
  private let tableNode: ASTableNode = .init(style: .plain)
  
  private var contents: [NotificationContentable] = []
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    output.viewIsReady()
  }
  
  // MARK: NotificationsViewInput
  func setupInitialState(credential: Credential) {
    title = "Notifications"
    output.setupCredential(credential)
  }
  
  func reloadData(_ contents: [NotificationContentable]) {
    DispatchQueue.main.async { [weak self] in
      self?.contents = contents
      self?.tableNode.reloadData()
    }
  }
  
  func endRefresing() {
    DispatchQueue.main.async { [weak self] in
      self?.tableNode.view.refreshControl?.endRefreshing()
    }
  }
}

extension NotificationsViewController {
  private func setupUI() {
    titleLabel: do {
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
  }
  
  @objc private func pullToRefreshed(_ sender: UIRefreshControl) {
    output.pullToRefreshed()
  }
}

extension NotificationsViewController: ASTableDelegate, ASTableDataSource {
  func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
    return contents.count
  }
  
  func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
    return { [weak self] in
      guard let content = self?.contents[indexPath.row] else { preconditionFailure() }
      let node = NotificationCellNode(content: content)
      node.configure(isTop: indexPath.row == 0)
      return node
    }
  }
  
  func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
    tableNode.deselectRow(at: indexPath, animated: true)
  }
}

