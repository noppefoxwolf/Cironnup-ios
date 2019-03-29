//
//  AttachmentCollectionDataSource.swift
//  CironnupUI
//
//  Created by Tomoya Hirano on 2018/10/27.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import DifferenceKit

internal final class AttachmentCollectionDataSource: NSObject,
  UICollectionViewDelegate,
  UICollectionViewDataSource {
  
  private weak var collectionView: UICollectionView? = nil
  internal weak var controlEventDelegate: AttachmentCollectionControlEventDelegate? = nil
  
  private var attachments: [AttachmentDisplayItem] = []
  
  public func reload(using attachments: [AttachmentDisplayItem]) {
    guard let collectionView = self.collectionView else { return }
    // setDataの中ではcontentSizeが未確定なので未来予知する
    let nextHeight: CGFloat
    switch attachments.count {
    case 0:
      nextHeight = 0
    case 1:
      nextHeight = attachments[0].imageRatio * collectionView.bounds.width
    default:
      nextHeight = AttachmentCollectionLayout.multipleItemHeight
    }
    
    let changeset = StagedChangeset(source: self.attachments, target: attachments)
    collectionView.reload(using: changeset, setData: { [weak self] (data) in
      if let constraint = collectionView.heightConstraint {
        constraint.constant = nextHeight
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
          self?.collectionView?.layoutIfNeeded()
        })
      }
      self?.attachments = data
    })
  }
  
  public init(with collectionView: UICollectionView) {
    super.init()
    let layout = AttachmentCollectionLayout()
    layout.delegate = self
    self.collectionView = collectionView
    collectionView.register(AttachmentCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.setCollectionViewLayout(layout, animated: false)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AttachmentCollectionViewCell
    let attachment = attachments[indexPath.row]
    cell.configure(image: attachment.image)
    cell.configure(attributedString: attachment.status)
    cell.didTap = { [weak self] in
      guard let indexPath = collectionView.indexPath(for: cell) else { return }
      self?.controlEventDelegate?.tappedAttachmentRemoveButton(at: indexPath)
    }
    return cell
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return attachments.count
  }
}

extension AttachmentCollectionDataSource: AttachmentCollectionLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, ratioForItemAt indexPath: IndexPath) -> CGFloat {
    return attachments[indexPath.row].imageRatio
  }
}
