//
//  Attachment.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/15.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

class LocalAttachment {
  enum Status {
    case standby
    case uploaded(id: String)
    
    var message: String? {
      switch self {
      case .standby: return "Uploading"
      case .uploaded(_): return nil
      }
    }
  }
  let status: Status
  var attachmentID: String? {
    switch status {
    case .uploaded(let id): return id
    default: return nil
    }
  }
  let id: String
  let image: UIImage
  
  init(id: String, image: UIImage) {
    self.id = id
    self.status = .standby
    self.image = image
  }
  
  init(id: String, attachmentID: String, image: UIImage) {
    self.id = id
    self.status = .uploaded(id: attachmentID)
    self.image = image
  }
}
