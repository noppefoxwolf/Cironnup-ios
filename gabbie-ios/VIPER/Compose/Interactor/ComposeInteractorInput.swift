//
//  ComposeInteractorInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit
import Photos

protocol ComposeInteractorInput {
  func publish(_ body: String, attachmentIDs: [String], credential: Credential)
  func reply(to postID: Int, body: String, attachmentIDs: [String], credential: Credential)
  func quote(to postID: Int, body: String, attachmentIDs: [String], credential: Credential)
  func upload(with id: String, image: UIImage, credential: Credential)
  func retrieve(_ assets: [PHAsset])
  func compless(_ image: UIImage)
  func fetchNowplayingItem()
}
