//
//  PostComposer.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit
import UIKit

class PostComposer {
  static let shared = PostComposer()
  
  func publish(_ body: String, attachmentIDs: [String], credential: Credential) {
    Gab.default(with: credential).publish(body, mediaAttachments: attachmentIDs, success: { (postResponse) in
      InAppNotification.success("Post Completion", subtitle: postResponse.post.body)
    }) { (error) in
      InAppNotification.error(error)
    }
  }
  
  func quote(to postID: Int, body: String, attachmentIDs: [String], credential: Credential) {
    Gab.default(with: credential).createQuote(body,
                                              mediaAttachments: attachmentIDs,
                                              quotePostID: postID, success: { (postResponse) in
      InAppNotification.success("Post Completion", subtitle: postResponse.post.body)
    }) { (error) in
      InAppNotification.error(error)
    }
  }
  
  func reply(to postID: Int, body: String, attachmentIDs: [String], credential: Credential) {
    Gab.default(with: credential).createReply(body,
                                              mediaAttachments: attachmentIDs,
                                              replyTo: postID, success: { (postResponse) in
      InAppNotification.success("Post Completion", subtitle: postResponse.post.body)
    }) { (error) in
      InAppNotification.error(error)
    }
  }
  
  func upload(_ image: UIImage, credential: Credential, success: @escaping UploadSuccess) {
    Gab.default(with: credential).uploadImage(image, success: success) { (error) in
      InAppNotification.error(error)
    }
  }
}
