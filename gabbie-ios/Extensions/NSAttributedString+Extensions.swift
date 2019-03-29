//
//  NSAttributedString+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/24.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

// Custom Operator
public func + (lhs: NSMutableAttributedString, rhs: NSMutableAttributedString) -> NSMutableAttributedString {
  lhs.append(rhs)
  return lhs
}

extension String {
  func append(_ image: UIImage, bounds: CGRect) -> NSMutableAttributedString {
    return attributedString.append(image, bounds: bounds)
  }
}

// Custom Initializer
extension NSMutableAttributedString {
  convenience init(space: CGFloat) {
    let attachment = NSTextAttachment()
    attachment.bounds = .init(x: 0, y: 0, width: space, height: space)
    self.init(attachment: attachment)
  }
}

extension NSMutableAttributedString {
  func append(_ image: UIImage, bounds: CGRect) -> NSMutableAttributedString {
    let attachment = NSTextAttachment()
    attachment.image = image
    attachment.bounds = bounds
    append(.init(attachment: attachment))
    return self
  }
  
  func append(_ string: String) -> NSMutableAttributedString {
    append(.init(string: string))
    return self
  }
  
  func append(space: CGFloat) -> NSMutableAttributedString {
    append(NSMutableAttributedString(space: space))
    return self
  }
}

