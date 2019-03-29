//
//  GroupViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import CironnupKit
import GabKit
import Reusable

class GroupViewController: UIViewController, GroupViewInput {
  
  var output: GroupViewOutput!
  private var groups: [Group] = []
  private lazy var collectionView: UICollectionView = { preconditionFailure() }()
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  // MARK: GroupViewInput
  func setupInitialState(account: Account) {
    title = "Joined groups"
    output?.setupAccount(account)
  }
  
  func setupUI() {
    title: do {
      let label = UILabel()
      label.attributedText = title?.withFont(.boldSystemFont(ofSize: 16)).withTextColor(.white)
      navigationItem.titleView = label
    }
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 20.0
    layout.minimumLineSpacing = 20.0
    layout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = ColorName.backgroundColor.color
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(cellType: GroupCollectionViewCell.self)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    
    let refreshControl = UIRefreshControl()
    refreshControl.addAction(for: .valueChanged) { [weak self] in
      self?.output.pullToRefreshed()
    }
    collectionView.refreshControl = refreshControl
  }
  
  func reload(groups: [Group]) {
    DispatchQueue.main.async { [weak self] in
      self?.groups = groups
      self?.collectionView.reloadData()
      self?.collectionView.refreshControl?.endRefreshing()
    }
  }
}

extension GroupViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GroupCollectionViewCell.self)
    let group = groups[indexPath.row]
    cell.configure(title: group.title)
    cell.configure(coverImage: group.coverUrl)
    cell.configure(isNSFW: group.title.contains("NSFW"))
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let group = groups[indexPath.row]
    output.didSelectGroup(id: group.id)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let space: CGFloat = 20.0
    let column: Int = 2
    let width = (collectionView.bounds.width - space * CGFloat(column + 1)) / CGFloat(column)
    return CGSize(width: width, height: width * 0.75)
  }
}

