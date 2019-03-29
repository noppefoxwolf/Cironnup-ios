//
//  Attachment.swift
//  CironnupUI
//
//  Created by Tomoya Hirano on 2018/10/27.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import DifferenceKit

public class AttachmentDisplayItem {
  public let id: String
  public let image: UIImage
  public let status: NSAttributedString?
  
  public init(id: String, image: UIImage, status: NSAttributedString?) {
    self.id = id
    self.image = image
    self.status = status
  }
}

extension AttachmentDisplayItem {
  internal var imageRatio: CGFloat {
    return image.size.height / image.size.width
  }
}

extension Differentiable where Self: AttachmentDisplayItem {
  public var differenceIdentifier: String {
    return id
  }
  
  public func isContentEqual(to source: Self) -> Bool {
    guard id == source.id else { return false }
    guard image == source.image else { return false }
    guard status == source.status else { return false }
    return true
  }
}

extension AttachmentDisplayItem: Differentiable {}
