//
//  AttachmentCollectionLayout.swift
//  CironnupUI
//
//  Created by Tomoya Hirano on 2018/10/27.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

internal protocol AttachmentCollectionLayoutDelegate: class {
  func collectionView(_ collectionView: UICollectionView, ratioForItemAt indexPath: IndexPath) -> CGFloat
}

internal final class AttachmentCollectionLayout: UICollectionViewLayout {
  static let multipleItemHeight: CGFloat = 208
  let spacing: CGFloat = 8.0
  var attributesArray = [UICollectionViewLayoutAttributes]()
  weak var delegate: AttachmentCollectionLayoutDelegate? = nil
  
  override public var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else { return .zero }
    let itemCount = collectionView.numberOfItems(inSection: 0)
    switch itemCount {
    case 0: return .zero
    case 1: return attributesArray[0].frame.size
    default:
      var width = attributesArray.map({ $0.frame.width }).reduce(CGFloat(), +)
      width += CGFloat(attributesArray.count - 1) * spacing
      return CGSize(width: width, height: AttachmentCollectionLayout.multipleItemHeight)
    }
  }
  
  public override func prepare() {
    attributesArray = []
    guard attributesArray.isEmpty else { return }
    guard let collectionView = collectionView else { return }
    guard let delegate = delegate else { return }
    let itemCount = collectionView.numberOfItems(inSection: 0)
    switch itemCount {
    case 0: break
    case 1:
      let indexPath = IndexPath(row: 0, section: 0)
      let ratio = delegate.collectionView(collectionView, ratioForItemAt: indexPath)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = CGRect(x: 0,
                                y: 0,
                                width: collectionView.bounds.width,
                                height: collectionView.bounds.width * ratio)
      attributesArray.append(attributes)
    default:
      let indexPathes = (0..<itemCount).map({ IndexPath(row: $0, section: 0) })
      var offsetX: CGFloat = 0.0
      for indexPath in indexPathes {
        let ratio = delegate.collectionView(collectionView, ratioForItemAt: indexPath)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let width = AttachmentCollectionLayout.multipleItemHeight / ratio
        attributes.frame = CGRect(x: offsetX,
                                  y: 0,
                                  width: width,
                                  height: AttachmentCollectionLayout.multipleItemHeight)
        attributesArray.append(attributes)
        
        offsetX += (width + spacing)
      }
    }
  }
  
  public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in attributesArray {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
}
