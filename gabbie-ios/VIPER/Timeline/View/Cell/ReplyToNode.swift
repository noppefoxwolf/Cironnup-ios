//
//  ReplyToNode.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/24.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import AsyncDisplayKit

final class ReplyToNode: ASTextNode {
  init(replyTo username: String) {
    super.init()
    attributedText = "Replying to @\(username)".withFont(.systemFont(ofSize: 14)).withTextColor(.lightGray)
  }
}
