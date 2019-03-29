//
//  AttachmentCollectionView.swift
//  CironnupUI
//
//  Created by Tomoya Hirano on 2018/10/26.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import DifferenceKit

public protocol AttachmentCollectionControlEventDelegate: class {
  func tappedAttachmentRemoveButton(at indexPath: IndexPath)
}

public final class AttachmentCollectionView: UICollectionView {
  private lazy var _dataSource: AttachmentCollectionDataSource = .init(with: self)
  public var controlEventDelegate: AttachmentCollectionControlEventDelegate? {
    get { return _dataSource.controlEventDelegate }
    set { _dataSource.controlEventDelegate = newValue }
  }
  
  public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    setup()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    _ = _dataSource
  }
  
  public func reload(using attachments: [AttachmentDisplayItem]) {
    _dataSource.reload(using: attachments)
  }
}
