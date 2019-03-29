//
//  Post+DifferenceKit.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/11/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import DifferenceKit
import GabKit

extension PostResponse: Differentiable {
  public typealias DifferenceIdentifier = String
  
  public var differenceIdentifier: String {
    return id
  }
  
  public func isContentEqual(to source: PostResponse) -> Bool {
    return self == source
  }
}
